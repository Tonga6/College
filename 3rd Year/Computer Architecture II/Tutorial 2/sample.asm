includelib legacy_stdio_definitions.lib
extrn printf:near
extrn scanf:near


;; Data segment
.data

	print_string BYTE "Sum of i: %I64d and j: %lld is: %I64d", 0Ah, 00h
	print_string2 BYTE "Sum of i: %I64d, j: %lld and bias: %lld is: %I64d", 0Ah, 00h
	bias QWORD 50
	sum2 QWORD 0

	print_string3 BYTE "Please enter an integer:", 0Ah, 00h
	print_string4 BYTE "The sum of proc. and user input (%lld, %lld, %lld, %lld): %lld", 0Ah, 00h
	format BYTE "%lld", 00h

	public inp_int
	inp_int QWORD 0

;; Code segment
.code


public fibX64

fibX64: 
;; fin in rcx (arg1)

		cmp rcx, 0				;;is fin == 0?
		jle fib_0

		cmp rcx, 1				;;is fin == 1?
		jg fib_rec
		mov rax, 1
		ret

fib_rec:
;; Recursive call fibX64 function
		sub rsp, 40				;; allocate shadow space
		sub rcx, 1				;; 1st arg: fin-1
		mov [rsp+24], rcx		;; preserve fin-1

		call fibX64				;; call the function

		mov [rsp+32], rax		;; preserve fibX64(fin-1) in shadow space for fibX64(fin-1) + fibX64(fin-2)#
		mov rcx, [rsp+24]		;; restore fin-1
		sub rcx, 1				;;1st arg: fin-2
		call fibX64


		add rax, [rsp+32]		;; rax = fibX64(fin-1) + fibX64(fin-2)
		add rsp, 40
		ret
fib_0:
		mov rax, rcx			;;return fin
		ret



public use_scanf

use_scanf:
;;rcx = a, rdx = b, r8 = c
			
			push rcx
			push rdx
			push r8
			add rcx, rdx
			add rcx, r8
			push rcx

			sub rsp, 40				;; the shadow space
			lea rcx, print_string3	;; 1st argument: string
			call printf				;; call the function

			lea rcx, format
			lea rdx, [inp_int]
			call scanf

			
			mov rax, [rsp+40]
			add rax, [inp_int]

			;push rax				;; 5th arg
			mov r9, [rsp+48]		;; 4th arg
			mov r8, [rsp+56]		;; 3rd arg
			mov rdx, [rsp+64]		;; 2nd arg
			lea rcx, print_string4	;; 1st arg

			sub rsp, 40
			mov [rsp+40],rax		;;7th arg
			mov r10, [inp_int]	
			mov [rsp+32], r10		;;6th arg
			call printf

			mov rax, [rsp+40]
			add rsp, 112				;;deallocate shadow spaces
			
			ret


;; address of the array: RDX
;; size of the array: RCX
public array_proc

array_proc:
			;; RAX is the accumulator
			xor rax, rax

			;; the main loop
L1:			add rax, [rdx] ;; access and add contents
			add rdx, TYPE QWORD	;; TYPE operator returns the number of bytes used by the identified QWORD
			loop L1 ;; RCX as the loop counter

			;; returning from the function/procedure
			ret

;; i in RCX (arg1)
;; j in RDX (arg2)
;; print_proc: adds the two arguments and prints it through printf
public print_proc

print_proc:
			lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
			mov [rsp+24], rax		;; preserving rax in shadow space
			mov [rsp+16], rcx		;; preserving i
			mov [rsp+8], rdx		;; preserving j

			;; Calling our printf function
			sub rsp, 40				;; the shadow space
			mov r9, rax				;; 4th argument
			mov r8, rdx				;; 3rd argument: j
			mov rdx, rcx			;; 2nd argument: i
			lea rcx, print_string	;; 1st argument: string
			call printf				;; call the function

			;; 2nd call to printf
			;; RSP has changed, so the displacements have also changed
			mov rax, [rsp+64]		;; restoring the sum
			add rax, bias			;; adding the bias
			mov [rsp+72], rax			;; preserving rax
			mov [rsp+32], rax		;; the 5th argument on stack
			mov r9, bias			;; the 4th argument
			mov r8, [rsp+48]		;; restoring j, the 3rd arg
			mov rdx, [rsp+56]		;; restoring i, the 2nd arg
			lea rcx, print_string2 ;; 1st argument: string
			call printf				;; call the function
			
			add rsp, 40				;; deallocate the shadow space
			
			;; restore rax
			mov rax, [rsp+32]
			ret

end