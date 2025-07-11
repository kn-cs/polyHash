/* assembly to compute the poly1305 hash function using precomputed key powers
   and applying lazy reduction over a group of 16 message blocks */

#include "poly1305_macro.h"
	
	.p2align 5
	.globl poly1305_maax_g16

poly1305_maax_g16:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$128,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)
	movq 	%rdi,56(%rsp)
	movq 	%rcx,64(%rsp)
	movq 	%r8,72(%rsp)
	movq 	%r9,80(%rsp)

	cmpq    $1,%rcx
	je      .LB1
	
	movq    %rcx,88(%rsp)
	movq	$1,96(%rsp)	
	
	movq    %rdx,%rdi
	
	movq    $0,%r8
	movq    $0,%r9
	movq    $0,%r10
	movq    $0,%r11
	movq    $0,%r12	
	
	cmpq    $2,%rcx
	je      .LB2
	
	cmpq    $3,%rcx
	je      .LB3
	
	cmpq    $4,%rcx
	je      .LB4
	
	cmpq    $5,%rcx
	je      .LB5
	
	cmpq    $6,%rcx
	je      .LB6
	
	cmpq    $7,%rcx
	je      .LB7
	
	cmpq    $8,%rcx
	je      .LB8
	
	cmpq    $9,%rcx
	je      .LB9
	
	cmpq    $10,%rcx
	je      .LB10
	
	cmpq    $11,%rcx
	je      .LB11
	
	cmpq    $12,%rcx
	je      .LB12
	
	cmpq    $13,%rcx
	je      .LB13
	
	cmpq    $14,%rcx
	je      .LB14
	
	cmpq    $15,%rcx
	je      .LB15
		
.LB16:
	mul_taun(0,336)
	add_product()	
	
	mul_taun(16,312)
	add_product()

	mul_taun(32,288)
	add_product()
	
	mul_taun(48,264)
	add_product()
	
	mul_taun(64,240)
	add_product()
	
	mul_taun(80,216)
	add_product()

	mul_taun(96,192)
	add_product()
	
	mul_taun(112,168)
	add_product()
	
	mul_taun(128,144)
	add_product()
	
	mul_taun(144,120)
	add_product()
	
	mul_taun(160,96)
	add_product()
	
	mul_taun(176,72)
	add_product()
	
	mul_taun(192,48)
	add_product()
	
	mul_taun(208,24)
	add_product()	
	
	mul_tau(224,0)
	add_product()		
        
	reduce_5limb()
	reduce_3limb()
	
	add_msg_block(240,96)

	addq	$256,%rsi	

	movq    88(%rsp),%rcx
	subq    $16,%rcx
	movq    %rcx,88(%rsp)	
	
	cmpq    $0,%rcx	
	je      .LB0
	
	cmpq    $1,%rcx	
	jg      .LT2
	
.LT1:
	mul_taur(0)

	reduce_5limb()

	add_msg_block(0,72)
		
	jmp     .LB0
	
.LT2:
	cmpq    $2,%rcx	
	jg      .LT3	

	mul_taunr(24)
	jmp     .LB2

.LT3:
	cmpq    $3,%rcx
	jg      .LT4

	mul_taunr(48)
	jmp     .LB3

.LT4:
	cmpq    $4,%rcx
	jg      .LT5

	mul_taunr(72)
	jmp     .LB4

.LT5:
	cmpq    $5,%rcx
	jg      .LT6

	mul_taunr(96)
	jmp     .LB5

.LT6:
	cmpq    $6,%rcx
	jg      .LT7

	mul_taunr(120)
	jmp     .LB6

.LT7:
	cmpq    $7,%rcx
	jg      .LT8

	mul_taunr(144)
	jmp     .LB7
	
.LT8:
	cmpq    $8,%rcx
	jg      .LT9

	mul_taunr(168)
	jmp     .LB8
	
.LT9:
	cmpq    $9,%rcx
	jg      .LT10

	mul_taunr(192)
	jmp     .LB9
	
.LT10:
	cmpq    $10,%rcx
	jg      .LT11

	mul_taunr(216)
	jmp     .LB10
	
.LT11:
	cmpq    $11,%rcx
	jg      .LT12

	mul_taunr(240)
	jmp     .LB11
	
.LT12:
	cmpq    $12,%rcx
	jg      .LT13

	mul_taunr(264)
	jmp     .LB12
	
.LT13:
	cmpq    $13,%rcx
	jg      .LT14

	mul_taunr(288)
	jmp     .LB13
	
.LT14:
	cmpq    $14,%rcx
	jg      .LT15

	mul_taunr(312)
	jmp     .LB14
	
.LT15:
	cmpq    $15,%rcx
	jg      .LT16

	mul_taunr(336)
	jmp     .LB15				

