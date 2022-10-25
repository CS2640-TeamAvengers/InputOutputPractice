#objective is to take two numbers as input, request an arithmetic function from the user, and apply it to the inputs

#Name: Alexander Eckert
#Date: 10/19/2022
#Assignment: 
#	1. take in 2 user inputs
#	2. set up the 4 arithmetic options
#	3. get user selection
#	4. perform selected arithmetic operation
#	5. display the result

.data
	prompt1: .asciiz "Enter a number: "
	prompt2: .asciiz "Enter a second number: "
	outputMenu: .asciiz "Select an operation: \n+\n-\n*\n/\nx (exit)\nr (enter different values)\nOperation: "
	invalidInput: .asciiz "\n\nInvalid input, please try again.\n\n"
	exitMessage: .asciiz "\n\nHave a nice day!\n"
	
.text
	
main:
	#print our first prompt
	li $v0, 4
	la $a0, prompt1
	syscall

	#getting user input
	li $v0, 5
	syscall

	#move input to another register
	move $s0, $v0
    
	#repeat for second user input
	li $v0, 4
	la $a0, prompt2
	syscall
	li $v0, 5
	syscall
	move $s1, $v0


	#offer output menu
	li $v0, 4
	la $a0, outputMenu
	syscall

	#receive operand from user
	li $v0, 12
	syscall
	
	#move input to register $s2
	move $s2, $v0
	
	#if user chose +, we call Add
	beq $s2, '+', Add
	
	#if user chose -, we call Subtract
	beq $s2, '-', Subtract
	
	#if user chose *, we call Multiply
	beq $s2, '*', Multiply
	
	#if user chose /, we call Divide
	beq $s2, '/', Divide
	
	#if user chose x, we exit
	beq $s2, 'x', exit
	
	#if user chose r, we go main
	beq $s2, 'r', main

InvalidInput:
	#alert user
	li $v0, 4
	la $a0, invalidInput
	syscall
	
	#try again 
	j main

Add:
	#perform operation
	add $t0, $s0, $s1
	
	#print the result
	li $v0, 11
	li $a0, '\n'
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 11
	li $a0, '+'
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 11
	li $a0, '='
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main

Subtract:
	#perform operation
	sub $t0, $s0, $s1
	
	li $v0, 11
	li $a0, '\n'
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 11
	li $a0, '-'
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 11
	li $a0, '='
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main

Multiply:
	#perform operation
	mul $t0, $s0, $s1

	li $v0, 11
	li $a0, '\n'
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 11
	li $a0, '*'
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 11
	li $a0, '='
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main
	
Divide:
	#perform operation
	div $t0, $s0, $s1

	#print the result
	li $v0, 11
	li $a0, '\n'
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 11
	li $a0, '/'
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 11
	li $a0, '='
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
	j main
	
exit:
	#print exit message
	li $v0, 4
	la $a0, exitMessage
	syscall
	
	#exit the program
	li $v0, 10
	syscall
