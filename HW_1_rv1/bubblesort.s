	.file	"bubblesort.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d "
.LC1:
	.string	""
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$-1, -48(%rbp)
	movl	$3, -44(%rbp)
	movl	$-5, -40(%rbp)
	movl	$7, -36(%rbp)
	movl	$-9, -32(%rbp)
	movl	$2, -28(%rbp)
	movl	$-4, -24(%rbp)
	movl	$6, -20(%rbp)
	movl	$-8, -16(%rbp)
	movl	$10, -12(%rbp)
	movl	$10, -56(%rbp)
	movl	$0, -68(%rbp)
	jmp	.L2
.L6:
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -64(%rbp)
	jmp	.L3
.L5:
	movl	-64(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %edx
	movl	-68(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %eax
	cmpl	%eax, %edx
	jge	.L4
	movl	-64(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %eax
	movl	%eax, -52(%rbp)
	movl	-68(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %edx
	movl	-64(%rbp), %eax
	cltq
	movl	%edx, -48(%rbp,%rax,4)
	movl	-68(%rbp), %eax
	cltq
	movl	-52(%rbp), %edx
	movl	%edx, -48(%rbp,%rax,4)
.L4:
	addl	$1, -64(%rbp)
.L3:
	movl	-64(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.L5
	addl	$1, -68(%rbp)
.L2:
	movl	-68(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.L6
	movl	$0, -60(%rbp)
	jmp	.L7
.L8:
	movl	-60(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -60(%rbp)
.L7:
	movl	-60(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.L8
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
