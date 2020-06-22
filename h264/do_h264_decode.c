//============================================================================//
//    H.264 High Level Synthesis Benchmark
//    Copyright (c) <2016>
//    <University of Illinois at Urbana-Champaign>
//    All rights reserved.
//
//    Developed by:
//
//    <ES CAD Group>
//        <University of Illinois at Urbana-Champaign>
//        <http://dchen.ece.illinois.edu/>
//
//    <Hardware Research Group>
//        <Advanced Digital Sciences Center>
//        <http://adsc.illinois.edu/>
//============================================================================//

#include <string.h>

#include "global.h"
#include "nalu.h"
#include "decode.h"



#if _N_HLS_
extern FILE *prediction_test;
extern FILE* construction_test;
extern FILE *trace_bit;
extern FILE* debug_test;
#endif

FILE *bitstr;
FILE *p_out;
StorablePicture Pic[MAX_REFERENCE_PICTURES];
StorablePictureInfo Pic_info[MAX_REFERENCE_PICTURES];


unsigned do_h264_decode_invokes = 0;

NALU_t PINGPONGbuffer[MAX_H264_DECODE_PASSES];

void write_out_pic(StorablePicture *pic,FILE * p_out)
{
  int i,j;

  for(i=0;i<FrameHeightInSampleL;i++)
    for(j=0; j<PicWidthInSamplesL; j++)
    {
      fputc(pic->Sluma[j][i],p_out);
    }
  for(i=0;i<FrameHeightInSampleC;i++)
    for(j=0; j<PicWidthInSamplesC; j++)
    {
      fputc(pic->SChroma_0[j][i],p_out);
    }
  for(i=0;i<FrameHeightInSampleC;i++)
    for(j=0 ;j <PicWidthInSamplesC ;  j++)
    {
      fputc(pic->SChroma_1[j][i],p_out);
    }

}


void do_h264_decode(int argc, char **argv)
{
  char AnnexbFileName[100];
  do_h264_decode_invokes++;

  if(argc != 3)
  {
    puts("Too much argument!");
    exit(-1);
  }


  if(argc == 3)
  {
    sprintf(AnnexbFileName, "%s", argv[1]);
  }
  else
    strcpy(AnnexbFileName,"input/test.264");


  bitstr=fopen(AnnexbFileName,"rb");
  if(bitstr==NULL)
  {
    puts("cannot find the corresponding file.");
    exit(-1);
  }

#if _N_HLS_
  prediction_test=fopen("pred_test.txt","w");
  construction_test=fopen("construc_test.txt","w");
  trace_bit=fopen("trace.txt","w");
  debug_test=fopen("debug_test.txt","w");
#endif


  p_out=fopen("testresult.yuv","wb");

  for (int i = 0; i < MAX_H264_DECODE_PASSES; i++) { 
    PINGPONGbuffer[i].nal_unit_type=0;
    printf(" initializing PPB %u\n", i);
    if (GetAnnexbNALU (&PINGPONGbuffer[i], bitstr)==0) {
      printf("ERROR : Only got to %u out of %u H264_DECODE_PASSES\n", i, MAX_H264_DECODE_PASSES);
      exit(-1);
    }

    PINGPONGbuffer[i].len = EBSPtoRBSP (PINGPONGbuffer[i].buf, PINGPONGbuffer[i].len, 1);
    RBSPtoSODB(&PINGPONGbuffer[i],PINGPONGbuffer[i].len-1);
    printf("  On while %u : PPB.len = %u\n", i, PINGPONGbuffer[i].len);
  }

  memset(Pic, 0, MAX_REFERENCE_PICTURES*sizeof(StorablePicture));
  memset(Pic_info, 0, MAX_REFERENCE_PICTURES*sizeof(StorablePictureInfo));

  int i=0;
  int j;
  int poc=0;

  printf("In do_h264_decode invocation %u\n", do_h264_decode_invokes);
  //unsigned while_iter = 0;
  //while(1)
  for (int pass = 0; pass < MAX_H264_DECODE_PASSES; pass++) {
    printf(" do_h264_decode invocation %u while %u\n", do_h264_decode_invokes, pass); //while_iter);
    /*
      if (GetAnnexbNALU (&PINGPONGbuffer,bitstr)==0) {
      printf("  doing the break...\n");
      break;
      }
      
      PINGPONGbuffer.len = EBSPtoRBSP (PINGPONGbuffer.buf, PINGPONGbuffer.len, 1);
      RBSPtoSODB(&PINGPONGbuffer,PINGPONGbuffer.len-1);
      printf("  On while %u : PPB.len = %u\n", while_iter, PINGPONGbuffer.len);
    */

    decode_main(&PINGPONGbuffer[pass],Pic,Pic_info);


    if (PINGPONGbuffer[pass].nal_unit_type==5 || PINGPONGbuffer[pass].nal_unit_type==1 ) {
      printf(" ...Checking for writing...\n");
      for(j=0;j<MAX_REFERENCE_PICTURES;j++) {
        for(i=0;i<MAX_REFERENCE_PICTURES;i++) {
          if(Pic[i].memoccupied && Pic[i].Picorder_num==poc) {
            write_out_pic(&Pic[i],p_out);
            printf("writing %d\n",poc );
            poc++;
          }
        }
      }
    }
    //while_iter++;
  }


  do_h264_decode_invokes++;


#if _N_HLS_
  fclose(prediction_test);
  fclose(construction_test);
  fclose(trace_bit);
  fclose(debug_test);
#endif
  fclose(bitstr);
  fclose(p_out);

  sprintf(AnnexbFileName,"diff -q testresult.yuv %s",argv[2]);

  if (!system(AnnexbFileName))
    printf("PASSED\n");
  else
    printf("FAILED\n");

  return;
}
