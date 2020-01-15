CC = gcc
MFILE = Makefile

COPTF0 = -O0
COPTF2 = -O2
COPTF3 = -O3

CFLAGS = -pedantic -Wall -g $(COPTF2)
#CFLAGS += -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -lpython2.7 -lpthread -ldl  -lutil -lm  -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions
CFLAGS +=  -Xlinker -export-dynamic

INCLUDES =
#PYTHONINCLUDES = $(shell /usr/bin/python-config --cflags)
PYTHONINCLUDES = -I/usr/include/python3.6m
LFLAGS = -Lviterbi -Lradar 
#LFLAGS += 
#LIBS = -lviterbi -lfmcwdist -lpthread -ldl -lutil -lm -lpython2.7
LIBS     = -lviterbi -lfmcwdist -lpthread -ldl -lutil -lm
LIBSG    = -lviterbi_gp -lfmcwdist_gp -lpthread -ldl -lutil -lm
LIBS_IT  = -lviterbi_t -lfmcwdist_t -lpthread -ldl -lutil -lm
FLIBS    = -lviterbiF -lfmcwdist -lpthread -ldl -lutil -lm
FLIBS_IT = -lviterbiF_t -lfmcwdist_t -lpthread -ldl -lutil -lm
#PYTHONLIBS = $(shell /usr/bin/python-config --ldflags)
PYTHONLIBS = -lpython3.6m

OBJDIR = obj
C_OBJDIR = obj_c
FC_OBJDIR = obj_fc

IT_OBJDIR   = obj_it
ITC_OBJDIR  = obj_itc
ITFC_OBJDIR = obj_itfc

OBJ_V_DIR = obj_v
C_OBJ_V_DIR = obj_cv
FC_OBJ_V_DIR = obj_fcv

OBJ_G_DIR = obj_gp
C_OBJ_G_DIR = obj_cgp


S_OBJDIR    = objs
C_S_OBJDIR  = objs_c
FC_S_OBJDIR = objs_fc

ITS_OBJDIR     = objs_it
ITC_S_OBJDIR   = objs_itc
ITFC_S_OBJDIR  = objs_itfc

S_OBJ_V_DIR    = objs_v
C_S_OBJ_V_DIR  = objs_cv
FC_S_OBJ_V_DIR = objs_fcv

S_OBJ_G_DIR   = objs_gp
C_S_OBJ_G_DIR = objs_cgp


# The full mini-era target, etc.
TARGET = main
SRC    = kernels_api.c main.c
T_SRC  = $(SRC) read_trace.c
OBJ    = $(T_SRC:%.c=$(OBJDIR)/%.o)
OBJ_V  = $(T_SRC:%.c=$(OBJ_V_DIR)/%.o)
OBJ_G  = $(T_SRC:%.c=$(OBJ_G_DIR)/%.o)

#T_TARGET = t-main
SRC2     = kernels_api.c tmain.c
T_SRC2   = $(SRC2) read_trace.c
T_OBJ     = $(T_SRC2:%.c=$(OBJDIR)/%.o)
T_OBJ_V   = $(T_SRC2:%.c=$(OBJ_V_DIR)/%.o)
T_OBJ_G   = $(T_SRC2:%.c=$(OBJ_G_DIR)/%.o)

#IT_TARGET = t-main
IT_SRC    = $(SRC2) read_trace.c
IT_OBJ    = $(IT_SRC:%.c=$(IT_OBJDIR)/%.o)


S_TARGET = sim_main
S_SRC    = $(SRC) sim_environs.c
S_OBJ    = $(S_SRC:%.c=$(S_OBJDIR)/%.o)
S_OBJ_V  = $(S_SRC:%.c=$(S_OBJ_V_DIR)/%.o)
S_OBJ_G  = $(S_SRC:%.c=$(S_OBJ_G_DIR)/%.o)

TS_TARGET = t-sim_main
TS_SRC    = $(SRC2) sim_environs.c
TS_OBJ    = $(TS_SRC:%.c=$(S_OBJDIR)/%.o)
TS_OBJ_V  = $(TS_SRC:%.c=$(S_OBJ_V_DIR)/%.o)
TS_OBJ_G  = $(TS_SRC:%.c=$(S_OBJ_G_DIR)/%.o)

