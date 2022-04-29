# CS 260 FINAL PROJECT Group 9
# Names: Nathan Mautz, Madison Call, Maxwell Rettig
# Date: 4/28
# this program gets a sentence of length up to 502 char (plus null terminator), then gets a char x
# It then prints out the string up to but no further than the first instance
# of that char x

LC0:
	.ascii "Enter a sentence: \0"
LC1:
	.ascii "%c\0"
LC2:
	.ascii "The result is: \0"
LC3:
	.ascii "%c"
PC0:
    	.ascii "Enter the char: \0"

	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef

_main:

	
	pushl %ebp 				# \ Standard callee entrance
	movl %esp, %ebp 			# /
	
	pushl	%ebp				# save value of esp inside the stack
	
	subl	$512, %esp			# Initialize the stack for the program
	
	movl	$LC0, (%esp) 			# print Enter your sentence:
	call	_printf
		
	# for loop to read the input of up to 503 characters      for (Init; Test; Update)     Body


	movl	$0, %ebx			# initial value of loop iterator
	movb	$0, %al				# Initialize al to 0
L3:
	leal	9(%esp,%ebx,1), %eax		# Get current array index
	movl	%eax, 4(%esp)			# Store that index in 4+esp
	movl	$LC1, (%esp)   			# get character by character and stored in an array with %c\0
	call	_scanf

	leal	9(%esp,%ebx,1), %eax		# Get the current array index again
	movb	(%eax), %al			# Move the recently scanned value at that array index into al
	addl	$1, %ebx			# update the for loop 
L2:
	cmpb	$10, %al			# Check if the just collected value is a new line (0xA = $10 = '/n')
	jne		L3			# If it is not a newline the loop conditional triggers and we go back to the start of the loop


	# Grab extra character x
	movl $PC0, (%esp) 			# print Enter the char:
	call _puts

  	leal 8(%esp), %eax 			# prepare stack ptr to save x at address 8+esp and move to eax
  	movl %eax, 4(%esp) 			# move eax to address of 4 + esp
  	movl $LC3, (%esp) 			# scanf 
  	call _scanf

  	movl 8(%esp), %edi 			# move x to edi

	movl	$0, %ebx			# reinitialize ebx to 0 for the upcoming loop
	movb	$0, %al				# Initialize al to 0
	jmp		L4			# Jump to the loop conditional
L5:

	movb 	9(%esp,%ebx,1), %al		# move the value of the array at the current index to %eax
						# aka eax = sentence(i)

	movl	%eax, (%esp)			# move eax to esp for printing
	call	_putchar			# print out character by character from the array


	movb 	9(%esp,%ebx,1), %al		# move sentence(i) to %eax (%al)
	movb	8(%esp), 	%cl		# move x to %ecx (%cl)


	cmpb 	%cl, %al			# Check if al and cl are the same
	je 	L6 				# If yes the loop conditional fails and we exit the loop


	movb	9(%esp,%ebx,1), %al		# Move sentence(i) to al
	addl	$1, %ebx			# UPDATE VALUE OF LOOP
L4:	
	cmpb	$10, %al			# Check if al is a new line (0xA = $10 = '/n')
	jne	L5				# if not, continue the loop 

L6:						# end of program
	movl	$0, %eax			# Return 0
	
	andl	$512, %esp			# De-initialize the stack
	
	leave
	ret