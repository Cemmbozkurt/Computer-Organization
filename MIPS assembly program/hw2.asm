.data 

array: .space 80
iterator: .word 0

msg1: .asciiz "Enter array Size:\n"
msg2: .asciiz "Enter member of Array: "
msg3: .asciiz "Enter number:\n"
notpossible: .asciiz " NOT POSSIBLE \n"
possible: .asciiz " POSSIBLE! \n"

.text 
.globl main

main:

	la $t0, array		
	lw $t1, iterator
	jal printMessage		#cout << "Enter Size
	jal getInput			#cin >> size
	move $a1, $v0			#a1 IS THE SIZE
			
	jal printMessage3		#cout << "Enter number";
	jal getInput			#cin >> number
	move $a2, $v0			#a2 is the nubmer	
					
	#while(iterator < size)
	while:
		beq $t1, $a1, exit	#if Iterator == size go to exit
		sll $t3, $t1, 2		#t3 = i*4
		add $t3, $t3, $t0	#t3 holding adress of array+(4*i)
		
		jal printMessage2
		jal getInput	
		move $t2, $v0		#store input in t2		
		sw $t2, 0($t3)		#store input into array
		
		addi $t1, $t1, 1 	#t1 += 1
		j while
		
		exit:
			jal CheckSumPossibility
	
			beq $v0, $zero, notPos #if(v0 == 0) goTO notPos
			jal printPossible
			li $v0,10
			syscall
			
		notPos:
			jal printNotpossible			
			li $v0,10
			syscall


	printMessage:
	li $v0,4
	la $a0,msg1
	syscall 
	jr $ra
	
	printMessage2:
	li $v0,4
	la $a0,msg2
	syscall 
	jr $ra
	
	printMessage3:
	li $v0,4
	la $a0,msg3
	syscall 
	jr $ra
	
	printPossible:
	li $v0,4
	la $a0,possible
	syscall 
	jr $ra
	
	printNotpossible:
	li $v0,4
	la $a0,notpossible
	syscall 
	jr $ra
	
	getInput:
	li $v0,5
	syscall
	jr $ra
				

	CheckSumPossibility:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp) 
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
				#s3 and s2 storing return values.
	
	add $s0, $a1, $zero	#store array size in $s0
	add $s1, $a2, $zero 	#store Sum number in $s1
	
	
	
	#Base cases
	beq $s1, 0, returnTrue	#(if num == 0) return 1
	beq $s0, 0, returnFalse	#(if size == 0) return 0
	
	addi $a1, $s0, -1	#size = size - 1
	sll $t5, $a1, 2		#t5 = (size-1)*4
	lb $t6, array($t5)	#t6 = array[size-1]
	
	slt $t7, $s1, $t6	#if(array[size-1]>num)
	beq $t7, $zero, else
	
	
	jal CheckSumPossibility	#(CheckSumPossibility(num, arr, size-1)
	or $s3, $zero, $v0	#storing return value in $s3	
	else:
		addi $a1, $s0, -1	#size = size-1
		jal CheckSumPossibility	#(CheckSumPossibility(num, arr, size-1)
		or $s2, $v0, $zero	#s2 storing return value
		
		addi $a1, $s0, -1
		sll $t5, $a1, 2	
		lb $t6, array($t5)
		
		sub $a2, $s1, $t6 	#num = num - array[size-1]	
		jal CheckSumPossibility	#(CheckSumPossibility(num-arr[size-1],arr, size -1);
	
		or $v0, $s2, $v0	# Using OR for all return values
		or $v0, $s3, $v0
		
		finishFunc:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			lw $s2, 12($sp)
			lw $s3, 16($sp)
			addi $sp, $sp, 20
			jr $ra
		
	
	returnTrue:
		li $v0, 1
		j finishFunc
	
	returnFalse:
		li $v0, 0
        	j finishFunc
	
	
