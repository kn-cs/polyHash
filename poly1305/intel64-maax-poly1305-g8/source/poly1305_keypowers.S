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
	je	.L
	
	/* tau^3 */	
	mul_tau_taun(1,2)	
	cmp	$4,%rsi
	je	.L
	
	/* tau^4 */
	movq    3*8(%rdi),%r8
	movq    4*8(%rdi),%r9
	movq    5*8(%rdi),%r10
	tau_squaren(3)	
	cmp	$5,%rsi
	je	.L	
	
	/* tau^5 */	
	mul_tau_taun(3,4)	
	cmp	$6,%rsi
	je	.L	
	
	/* tau^6 */	
	mul_tau_taun(4,5)	
	cmp	$7,%rsi
	je	.L	
	
	/* tau^7 */	
	mul_tau_taun(5,6)	
	cmp	$8,%rsi
	je	.L
	
	/* tau^8 */	
	movq    9*8(%rdi),%r8
	movq    10*8(%rdi),%r9
	movq    11*8(%rdi),%r10	
	tau_squaren(7)	
	
.L:
	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
