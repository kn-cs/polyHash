/* assembly to compute the key powers */

#include "poly1305_macro.h"
		
	.p2align 5
	.globl poly1305_keypowers
		
poly1305_keypowers:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$56,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)

	movq    0(%rdi),%r14
	movq    8(%rdi),%r15
	
	/* tau^2 */	
	tau_square()
	
	cmp	$3,%rsi
	je	.L2
	
	cmp	$4,%rsi
	je	.L1

	/* tau^4 */	
	tau_squaren(3)
	
.L1:	
	/* tau^3 */
	mul_tau_taun(1,2)

.L2:
	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
