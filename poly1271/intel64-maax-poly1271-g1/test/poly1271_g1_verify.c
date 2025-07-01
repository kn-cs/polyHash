#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "poly1271.h"
#include "poly1271_input.h"

int main() {

	FILE *fpin,*fpout;
    	char *line,*ptr,*msg;
    	size_t len;
    	ssize_t n;
    	int i,j,c,l,msglen;
    	uchar8 str[3],k[KEY_SIZE];
    	uchar8 m[MAX_MSG_SIZE]={0};
    	uchar8 h[BLOCK_SIZE]={0};
    	uint64 *q;  
    	
    	// #define SAGE
    	#ifdef SAGE    	
    	c = system("cd ./test_files; sage poly1271_verify.sage; cd ..");
    	remove("./test_files/poly1271_verify.sage.py");    	
    	#endif    	
    	   	
   	fpin = fopen("./test_files/poly1271_verify_test_cases.txt","r");
    	if (fpin == NULL) {
    	
    		printf("\nError opening input file of messages!\n\n");
        	exit(1);
        }    	
        	
	fpout = fopen("./test_files/poly1271_verify_c_outputs.txt","w");
    	if (fpout == NULL) {
    	
    		printf("\nError opening output file!\n\n");
        	exit(1);
        }

	line = calloc(16500,(sizeof(char)));
	msg  = calloc(16500,(sizeof(char)));	
    	while ((n = getline(&line, &len, fpin)) != -1) {
    	
        	sscanf(line,"%s %d",msg,&msglen);
        	l = ((int)n-1)/30;
        	c = 0;
        	ptr = msg;
        	for (i=1;i<=l;++i) {
        	   		
        		for (j=29;j>=1;j=j-2) {
        		
        			str[0] = ptr[j-1];
        			str[1] = ptr[j];
        			m[c++] = strtol(str,NULL,16);
        		}
        		ptr = ptr + 30;
        	}
        	format_key(k,KEY_LENGTH,"./test_files/poly1271_verify_keyfile.txt");
        	poly1271(h,m,k,msglen);
      		q = (uint64 *)h; fprintf(fpout,"%016llx%016llx\n",q[1],q[0]);
    	}
    	fclose(fpin); fclose(fpout);
    	free(line); free(msg);
    	
    	c = system("diff ./test_files/poly1271_verify_c_outputs.txt ./test_files/poly1271_verify_s_outputs.txt");
    	if (c == 0) printf("\nVerification tests succeeded for all inputs!\n\n");
    	else printf("\nVerification tests failed for some or all inputs!\n\n"); 
    	remove("./test_files/poly1271_verify_c_outputs.txt");    	   	

	return 0;
}