.LT16:
	mul_taunr(360)
	jmp     .LB16
			
.LB2:
	mul_tau(0,0)
	add_product()
	        
	reduce_5limb()

	add_msg_block(16,72)
		
	jmp     .LB0
	
.LB3:
	mul_taun(0,24)
	add_product()
		
	mul_tau(16,0)
	add_product()
		
	reduce_5limb()
	
	add_msg_block(32,72)
	
	jmp     .LB0
	
.LB4:
	mul_taun(0,48)
	add_product()
	
	mul_taun(16,24)
	add_product()
	
	mul_tau(32,0)
	add_product()
	
	reduce_5limb()
		
	add_msg_block(48,72)
	
	jmp     .LB0
	
.LB5:
	mul_taun(0,72)
	add_product()

	mul_taun(16,48)
	add_product()
	
	mul_taun(32,24)
	add_product()
	
	mul_tau(48,0)
	add_product()
	
	reduce_5limb()
	
	add_msg_block(64,72)
	
	jmp     .LB0
	
.LB6:
	mul_taun(0,96)
	add_product()
	
	mul_taun(16,72)
	add_product()
	
	mul_taun(32,48)
	add_product()
	
	mul_taun(48,24)
	add_product()
	
	mul_tau(64,0)
	add_product()
	
	reduce_5limb()
	
	add_msg_block(80,72)
		
	jmp     .LB0
	
.LB7:
	mul_taun(0,120)
	add_product()

	mul_taun(16,96)
	add_product()
	
	mul_taun(32,72)
	add_product()
	
	mul_taun(48,48)
	add_product()
	
	mul_taun(64,24)
	add_product()
	
	mul_tau(80,0)
	add_product()
	
	reduce_5limb()
	
	add_msg_block(96,72)
	
	jmp     .LB0	
	
.LB8:
	mul_taun(0,144)
	add_product()

	mul_taun(16,120)
	add_product()
	
	mul_taun(32,96)
	add_product()
	
	mul_taun(48,72)
	add_product()
	
	mul_taun(64,48)
	add_product()
	
	mul_taun(80,24)
	add_product()
	
	mul_tau(96,0)
	add_product()	
	
	reduce_5limb()
	
	add_msg_block(112,72)
	
	jmp     .LB0	
	
.LB9:
	mul_taun(0,168)
	add_product()

	mul_taun(16,144)
	add_product()
	
	mul_taun(32,120)
	add_product()
	
	mul_taun(48,96)
	add_product()
	
	mul_taun(64,72)
	add_product()
	
	mul_taun(80,48)
	add_product()
	
	mul_taun(96,24)
	add_product()
	
	mul_tau(112,0)
	add_product()		
	
	reduce_5limb()
	
	add_msg_block(128,72)
	
	jmp     .LB0	
	
.LB10:
	mul_taun(0,192)
	add_product()

	mul_taun(16,168)
	add_product()
	
	mul_taun(32,144)
	add_product()
	
	mul_taun(48,120)
	add_product()
	
	mul_taun(64,96)
	add_product()
	
	mul_taun(80,72)
	add_product()
	
	mul_taun(96,48)
	add_product()
	
	mul_taun(112,24)
	add_product()
	
	mul_tau(128,0)
	add_product()	
	
	reduce_5limb()
	
	add_msg_block(144,72)
	
	jmp     .LB0	
	
.LB11:
	mul_taun(0,216)
	add_product()

	mul_taun(16,192)
	add_product()
	
	mul_taun(32,168)
	add_product()
	
	mul_taun(48,144)
	add_product()
	
	mul_taun(64,120)
	add_product()
	
	mul_taun(80,96)
	add_product()
	
	mul_taun(96,72)
	add_product()
	
	mul_taun(112,48)
	add_product()
	
	mul_taun(128,24)
	add_product()
	
	mul_tau(144,0)
	add_product()	
	
	reduce_5limb()
	
	add_msg_block(160,72)
	
	jmp     .LB0	
.LB12:
	mul_taun(0,240)
	add_product()

	mul_taun(16,216)
	add_product()
	
	mul_taun(32,192)
	add_product()
	
	mul_taun(48,168)
	add_product()
	
	mul_taun(64,144)
	add_product()
	
	mul_taun(80,120)
	add_product()
	
	mul_taun(96,96)
	add_product()
	
	mul_taun(112,72)
	add_product()
	
	mul_taun(128,48)
	add_product()
	
	mul_taun(144,24)
	add_product()
	
	mul_tau(160,0)
	add_product()		
	
	reduce_5limb()
	
	add_msg_block(176,72)
	
	jmp     .LB0	
	
