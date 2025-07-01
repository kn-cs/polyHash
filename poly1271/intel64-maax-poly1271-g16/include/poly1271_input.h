#ifndef __POLY1271_PROCESS_INPUT__
#define __POLY1271_PROCESS_INPUT__

#include "poly1271_basictypes.h"

void generate_key(int,char *);
void generate_msg(int,char *);
void format_key(uchar8 *,int,char *);
void format_msg(uchar8 *,int,char *);

#endif
