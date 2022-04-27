## this program get your name and print it out using an array of 7 elements #
LC0:
	.ascii "Enter a sentence: \0"
LC1:
	.ascii "%c\0"
LC2:
	.ascii "The result is: \0"
LC3:
	.ascii "%c\0"
PC0:
    .ascii "Enter the char: \0"

	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:

	
	pushl %ebp 					# \ Standard callee entrance
	movl %esp, %ebp 			# /
	
	pushl	%ebp					# save value of esp inside the stack
	
	subl	$32, %esp
	
	movl	$LC0, (%esp) 				#Enter your sentance:
	call	_printf
	
	# for loop to read the input of 7 characters      for (Init; Test; Update)     Body
	movl	$0, %ebx					# initial of for-loop to fill an array of 7 elements, initial value of loop
	jmp		L2
L3:
	leal	8(%esp,%ebx,1), %eax		# Get current array index
	movl	%eax, 4(%esp)				# Store that index in 4+esp
	movl	$LC1, (%esp)   				# get charachter by character and stored in an array %c\0
	call	_scanf
	

	addl	$1, %ebx					# update of for loop 
L2:
	cmpl	$6, %ebx					# index of array 
	jle		L3							# condition of for loop, if le jump to L3 to create a loop to read the input 


    	# Grab extra character
    	movl $PC0, (%esp) # print PCO message
	call _puts

  	leal 24(%esp), %eax # prepare stack ptr to save x at address 16+esp and move to eax
  	movl %eax, 4(%esp) # move eax to address of 4 + esp
  	movl $LC3, (%esp) # scanf 
  	call _scanf
  	movl 24(%esp), %edi #move x to edi


	#movl	$LC2, (%esp)				# Print out the input name, with the size of 7 characters
	#call	_printf
	# for loop to print out			for (Init; Test; Update)     Body

	movl	$0, %ebx					# initial or ebx =0, we make ebx to zero to use it again, as an initial value of loop
	jmp		L4
L5:
	movl	8(%esp,%ebx,1), %eax		#\ body of for-loop
	cmpl 	%eax, %edi
	je 	.done

	movl	%eax, (%esp)			#/
	call	_putchar					#/ print out charachter by character from the array

	addl	$1, %ebx					# UPDATE VALUE OF LOOP
L4:
	cmpl	$6, %ebx					# array of 7 elements
	jle		L5							# test or CONDITION OF FOR-LOOP, 

.done:									# end of program an done
	movl	$0, %eax
	
	andl	$32, %esp
	
	leave
	ret