# The C-code only target (it bypasses KERAS Python code)
C_TARGET = cmain
C_OBJ    = $(T_SRC:%.c=$(C_OBJDIR)/%.o)
C_OBJ_V  = $(T_SRC:%.c=$(C_OBJ_V_DIR)/%.o)
C_OBJ_G  = $(T_SRC:%.c=$(C_OBJ_G_DIR)/%.o)
FC_OBJ   = $(T_SRC:%.c=$(FC_OBJDIR)/%.o)
FC_OBJ_V = $(T_SRC:%.c=$(FC_OBJ_V_DIR)/%.o)
ITC_OBJ  = $(IT_SRC:%.c=$(ITC_OBJDIR)/%.o)
ITFC_OBJ = $(IT_SRC:%.c=$(ITFC_OBJDIR)/%.o)

#TC_TARGET = t-cmain
TC_OBJ    = $(T_SRC2:%.c=$(C_OBJDIR)/%.o)
TC_OBJ_V  = $(T_SRC2:%.c=$(C_OBJ_V_DIR)/%.o)
TC_OBJ_G  = $(T_SRC2:%.c=$(C_OBJ_G_DIR)/%.o)
TFC_OBJ   = $(T_SRC2:%.c=$(FC_OBJDIR)/%.o)
TFC_OBJ_V = $(T_SRC2:%.c=$(FC_OBJ_V_DIR)/%.o)

#$(info $$SRC2 is [${SRC2}])
#$(info $$T_SRC2 is [${T_SRC2}])
#$(info $$TC_OBJ is [${TC_OBJ}])

C_S_TARGET = csim_main
C_S_OBJ = $(S_SRC:%.c=$(C_S_OBJDIR)/%.o)
C_S_OBJ_V = $(S_SRC:%.c=$(C_S_OBJ_V_DIR)/%.o)
C_S_OBJ_G = $(S_SRC:%.c=$(C_S_OBJ_G_DIR)/%.o)
FC_S_OBJ = $(S_SRC:%.c=$(FC_S_OBJDIR)/%.o)
FC_S_OBJ_V = $(S_SRC:%.c=$(FC_S_OBJ_V_DIR)/%.o)

#TC_S_TARGET = t-csim_main
TC_S_OBJ    = $(TS_SRC:%.c=$(C_S_OBJDIR)/%.o)
TC_S_OBJ_V  = $(TS_SRC:%.c=$(C_S_OBJ_V_DIR)/%.o)
TFC_S_OBJ   = $(TS_SRC:%.c=$(FC_S_OBJDIR)/%.o)
TFC_S_OBJ_V = $(TS_SRC:%.c=$(FC_S_OBJ_V_DIR)/%.o)

ITS_OBJ     = $(TS_SRC:%.c=$(ITS_OBJDIR)/%.o)
ITC_S_OBJ   = $(TS_SRC:%.c=$(ITC_S_OBJDIR)/%.o)
ITFC_S_OBJ  = $(TS_SRC:%.c=$(ITFC_S_OBJDIR)/%.o)

TRGN_SRC = sim_environs.c
TRGN_OBJ = $(TRGN_SRC:%.c=obj/%.o)
TRGN_OBJ_V = $(TRGN_SRC:%.c=obj_v/%.o)

G_SRC 	= utils/gen_trace.c
G_OBJ	= $(G_SRC:%.c=obj/%.o)

