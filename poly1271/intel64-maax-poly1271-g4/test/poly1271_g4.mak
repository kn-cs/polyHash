INCDRS = -I../include/

SRCFLS = ../source/poly1271_const.S 		\
	 ../source/poly1271_maax_g4.S		\
	 ../source/poly1271_keypowers.S	\
	 ../source/poly1271_input.c 		\
	 ../source/poly1271.c
         
OBJFLS = ../source/poly1271_const.o 		\
	 ../source/poly1271_maax_g4.o		\
	 ../source/poly1271_keypowers.o	\
	 ../source/poly1271_input.o 		\
	 ../source/poly1271.o

TESTSRC = ./poly1271_g4_verify.c
TESTOBJ = ./poly1271_g4_verify.o

SPEEDSRC = ./poly1271_g4_speed.c
SPEEDOBJ = ./poly1271_g4_speed.o

RECORDSRC = ./poly1271_g4_record_speed.c
RECORDOBJ = ./poly1271_g4_record_speed.o
	  
EXE1    = poly1271_g4_verify
EXE2    = poly1271_g4_speed
EXE3    = poly1271_g4_record_speed

CFLAGS = -march=native -mtune=native -m64 -O3 -funroll-loops -fomit-frame-pointer

CC     = gcc-10
LL     = gcc-10

all:	$(EXE1) $(EXE2) $(EXE3)

$(EXE1): $(TESTOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(TESTOBJ) -lm
	
$(EXE2): $(SPEEDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(SPEEDOBJ) -lm -lcpucycles
$(EXE3): $(RECORDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(RECORDOBJ) -lm -lcpucycles

.c.o:
	$(CC) $(INCDRS) $(CFLAGS) -o $@ -c $<

clean:
	-rm $(EXE1) $(EXE2) $(EXE3)
	-rm $(TESTOBJ) $(SPEEDOBJ) $(RECORDOBJ)
	-rm $(OBJFLS)

