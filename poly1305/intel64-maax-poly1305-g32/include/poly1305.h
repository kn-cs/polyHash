#ifndef __POLY1305__
#define __POLY1305__

#include "poly1305_basictypes.h"

#define KEY_LENGTH 128
#define BLOCK_LENGTH 128
#define KEY_SIZE 16
#define BLOCK_SIZE 16
#define MAX_MSG_SIZE 4194304
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 96

void poly1305(uchar8 *,uchar8 *,const uint64 *,const uint64);

extern void poly1305_maax_g32(uint64 *,const uint64 *,const uint64 *,const uint64,const uint64,const uint64);
extern void poly1305_keypowers(uint64 *,const uint64);

#endif