$(TARGET): $(OBJDIR)  $(OBJ) libviterbi libfmcwdist
	$(CC) $(OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

t-$(TARGET): $(OBJDIR)  $(T_OBJ) libviterbi libfmcwdist
	$(CC) $(T_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

it-$(TARGET): $(IT_OBJDIR)  $(IT_OBJ) libviterbi_t libfmcwdist_t
	$(CC) $(IT_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS_IT) $(PYTHONLIBS)

f$(TARGET): $(OBJDIR)  $(OBJ) libviterbiF libfmcwdist
	$(CC) $(OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

t-f$(TARGET): $(OBJDIR)  $(T_OBJ) libviterbiF libfmcwdist
	$(CC) $(T_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

it-f$(TARGET): $(OBJDIR)  $(IT_OBJ) libviterbiF libfmcwdist
	$(CC) $(IT_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

$(C_TARGET): $(C_OBJDIR) $(C_OBJ) libviterbi libfmcwdist
	$(CC) $(C_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

t-$(C_TARGET): $(C_OBJDIR) $(TC_OBJ) libviterbi libfmcwdist
	$(CC) $(TC_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

it-$(C_TARGET): $(ITC_OBJDIR) $(ITC_OBJ) libviterbi_t libfmcwdist_t
	$(CC) $(ITC_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS_IT) $(PYTHONLIBS)

f$(C_TARGET): $(FC_OBJDIR) $(FC_OBJ) libviterbiF libfmcwdist
	$(CC) $(FC_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

t-f$(C_TARGET): $(FC_OBJDIR) $(TFC_OBJ) libviterbiF libfmcwdist
	$(CC) $(TFC_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

it-f$(C_TARGET): $(ITFC_OBJDIR) $(ITFC_OBJ) libviterbiF_t libfmcwdist_t
	$(CC) $(ITFC_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS_IT) $(PYTHONLIBS)

v$(TARGET): $(OBJ_V_DIR) $(OBJ_V) libviterbi libfmcwdist
	$(CC) $(OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

v$(C_TARGET): $(C_OBJ_V_DIR) $(C_OBJ_V) libviterbi libfmcwdist
	$(CC) $(C_OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

vf$(C_TARGET): $(FC_OBJ_V_DIR) $(FC_OBJ_V) libviterbiF libfmcwdist
	$(CC) $(FC_OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)



gp_$(TARGET): $(OBJ_G_DIR) $(OBJ_G) libviterbi_gp libfmcwdist
	$(CC) $(OBJ_G) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -pg -o $@.exe $(LFLAGS) $(LIBSG) $(PYTHONLIBS)

gp_$(C_TARGET): $(C_OBJ_G_DIR) $(C_OBJ_G) libviterbi_gp libfmcwdist
	$(CC) $(C_OBJ_G) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -pg -o $@.exe $(LFLAGS) $(LIBSG) $(PYTHONLIBS)


$(S_TARGET): $(S_OBJDIR)  $(S_OBJ) libviterbi libfmcwdist
	$(CC) $(S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

t-$(S_TARGET): $(S_OBJDIR)  $(TS_OBJ) libviterbi_t libfmcwdist_t
	$(CC) $(TS_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS_IT) $(PYTHONLIBS)

it-$(S_TARGET): $(ITS_OBJDIR)  $(ITS_OBJ) libviterbi_t libfmcwdist_t
	$(CC) $(ITS_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS_IT) $(PYTHONLIBS)

$(C_S_TARGET): $(C_S_OBJDIR) $(C_S_OBJ) libviterbi libfmcwdist
	$(CC) $(C_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

f$(C_S_TARGET): $(FC_S_OBJDIR) $(FC_S_OBJ) libviterbi libfmcwdist
	$(CC) $(FC_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

t-$(C_S_TARGET): $(C_S_OBJDIR) $(TC_S_OBJ) libviterbi libfmcwdist
	$(CC) $(TC_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

t-f$(C_S_TARGET): $(FC_S_OBJDIR) $(TFC_S_OBJ) libviterbiF libfmcwdist
	$(CC) $(TFC_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

it-$(C_S_TARGET): $(ITC_S_OBJDIR) $(ITC_S_OBJ) libviterbi_t libfmcwdist_t
	$(CC) $(ITC_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS_IT) $(PYTHONLIBS)

it-f$(C_S_TARGET): $(ITFC_S_OBJDIR) $(ITFC_S_OBJ) libviterbiF_t libfmcwdist_t
	$(CC) $(ITFC_S_OBJ) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS_IT) $(PYTHONLIBS)

v$(S_TARGET): $(S_OBJ_V_DIR) $(S_OBJ_V) libviterbi libfmcwdist
	$(CC) $(S_OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

v$(C_S_TARGET): $(C_S_OBJ_V_DIR) $(C_S_OBJ_V) libviterbi libfmcwdist
	$(CC) $(C_S_OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(LIBS) $(PYTHONLIBS)

vf$(C_S_TARGET): $(FC_S_OBJ_V_DIR) $(FC_S_OBJ_V) libviterbi libfmcwdist
	$(CC) $(FC_S_OBJ_V) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -o $@.exe $(LFLAGS) $(FLIBS) $(PYTHONLIBS)

gp_$(S_TARGET): $(S_OBJ_G_DIR) $(S_OBJ_G) libviterbi_gp libfmcwdist
	$(CC) $(S_OBJ_G) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -pg -o $@.exe $(LFLAGS) $(LIBSG) $(PYTHONLIBS)

gp_$(C_S_TARGET): $(C_S_OBJ_G_DIR) $(C_S_OBJ_G) libviterbi_gp libfmcwdist
	$(CC) $(C_S_OBJ_G) $(CFLAGS) $(INCLUDES) $(PYTHONINCLUDES) -pg -o $@.exe $(LFLAGS) $(LIBSG) $(PYTHONLIBS)



trace: objdirs $(TARGET) t-$(TARGET) it-$(TARGET) $(C_TARGET) f$(C_TARGET) t-$(C_TARGET) it-$(C_TARGET) t-f$(C_TARGET) it-f$(C_TARGET) v$(TARGET) v$(C_TARGET) vf$(C_TARGET) 

sim: objdirs $(S_TARGET) t-$(S_TARGET) it-$(S_TARGET) $(C_S_TARGET) f$(C_S_TARGET) t-$(C_S_TARGET) it-$(C_S_TARGET) t-f$(C_S_TARGET) it-f$(C_S_TARGET) v$(TARGET) v$(C_S_TARGET) vf$(C_S_TARGET)


all: objdirs trace sim util_prog


objdirs: $(OBJDIR) $(C_OBJDIR) $(FC_OBJDIR) $(IT_OBJDIR) $(ITC_OBJDIR) $(ITFC_OBJDIR) $(OBJ_V_DIR) $(C_OBJ_V_DIR) $(FC_OBJ_V_DIR) $(OBJ_G_DIR) $(C_OBJ_G_DIR) $(S_OBJDIR) $(C_S_OBJDIR) $(FC_S_OBJDIR) $(ITS_OBJDIR) $(ITC_S_OBJDIR) $(ITFC_S_OBJDIR) $(S_OBJ_V_DIR) $(C_S_OBJ_V_DIR) $(FC_S_OBJ_V_DIR) $(S_OBJ_G_DIR) $(C_S_OBJ_G_DIR)



util_prog:
	cd utils; make -f $(MFILE) all

test: 
	cd utils; make -f $(MFILE) test

vtest: 
	cd utils; make -f $(MFILE) vtest

tracegen: 
	cd utils; make -f $(MFILE) tracegen

libviterbi:
	cd viterbi; make -f $(MFILE) lib

libviterbiF:
	cd viterbi; make -f $(MFILE) lib

libviterbi_gp:
	cd viterbi; make -f $(MFILE) lib

libviterbi_t:
	cd viterbi; make -f $(MFILE) lib

libviterbiF_t:
	cd viterbi; make -f $(MFILE) lib

libfmcwdist:
	cd radar; make -f $(MFILE)

libfmcwdist_gp:
	cd radar; make -f $(MFILE)

libfmcwdist_t:
	cd radar; make -f $(MFILE)


$(OBJDIR):
	mkdir $@

$(C_OBJDIR):
	mkdir $@

$(FC_OBJDIR):
	mkdir $@

$(OBJ_V_DIR):
	mkdir $@

$(C_OBJ_V_DIR):
	mkdir $@

$(FC_OBJ_V_DIR):
	mkdir $@

$(OBJ_G_DIR):
	mkdir $@

$(C_OBJ_G_DIR):
	mkdir $@

$(S_OBJDIR):
	mkdir $@

$(C_S_OBJDIR):
	mkdir $@

$(FC_S_OBJDIR):
	mkdir $@

$(S_OBJ_V_DIR):
	mkdir $@

$(C_S_OBJ_V_DIR):
	mkdir $@

$(FC_S_OBJ_V_DIR):
	mkdir $@

$(S_OBJ_G_DIR):
	mkdir $@

$(C_S_OBJ_G_DIR):
	mkdir $@

$(IT_OBJDIR):
	mkdir $@

$(ITC_OBJDIR):
	mkdir $@

$(ITFC_OBJDIR):
	mkdir $@

$(ITS_OBJDIR):
	mkdir $@

$(ITC_S_OBJDIR):
	mkdir $@

$(ITFC_S_OBJDIR):
	mkdir $@



$(OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -o $@ $(PYTHONLIBS) -c $<

$(IT_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -o $@ $(PYTHONLIBS) -c $<

$(OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DVERBOSE -o $@ $(PYTHONLIBS) -c $<

$(C_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(ITC_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(OBJ_G_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -g -pg -o $@ $(PYTHONLIBS) -c $<

$(C_OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DVERBOSE -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(C_OBJ_G_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DBYPASS_KERAS_CV_CODE -g -pg -o $@ $(PYTHONLIBS) -c $<

$(FC_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(ITFC_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(FC_OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DVERBOSE -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<


$(S_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -o $@ $(PYTHONLIBS) -c $<

$(ITS_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -DUSE_SIM_ENVIRON -o $@ $(PYTHONLIBS) -c $<

$(S_OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DVERBOSE -o $@ $(PYTHONLIBS) -c $<

$(S_OBJ_G_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -g -pg -o $@ $(PYTHONLIBS) -c $<

$(C_S_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(ITC_S_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -DUSE_SIM_ENVIRON -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(C_S_OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DVERBOSE -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(C_S_OBJ_G_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DBYPASS_KERAS_CV_CODE -g -pg -o $@ $(PYTHONLIBS) -c $<

$(FC_S_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(ITFC_S_OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DINT_TIME -DUSE_SIM_ENVIRON -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<

$(FC_S_OBJ_V_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(PYTHONINCLUDES) -DUSE_SIM_ENVIRON -DVERBOSE -DBYPASS_KERAS_CV_CODE -o $@ $(PYTHONLIBS) -c $<



clean:
	$(RM) $(TARGET).exe $(OBJ)
	$(RM) t-$(TARGET).exe $(T_OBJ)
	$(RM) it-$(TARGET).exe $(IT_OBJ)
	$(RM) $(C_TARGET).exe $(C_OBJ)
	$(RM) t-$(C_TARGET).exe $(TC_OBJ)
	$(RM) it-$(C_TARGET).exe $(ITC_OBJ)
	$(RM) f$(C_TARGET).exe $(FC_OBJ)
	$(RM) t-f$(C_TARGET).exe $(TFC_OBJ)
	$(RM) it-f$(C_TARGET).exe $(ITFC_OBJ)
	$(RM) t-f$(TARGET).exe $(TF_OBJ)
	$(RM) v$(TARGET).exe $(OBJ_V)
	$(RM) v$(C_TARGET).exe $(C_OBJ_V)
	$(RM) vf$(C_TARGET).exe $(FC_OBJ_V)
	$(RM) gp_$(TARGET).exe $(OBJ_G)
	$(RM) gp_$(C_TARGET).exe $(C_OBJ_G)
	$(RM) $(S_TARGET).exe $(S_OBJ)
	$(RM) t-$(S_TARGET).exe $(TS_OBJ)
	$(RM) it-$(S_TARGET).exe $(ITS_OBJ)
	$(RM) $(C_S_TARGET).exe $(C_S_OBJ)
	$(RM) f$(C_S_TARGET).exe $(FC_S_OBJ)
	$(RM) t-$(C_S_TARGET).exe $(TC_S_OBJ)
	$(RM) t-f$(C_S_TARGET).exe $(TFC_S_OBJ)
	$(RM) it-$(C_S_TARGET).exe $(ITC_S_OBJ)
	$(RM) it-f$(C_S_TARGET).exe $(ITFC_S_OBJ)
	$(RM) v$(S_TARGET).exe $(S_OBJ_V)
	$(RM) vf$(S_TARGET).exe $(FS_OBJ_V)
	$(RM) v$(C_S_TARGET).exe $(C_S_OBJ_V)
	$(RM) vf$(C_S_TARGET).exe $(FC_S_OBJ_V)
	$(RM) gp_$(S_TARGET).exe $(S_OBJ_G)
	$(RM) gp_$(C_S_TARGET).exe $(C_S_OBJ_G)
	$(RM) test  $(TRGN_OBJ)
	$(RM) tracegen  $(G_OBJ)

allclean: clean
	$(RM) -rf $(OBJDIR)
	$(RM) -rf $(OBJ_V_DIR)
	$(RM) -rf $(OBJ_G_DIR)
	$(RM) -rf $(C_OBJDIR)
	$(RM) -rf $(C_OBJ_V_DIR)
	$(RM) -rf $(C_OBJ_G_DIR)
	$(RM) -rf $(S_OBJDIR)
	$(RM) -rf $(S_OBJ_V_DIR)
	$(RM) -rf $(S_OBJ_G_DIR)
	$(RM) -rf $(C_S_OBJDIR)
	$(RM) -rf $(C_S_OBJ_V_DIR)
	$(RM) -rf $(C_S_OBJ_G_DIR)
	cd utils; make -f $(MFILE) allclean
	cd radar; make -f $(MFILE) clean
	cd viterbi; make -f $(MFILE) clean


$(OBJDIR)/kernels_api.o: kernels_api.h read_trace.h
$(OBJDIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(OBJDIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(OBJDIR)/read_trace.o: kernels_api.h read_trace.h

$(C_OBJDIR)/kernels_api.o: kernels_api.h read_trace.h
$(C_OBJDIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(C_OBJDIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(C_OBJDIR)/read_trace.o: kernels_api.h read_trace.h

$(OBJ_V_DIR)/kernels_api.o: kernels_api.h read_trace.h
$(OBJ_V_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(OBJ_V_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(OBJ_V_DIR)/read_trace.o: kernels_api.h read_trace.h

$(C_OBJ_V_DIR)/kernels_api.o: kernels_api.h read_trace.h
$(C_OBJ_V_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(C_OBJ_V_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(C_OBJ_V_DIR)/read_trace.o: kernels_api.h read_trace.h

$(OBJ_G_DIR)/kernels_api.o: kernels_api.h read_trace.h
$(OBJ_G_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(OBJ_G_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(OBJ_G_DIR)/read_trace.o: kernels_api.h read_trace.h

$(C_OBJ_G_DIR)/kernels_api.o: kernels_api.h read_trace.h
$(C_OBJ_G_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(C_OBJ_G_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(C_OBJ_G_DIR)/read_trace.o: kernels_api.h read_trace.h


$(S_OBJDIR)/kernels_api.o: kernels_api.h sim_environs.h
$(S_OBJDIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(S_OBJDIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(S_OBJDIR)/sim_environs.o: kernels_api.h sim_environs.h

$(C_S_OBJDIR)/kernels_api.o: kernels_api.h sim_environs.h
$(C_S_OBJDIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(C_S_OBJDIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(C_S_OBJDIR)/sim_environs.o: kernels_api.h sim_environs.h

$(S_OBJ_G_DIR)/kernels_api.o: kernels_api.h sim_environs.h
$(S_OBJ_G_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(S_OBJ_G_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(S_OBJ_G_DIR)/sim_environs.o: kernels_api.h sim_environs.h

$(C_S_OBJ_G_DIR)/kernels_api.o: kernels_api.h sim_environs.h
$(C_S_OBJ_G_DIR)/kernels_api.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h
$(C_S_OBJ_G_DIR)/kernels_api.o: radar/calc_fmcw_dist.h
$(C_S_OBJ_G_DIR)/sim_environs.o: kernels_api.h sim_environs.h

obj/sim_environs.o: utils/sim_environs.h

obj_v/sim_environs.o: utils/sim_environs.h

#obj/sim_environs.o: viterbi/utils.h viterbi/viterbi_decoder_generic.h viterbi/base.h

obj/gen_trace.o: gen_trace.h


depend:;	makedepend -f$(MFILE) -- $(CFLAGS) -- $(SRC) $(TRGN_SRC) $(G_SRC)
# DO NOT DELETE THIS LINE -- make depend depends on it.

