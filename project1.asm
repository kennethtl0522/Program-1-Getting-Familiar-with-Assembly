# Author: Kenneth Wang
# Repo Extra Credit: https://github.com/kennethtl0522/Program-1-Getting-Familiar-with-Assembly/upload
.data
prompt1: .asciiz "Enter first integer: "
prompt2: .asciiz "\nEnter second integer: "
output_text: .asciiz "\nYou entered: "
splitter: .asciiz " and "
newline: .asciiz "\n"

addition: .asciiz "\nAddition: "
subtraction: .asciiz "\nSubtraction: "
multiplication: .asciiz "\nMultiplication: "
division: .asciiz "\nDivision: "
div_failed: .asciiz "\nDivision: Dividend is zero"

same_output: .asciiz "User inputs are the same"
diff_output: .asciiz "User inputs are different"

.text
main:
	# Promote the first integer
    	li $v0, 4
    	la $a0, prompt1
    	syscall

	# Pass user input into $s0
    	li $v0, 5
    	syscall
    	move $s0, $v0

	# Promote the second integer
    	li $v0, 4
    	la $a0, prompt2
    	syscall

	# Pass user input into $s1
	li $v0, 5
    	syscall
    	move $s1, $v0

	# Print "You entered: "
	li $v0, 4
    	la $a0, output_text
    	syscall

	# Print the first integer
    	move $a0, $s0
    	li $v0, 1
    	syscall

	# Print a new line
    	li $v0, 4
   	la $a0, splitter
    	syscall

	# Print the second integer
    	move $a0, $s1
   	li $v0, 1
    	syscall

	# Addition
   	add $t0, $s0, $s1
    	li $v0, 4
    	la $a0, addition
    	syscall
    	move $a0, $t0
    	li $v0, 1
    	syscall

	# Subtraction
	sub $t1, $s0, $s1
	li $v0, 4
	la $a0, subtraction
	syscall
	move $a0, $t1
	li $v0, 1
	syscall

	# Multiplication
	mul $t2, $s0, $s1
	li $v0, 4
	la $a0, multiplication
	syscall
	move $a0, $t2
	li $v0, 1
	syscall

	# Division
	# Skip division if $s1 is zero
	beq $s1, $zero, skip_division
	div $t3, $s0, $s1
	li $v0, 4
	la $a0, division
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	b continue

skip_division:
	li $v0, 4
	la $a0, div_failed
	syscall
	
continue:
	# Create a newline
	li $v0, 4
	la $a0, newline
	syscall
	
	beq $s0, $s1, same
	bne $s0, $s1, diff
same:
	# Output "User inputs are the same"
	li $v0, 4
	la $a0, same_output
	syscall
	# Exit
	li $v0, 10
    	syscall
diff:
	# Output "User inputs are different"
	li $v0, 4
	la $a0, diff_output
	syscall
    	# Exit
	li $v0, 10
    	syscall
