/* assembly to compute the key powers */

#include "poly1271_macro.h"
		
	.p2align 5
	.globl poly1271_keypowers
		
poly1271_keypowers:

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

	movq    0(%rdi),%rax
	movq    8(%rdi),%rcx

	/* tau^2 */	
	tau_squaren(1)
	cmp	$3,%rsi
	je	.L	
	
	/* tau^3 */	
	mul_tau_taun(1,2)
	cmp	$4,%rsi
	je	.L	
	
	/* tau^4 */
	movq    2*8(%rdi),%rax
	movq    3*8(%rdi),%rcx
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
	movq    6*8(%rdi),%rax
	movq    7*8(%rdi),%rcx
	tau_squaren(7)	
	cmp	$9,%rsi
	je	.L	
	
	/* tau^9 */	
	mul_tau_taun(7,8)
	cmp	$10,%rsi
	je	.L	
	
	/* tau^10 */	
	mul_tau_taun(8,9)
	cmp	$11,%rsi
	je	.L	
	
	/* tau^11 */	
	mul_tau_taun(9,10)
	cmp	$12,%rsi
	je	.L	
	
	/* tau^12 */	
	mul_tau_taun(10,11)
	cmp	$13,%rsi
	je	.L	
	
	/* tau^13 */	
	mul_tau_taun(11,12)
	cmp	$14,%rsi
	je	.L	
	
	/* tau^14 */	
	mul_tau_taun(12,13)
	cmp	$15,%rsi
	je	.L	
	
	/* tau^15 */	
	mul_tau_taun(13,14)
	cmp	$16,%rsi
	je	.L	
	
	/* tau^16 */
	movq    14*8(%rdi),%rax
	movq    15*8(%rdi),%rcx	
	tau_squaren(15)	
	cmp	$17,%rsi
	je	.L	
	
	/* tau^17 */	
	mul_tau_taun(15,16)
	cmp	$18,%rsi
	je	.L	
	
	/* tau^18 */	
	mul_tau_taun(16,17)
	cmp	$19,%rsi
	je	.L	
	
	/* tau^19 */	
	mul_tau_taun(17,18)
	cmp	$20,%rsi
	je	.L	
	
	/* tau^20 */	
	mul_tau_taun(18,19)
	cmp	$21,%rsi
	je	.L	
	
	/* tau^21 */	
	mul_tau_taun(19,20)
	cmp	$22,%rsi
	je	.L	
	
	/* tau^22 */	
	mul_tau_taun(20,21)
	cmp	$23,%rsi
	je	.L	
	
	/* tau^23 */	
	mul_tau_taun(21,22)
	cmp	$24,%rsi
	je	.L	
	
	/* tau^24 */	
	mul_tau_taun(22,23)
	cmp	$25,%rsi
	je	.L	
	
	/* tau^25 */	
	mul_tau_taun(23,24)
	cmp	$26,%rsi
	je	.L	
	
	/* tau^26 */	
	mul_tau_taun(24,25)
	cmp	$27,%rsi
	je	.L	
	
	/* tau^27 */	
	mul_tau_taun(25,26)
	cmp	$28,%rsi
	je	.L	
	
	/* tau^28 */	
	mul_tau_taun(26,27)
	cmp	$29,%rsi
	je	.L	
	
	/* tau^29 */	
	mul_tau_taun(27,28)
	cmp	$30,%rsi
	je	.L	
	
	/* tau^30 */	
	mul_tau_taun(28,29)
	cmp	$31,%rsi
	je	.L	
	
	/* tau^31 */	
	mul_tau_taun(29,30)
	cmp	$32,%rsi
	je	.L	
	
	/* tau^32 */
	movq    30*8(%rdi),%rax
	movq    31*8(%rdi),%rcx	
	tau_squaren(31)
	
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