.LB13:
	mul_taun(0,264)
	add_product()

	mul_taun(16,240)
	add_product()
	
	mul_taun(32,216)
	add_product()
	
	mul_taun(48,192)
	add_product()
	
	mul_taun(64,168)
	add_product()
	
	mul_taun(80,144)
	add_product()
	
	mul_taun(96,120)
	add_product()
	
	mul_taun(112,96)
	add_product()
	
	mul_taun(128,72)
	add_product()
	
	mul_taun(144,48)
	add_product()
	
	mul_taun(160,24)
	add_product()
	
	mul_tau(176,0)
	add_product()			
	
	reduce_5limb()
	
	add_msg_block(192,72)
	
	jmp     .LB0	
	
.LB14:
	mul_taun(0,288)
	add_product()

	mul_taun(16,264)
	add_product()
	
	mul_taun(32,240)
	add_product()
	
	mul_taun(48,216)
	add_product()
	
	mul_taun(64,192)
	add_product()
	
	mul_taun(80,168)
	add_product()
	
	mul_taun(96,144)
	add_product()
	
	mul_taun(112,120)
	add_product()
	
	mul_taun(128,96)
	add_product()
	
	mul_taun(144,72)
	add_product()
	
	mul_taun(160,48)
	add_product()
	
	mul_taun(176,24)
	add_product()
	
	mul_tau(192,0)
	add_product()				
	
	reduce_5limb()
	
	add_msg_block(208,72)
	
	jmp     .LB0	
	
.LB15:
	mul_taun(0,312)
	add_product()

	mul_taun(16,288)
	add_product()
	
	mul_taun(32,264)
	add_product()
	
	mul_taun(48,240)
	add_product()
	
	mul_taun(64,216)
	add_product()
	
	mul_taun(80,192)
	add_product()
	
	mul_taun(96,168)
	add_product()
	
	mul_taun(112,144)
	add_product()
	
	mul_taun(128,120)
	add_product()
	
	mul_taun(144,96)
	add_product()
	
	mul_taun(160,72)
	add_product()
	
	mul_taun(176,48)
	add_product()
	
	mul_taun(192,24)
	add_product()
	
	mul_tau(208,0)
	add_product()					
	
	reduce_5limb()
	
	add_msg_block(224,72)	
	
.LB0:	
	xorq 	%rdx,%rdx
	movq	64(%rsp),%rax
	movq	$16,%rcx
	divq	%rcx
	
	cmpq	$0,%rdx
	jg	.L0
	
	cmpq	$0,72(%rsp)
	jg	.L0
	
	subq	96(%rsp),%r10

.L0:
	mul_taur(0)

	reduce_5limb()
	
	jmp	.LF
	
.LB1:   
	movq    0(%rdx),%r14
	movq    8(%rdx),%r15

	movq    0(%rsi),%r13
	movq    8(%rsi),%rax

	cmpq    $1,72(%rsp)
	je      .L2

	cmpq    $8,80(%rsp)
	jle     .L1
	
	xorq    %r11,%r11
	movq    %r13,%rdx    

	mulx    %r14,%r8,%r9
	mulx    %r15,%rbx,%r10
	adcx    %rbx,%r9
	adcx    %r11,%r10

	xorq    %r12,%r12
	movq    %rax,%rdx
	   
	mulx    %r14,%rbx,%rbp
	adcx    %rbx,%r9
	adox    %rbp,%r10
	    
	mulx    %r15,%rbx,%rbp
	adcx    %rbx,%r10
	adox    %rbp,%r11
	adcx    %r12,%r11
	
	reduce_4limb()

	jmp     .LF

.L1:    
	xorq    %r11,%r11
	movq    %r13,%rdx    

	mulx    %r14,%r8,%r9
	mulx    %r15,%rbx,%r10
	adcx    %rbx,%r9
	adcx    %r11,%r10


	jmp     .LF	

.L2:
	xorq    %r11,%r11
	movq    %r13,%rdx    

	mulx    %r14,%r8,%r9
	mulx    %r15,%rbx,%r10
	adcx    %rbx,%r9
	adcx    %r11,%r10

	xorq    %r12,%r12
	movq    %rax,%rdx
	   
	mulx    %r14,%rbx,%rbp
	adcx    %rbx,%r9
	adox    %rbp,%r10
	    
	mulx    %r15,%rbx,%rbp
	adcx    %rbx,%r10
	adox    %rbp,%r11
	adcx    %r12,%r11

	xorq    %rax,%rax
	    
	adcx    %r14,%r10
	adox    %rax,%r11
	adcx    %r15,%r11
	adox    %rax,%r12
	adcx    %rax,%r12	

	reduce_5limb()

.LF:	
	reduce_3limb()
	
	make_unique()

	movq 	56(%rsp),%rdi
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)

	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
	
