#Meghna Basu and Tasnim Mahmud
#Professor Karen Mazidi
#Project
#CS 3340.502
#Date : 11/20/2017

############################################# Conway’s Game of Life  ############################################
#   This game is played on a grid of square cells, each of which is in one of two possible states, 		#
#   alive or dead, or "populated" or "unpopulated". Every cell interacts with its eight neighbor cells,		#
#   which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time,	#
#   the following transitions occur:										#
#	1	Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.		#
#	2	Any live cell with two or three live neighbors lives on to the next generation.			#
#	3	Any live cell with more than three live neighbors dies, as if by overpopulation.		#
#	4	Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.	#
#The initial pattern constitutes the seed of the system. The rules continue to be applied repeatedly     	#
#														#
#################################################################################################################

.data
# Board for first generation
Row0:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  
Row2:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row3:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row4:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row5: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row6: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row7: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row8:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Row9: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
# Board of new geration
NgRow0:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow1:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  
NgRow2:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow3:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow4:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow5: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow6: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow7: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow8:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NgRow9: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
size:	.word 10			   #size of the board 10X10
Life:	.ascii "*"			   #alive shell will display a "*" 
Death:  .ascii "-"			   #dead shell will display a " " 
EndLine: .asciiz "\n"

# messages 
StrWelcome:	.asciiz "Welcome to the GAME OF LIFE"
InputRow0:	.asciiz "enter life in 1st row"
InputRow1:	.asciiz "enter life in 2nd row"
InputRow2:	.asciiz "enter life in 3rd row"
InputRow3:	.asciiz "enter life in 4th row"
InputRow4:	.asciiz "enter life in 5th row"
InputRow5:	.asciiz "enter life in 6th row"
InputRow6:	.asciiz "enter life in 7th row"
InputRow7:	.asciiz "enter life in 8th row"
InputRow8:	.asciiz "enter life in 9th row"
InputRow9:	.asciiz "enter life in 10th row"

InputCellNum: 	.asciiz "Please enter a number from 0 to 9 which cell need to be alive or cancel : "
InputError: 	.asciiz "OUT OF RANGE"

DoneInput : 	.asciiz "Lets see the live cells"
NextGen : 	.asciiz "Lets see the next generation"
Bye:		.asciiz "Have a nice day. Good bye"

.text
######Starting up the Game of Life######
Main :		
WelcomeMessage:		la $a0, StrWelcome
			li $a1, 1
			li $v0, 55
			syscall     #showing welcome message
			
			
			
####################	     Start the game 		#####################	

li  $s1, 1  	# $s0 has value for life
lw  $s2, size	# $s2 has size of each row
li  $s3, -1	#value of the status for wrong input
######   Putting lives in Row0  #######	
StartRow0:	        la $a0, InputRow0
			li $a1, 1
			li $v0, 55
			syscall     #showing the message for Row0 input
			
LoopRow0 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow0		#if not a valid interger, then back to LoopRow0
	   		bne $a1, $zero, StartRow1	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg0	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg0		#checkin input value for bound
	   		la  $t0, Row0			#loading the Row0 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow0
ErrorMsg0:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow0
	   		
	   		
######   Putting lives in Row1  #######		   		
StartRow1:		la $a0, InputRow1
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow1 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow1		#if not a valid interger, then back to LoopRow1
	   		bne $a1, $zero, StartRow2	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg1	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg1		#checkin input value for bound
	   		la  $t0, Row1			#loading the Row1 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow1	
ErrorMsg1:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow1	   		
######   Putting lives in Row2  #######		   		
StartRow2:		la $a0, InputRow2
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow2 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow2		#if not a valid interger, then back to LoopRow2
	   		bne $a1, $zero, StartRow3	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg2	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg2		#checkin input value for bound
	   		la  $t0, Row2			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow2	   		   	   		   		   
ErrorMsg2:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow2	   		   
######   Putting lives in Row3  #######		   		
StartRow3:		la $a0, InputRow3
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow3 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow3		#if not a valid interger, then back to LoopRow3
	   		beq $a1, $s3, LoopRow3		#if not a valid interger, then back to LoopRow3
	   		bne $a1, $zero, StartRow4	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg3	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg3		#checkin input value for bound
	   		la  $t0, Row3			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow3	   		   	   		   		   
ErrorMsg3:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow3
######   Putting lives in Row4  #######		   		
StartRow4:		la $a0, InputRow4
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow4 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow4		#if not a valid interger, then back to LoopRow4
	   		bne $a1, $zero, StartRow5	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg4	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg4		#checkin input value for bound
	   		la  $t0, Row4			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow4	   		   	   		   		   
ErrorMsg4:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow4	 				 	   		  	
######   Putting lives in Row5  #######		   		
StartRow5:		la $a0, InputRow5
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow5 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow5		#if not a valid interger, then back to LoopRow5
	   		bne $a1, $zero, StartRow6	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg5	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg5		#checkin input value for bound
	   		la  $t0, Row5			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow5	   		   	   		   		   
ErrorMsg5:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow5	 
######   Putting lives in Row6  #######		   		
StartRow6:		la $a0, InputRow6
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow6 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow6		#if not a valid interger, then back to LoopRow6
	   		bne $a1, $zero, StartRow7	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg6	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg6		#checkin input value for bound
	   		la  $t0, Row6			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow6	   		   	   		   		   
ErrorMsg6:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow6
######   Putting lives in Row7  #######		   		
StartRow7:		la $a0, InputRow7
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow7:		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow7		#if not a valid interger, then back to LoopRow7
	   		bne $a1, $zero, StartRow8	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg7	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg7		#checkin input value for bound
	   		la  $t0, Row7			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow7	   		   	   		   		   
ErrorMsg7:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow7
######   Putting lives in Row8  #######		   		
StartRow8:		la $a0, InputRow8
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow8 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow8		#if not a valid interger, then back to LoopRow8
	   		bne $a1, $zero, StartRow9	#checking for valid integer
	   		blt $a0, $zero, ErrorMsg8	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg8		#checkin input value for bound
	   		la  $t0, Row8			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow8	   		   	   		   		   
ErrorMsg8:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow8	
######   Putting lives in Row9  #######		   		
StartRow9:		la $a0, InputRow9
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for Row1 input	   		
LoopRow9 :		la $a0, InputCellNum  
	   		li $v0, 51
	   		syscall   			#showing the input msg for input cell number
	   		beq $a1, $s3, LoopRow9		#if not a valid interger, then back to LoopRow1
	   		bne $a1, $zero, FinishInput	#If press cancel/blanck, go to DoneInput
	   		blt $a0, $zero, ErrorMsg9	#checkin input value for bound
	   		bge $a0, $s2, ErrorMsg9		#checkin input value for bound
	   		la  $t0, Row9			#loading the Row2 to $t0
	   		li  $t1, 4			#$t1 = 4 for increment		
	   		mul $t1, $t1, $a0		#$t1 = user input number * 4
	   		add $t0, $t0, $t1	
	   		sw  $s1, 0($t0)			#store 1 in live cell
	   		j LoopRow9	   		   	   		   		   
ErrorMsg9:   		la $a0, InputError
			li $a1, 1
			li $v0, 55
			syscall
			j LoopRow9	 
######  Finish input ######
FinishInput : 		la $a0, DoneInput
			li $a1, 1
			li $v0, 55
			syscall     			#showing the message for done with input and start the game
			j DisplayBoard
			
####### Generating Generation ######
NewGeneration : 	la $a0, NextGen
			li $v0, 50
			syscall
			bne $a0, $zero, Exit
			li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell	
			
### For Row0 ### 
			la $t0, Row0		#$s0 hold the address of the row0
			la $t3, Row1
			li $s6, 0 	#$s6 = Neighbor count
			li $s0, 0	#$s0 = index = 0
			#counting neighbor for Row0 Column0 
			lw $s5, ($t3)		#checking live in cell Row1 Column0
			jal CountNeighbor
			add $t3, $t3, 4
			lw $s5, ($t3)		#checking live in cell Row1 Column1
			jal CountNeighbor
			add $t0, $t0, 4
			lw $s5, ($t0)		#checking live in cell Row0 Column1
			jal CountNeighbor
			jal NewGenRow0
			addi $s0, $s0,1		# increament the index
			#counting neighbor for Row0 Column9 
CountRow0:       	li $s6, 0		# resetting the Neighbor Count 0
			la $t0, Row0		# $t0 hold the address of the row0
			la $t3, Row1		# $t3 hold the address of the row1
			mul $t1, $s0, 4		# 
			add $t0, $t0, $t1
			add $t3, $t3, $t1
			lw  $s5, ($t3)		# checking for neighbor in Row1 Column below
			jal CountNeighbor
			addi $t3, $t3, 4	# checking for neighbor in Row1 Column after
			lw  $s5, ($t3)		
			jal CountNeighbor
			addi $t3, $t3, -8	# checking for neighbor in Row1 Column before
			lw  $s5, ($t3)
			jal CountNeighbor
			addi $t0, $t0, 4	# checking neighbor in Row0 Column after
			lw $s5, ($t0)
			jal CountNeighbor
			addi $t0, $t0, -8	# checking neighbor in Row0 Column before
			lw $s5, ($t0)
			jal CountNeighbor
			jal NewGenRow0		# making change in new gen
			addi $s0, $s0, 1	#increament of the index
			beq $s0, 9, LastCell0
			j CountRow0
LastCell0: 		li $s6, 0	     	# resetting the Neighbor Count 0
			la $t0, Row0		# $t0 hold the address of the row0
			la $t3, Row1		# $t3 hold the address of the row1
			mul $t1, $s0, 4		# 
			add $t0, $t0, $t1
			add $t3, $t3, $t1
			addi $t0, $t0, -4		# checking neighbor in Row0 Column 8			
			lw $s5, ($t0)
			jal CountNeighbor
			lw $s5, ($t3)		# checking neighbor in Row1 Column 9
			jal CountNeighbor
			addi $t3, $t3, -4	# checking neighbor in Row1 Column 8
			lw $s5, ($t3)
			jal CountNeighbor
			jal NewGenRow1		# making change in new gen
### For Row1 to Row8 ### 
			#Row1#	
			la $a0, Row0		
			la $a1, Row1
			la $a2, Row2
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow1		#update new generation
	StartLoop1:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn1
			la $a0, Row0		#reset address
			la $a1, Row1
			la $a2, Row2
			jal CountMiddleColumn
			jal NewGenRow1
			li $s6, 0		#reset the neighbor count
			j StartLoop1
	LastColumn1:	la $a0, Row0		#reset address
			la $a1, Row1
			la $a2, Row2
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow1		#resetting the value of new gen of last cell
			li $s6, 0		
			#Row2#
			la $a0, Row1		
			la $a1, Row2
			la $a2, Row3
			li $s6, 0
			li $s0, 0		#reset the index
			jal CountFirstColumn
			jal NewGenRow2		#update new generation
	StartLoop2:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn2
			la $a0, Row1		#reset address
			la $a1, Row2
			la $a2, Row3
			jal CountMiddleColumn
			jal NewGenRow2
			li $s6, 0		#reset the neighbor count
			j StartLoop2
	LastColumn2:	la $a0, Row1		#reset address
			la $a1, Row2
			la $a2, Row3
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow2		#resetting the value of new gen of last cell
			li $s6, 0
			#Row3#
			la $a0, Row2		
			la $a1, Row3
			la $a2, Row4
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow3		#update new generation
	StartLoop3:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn3
			la $a0, Row2		#reset address
			la $a1, Row3
			la $a2, Row4
			jal CountMiddleColumn
			jal NewGenRow3
			li $s6, 0		#reset the neighbor count
			j StartLoop3
	LastColumn3:	la $a0, Row2		#reset address
			la $a1, Row3
			la $a2, Row4
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow3		#resetting the value of new gen of last cell
			li $s6, 0	
			#Row4#
			la $a0, Row3		
			la $a1, Row4
			la $a2, Row5
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow4		#update new generation
	StartLoop4:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn4
			la $a0, Row3		#reset address
			la $a1, Row4
			la $a2, Row5
			jal CountMiddleColumn
			jal NewGenRow4
			li $s6, 0		#reset the neighbor count
			j StartLoop4
	LastColumn4:	la $a0, Row3		#reset address
			la $a1, Row4
			la $a2, Row5
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow4		#resetting the value of new gen of last cell
			li $s6, 0
			#Row5#
			la $a0, Row4		
			la $a1, Row5
			la $a2, Row6
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow5		#update new generation
	StartLoop5:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn5
			la $a0, Row4		#reset address
			la $a1, Row5
			la $a2, Row6
			jal CountMiddleColumn
			jal NewGenRow5
			li $s6, 0		#reset the neighbor count
			j StartLoop5
	LastColumn5:	la $a0, Row4		#reset address
			la $a1, Row5
			la $a2, Row6
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow5		#resetting the value of new gen of last cell
			li $s6, 0		
			#Row6#
			la $a0, Row5		
			la $a1, Row6
			la $a2, Row7
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow6		#update new generation
	StartLoop6:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn6
			la $a0, Row5		#reset address
			la $a1, Row6
			la $a2, Row7
			jal CountMiddleColumn
			jal NewGenRow6
			li $s6, 0		#reset the neighbor count
			j StartLoop6
	LastColumn6:	la $a0, Row5		#reset address
			la $a1, Row6
			la $a2, Row7
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow6		#resetting the value of new gen of last cell
			li $s6, 0
			#Row7#
			la $a0, Row6		
			la $a1, Row7
			la $a2, Row8
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow7		#update new generation
	StartLoop7:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn7
			la $a0, Row6		#reset address
			la $a1, Row7
			la $a2, Row8
			jal CountMiddleColumn
			jal NewGenRow7
			li $s6, 0		#reset the neighbor count
			j StartLoop7
	LastColumn7:	la $a0, Row6		#reset address
			la $a1, Row7
			la $a2, Row8
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow7		#resetting the value of new gen of last cell
			li $s6, 0
			#Row8#
			la $a0, Row7		
			la $a1, Row8
			la $a2, Row9
			li $s6, 0
			li $s0, 0
			jal CountFirstColumn
			jal NewGenRow8		#update new generation
	StartLoop8:	addi $s0, $s0, 1	#increament the index
			beq $s0, 9, LastColumn8
			la $a0, Row7		#reset address
			la $a1, Row8
			la $a2, Row9
			jal CountMiddleColumn
			jal NewGenRow8
			li $s6, 0		#reset the neighbor count
			j StartLoop8
	LastColumn8:	la $a0, Row7		#reset address
			la $a1, Row8
			la $a2, Row9
			jal LastColumn		#count Neghbor for last cell
			jal NewGenRow8		#resetting the value of new gen of last cell
			li $s6, 0												
			#Row9#
			la $a0, Row8
			la $a1, Row9
			li $s6, 0
			li $s0, 0   		#reset the index
			# count neighbor for first colmn of row 9
			lw $s5, ($a0)		#checking neighbor in above cell
			jal CountNeighbor
			addi $t0, $a0, 4	#checking neighbor in above right cell
			lw $s5, ($t0)
			jal CountNeighbor
			addi $t0, $a1, 4	#checking neighbor in  right cell
			lw $s5, ($t0)
			jal CountNeighbor					
			jal NewGenRow9		#resetting the value of new gen of last cell
			li $s6, 0
			# count neighbor for 2nd to 8th column 
	StartLoop9:	addi $s0, $s0, 1	#
			beq $s0, 9, LastColumn9
			mul $t0, $s0, 4
			add $t1, $a0, $t0	#gettin to the column
			add $t2, $a1, $t0
			lw $s5, ($t1)		#checking neighbor of above
			jal CountNeighbor
			add $t1, $t1, -4	#checking neighbor in above left
			lw $s5, ($t1)
			jal CountNeighbor
			add $t1, $t1, 8		#checking neighbor in above right
			lw $s5, ($t1)
			jal CountNeighbor	
			add $t2, $t2, -4	#checking neighbor in  left
			lw $s5, ($t2)
			jal CountNeighbor
			add $t2, $t2, 8		#checking neighbor in  right
			lw $s5, ($t2)
			jal CountNeighbor
			jal NewGenRow9		#resetting the value of new gen of last cell
			li $s6, 0
			j StartLoop9																							
	LastColumn9:	mul $t0, $s0, 4
			add $t1, $a0, $t0	#$t1 = Row 8 column 9
			add $t2, $a1, $t0	#$t2 = Row 9 column 9
			lw $s5, ($t1)		#checking neighbor of above
			jal CountNeighbor
			addi $t1, $t1, -4
			lw $s5, ($t1)		#checking neighbor of above left
			jal CountNeighbor
			addi $t2, $t2, -4	#checking neighbor in left
			lw $s5,($t2)
			jal CountNeighbor 
			jal NewGenRow9		#resetting the value of new gen of last cell
			li $s6, 0

###### Copy the New Generation to the old array and Reset the New Generation ######
		lw $s1, size	# $s1 = size =10
CopyRow0:	la $a0, Row0
		la $a1, NgRow0
		li $s0, 0	# index
		jal CopyLoop
CopyRow1:	la $a0, Row1
		la $a1, NgRow1
		li $s0, 0	# index
		jal CopyLoop
CopyRow2:	la $a0, Row2
		la $a1, NgRow2
		li $s0, 0	# index
		jal CopyLoop
CopyRow3:	la $a0, Row3
		la $a1, NgRow3
		li $s0, 0	# index
		jal CopyLoop
CopyRow4:	la $a0, Row4
		la $a1, NgRow4
		li $s0, 0	# index
		jal CopyLoop
CopyRow5:	la $a0, Row5
		la $a1, NgRow5
		li $s0, 0	# index
		jal CopyLoop	
CopyRow6:	la $a0, Row6
		la $a1, NgRow6
		li $s0, 0	# index
		jal CopyLoop
CopyRow7:	la $a0, Row7
		la $a1, NgRow7
		li $s0, 0	# index
		jal CopyLoop
CopyRow8:	la $a0, Row8
		la $a1, NgRow8
		li $s0, 0	# index
		jal CopyLoop
CopyRow9:	la $a0, Row9
		la $a1, NgRow9
		li $s0, 0	# index
		jal CopyLoop
		j DisplayBoard																							
  CopyLoop :	lw $t0, ($a1)
  		sw $t0, ($a0)
  		sw $zero, ($a1)
  		addi $a0, $a0, 4
  		addi $a1, $a1, 4
  		addi $s0, $s0,1
  		beq $s0, 10, BrkLoop
  		j CopyLoop
      BrkLoop:	jr $ra	

												
																																					
																												
CountFirstColumn:	addi $sp, $sp, -4
			sw $ra, ($sp)		#storing the address for going back
			lw $s5, ($a0)		#checking neighbor in above row
			jal CountNeighbor
			addi $a0, $a0, 4	#checking neighbor in above row right
			lw $s5, ($a0)		
			jal CountNeighbor	 
			addi $a1, $a1, 4	#checking neighbor in right side same Row
			lw $s5, ($a1)
			jal CountNeighbor
			lw $s5, ($a2) 		#checking neighbor in below row
			jal CountNeighbor
			add $a2, $a2, 4		#checking neighbor in below row right
			lw $s5, ($a2)
			jal CountNeighbor
			lw $ra, ($sp)
			addi $sp, $sp, 4
			jr $ra						
CountMiddleColumn:	addi $sp, $sp, -4
			sw $ra, ($sp)		#storing returning address
			mul $t0, $s0, 4
			add $t1, $a0, $t0	#getting the middle element 				
			add $t2, $a1, $t0
			add $t3, $a2, $t0
			lw $s5, ($t1)		#checking neighbor in above Row
			jal CountNeighbor
			addi $t1, $t1, -4 	# checkeing neighbor in above Row left
			lw $s5, ($t1)		
			jal CountNeighbor
			addi $t1, $t1, 8 	# checkeing neighbor in above Row right
			lw $s5, ($t1)		
			jal CountNeighbor
			addi $t2, $t2, -4	#checking neighbor in left same row
			lw $s5, ($t2)		
			jal CountNeighbor
			addi $t2, $t2, 8	#checking neighbor in right same row
			lw $s5, ($t2)		
			jal CountNeighbor
			lw $s5, ($t3)		#checking neighbor in bottom row
			jal CountNeighbor
			addi $t3, $t3, -4	#checking neighbor in bottom row left
			lw $s5, ($t3)		
			jal CountNeighbor
			addi $t3, $t3, 8	#checking neighbor in bottom row left
			lw $s5, ($t3)		
			jal CountNeighbor
			lw $ra, ($sp)
			addi $sp, $sp, 4
			jr $ra
			
LastColumn:		addi $sp, $sp, -4
			sw $ra, ($sp)
			mul $t0, $s0, 4
			add $t1, $a0, $t0	#getting the las elements 				
			add $t2, $a1, $t0
			add $t3, $a2, $t0
			lw $s5, ($t1)           #checking neighbor in above Row
			jal CountNeighbor
			addi $t1, $t1,-4
			lw $s5, ($t1)           #checking neighbor in above Row left
			jal CountNeighbor
			addi $t2, $t2, -4	#checking neighbor in same Row left
			lw $s5, ($t2)
			jal CountNeighbor
			lw $s5, ($t3)		#checking neighbor in bottom Row
			jal CountNeighbor
			addi $t3, $t3, -4	#checking neighbor in bottom Row left				
			lw $s5, ($t3)		
			jal CountNeighbor
			#jal NewGenRow1																		
			lw $ra, ($sp)
			addi $sp, $sp, 4
			jr $ra
			
			
CountNeighbor:          beq $s5, $s1, AddNeighbor  	#Add neighbor if the cell has live
			jr $ra
	AddNeighbor:	addi $s6, $s6, 1	  	# increament the neighbor count
			jr $ra				#jamp back 
			
### creating New Generation for Row0 ###			
NewGenRow0:  		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow0	   		
			mul $t2, $s0, 4
			add $t1, $t1, $t2  
			bge $s6, $s4, NewGenDead0	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive0
			ble $s6, $s1, NewGenDead0
			beq $s6, $s2, NewGenUnchange0
	NewGenDead0: 	# putting 0 in the new gen array
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive0:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange0:# copying the value from Row0 to the NgRow0
			la $t3, Row0
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra	
### creating New Generation for Row1 ###			
NewGenRow1: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow1			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead1	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive1
			ble $s6, $s1, NewGenDead1
			beq $s6, $s2, NewGenUnchange1
	NewGenDead1: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive1:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange1:# copying the value from Row0 to the NgRow0
			la $t3, Row1
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra
### creating New Generation for Row2 ###			
NewGenRow2: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow2			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead2	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive2
			ble $s6, $s1, NewGenDead2
			beq $s6, $s2, NewGenUnchange2
	NewGenDead2: 	# putting 0 in the new gen array  
			li $a0, 0
			sw $a0, ($t1)
			jr $ra	
	NewGenLive2:    # putting 1 in the new gen array
			li $t9, 0
			sw $t9, ($t1)
			jr $ra								
        NewGenUnchange2:# copying the value from Row0 to the NgRow0
			la $t3, Row2
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra
### creating New Generation for Row3 ###			
NewGenRow3: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow3			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead3	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive3
			ble $s6, $s1, NewGenDead3
			beq $s6, $s2, NewGenUnchange3
	NewGenDead3: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive3:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange3:# copying the value from Row0 to the NgRow0
			la $t3, Row3
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra
### creating New Generation for Row4 ###			
NewGenRow4: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow4			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead4	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive4
			ble $s6, $s1, NewGenDead4
			beq $s6, $s2, NewGenUnchange4
	NewGenDead4: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive4:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange4:# copying the value from Row0 to the NgRow0
			la $t3, Row4
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra	
### creating New Generation for Row5 ###			
NewGenRow5: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow5			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead5	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive5
			ble $s6, $s1, NewGenDead5
			beq $s6, $s2, NewGenUnchange5
	NewGenDead5: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive5:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange5:# copying the value from Row0 to the NgRow0
			la $t3, Row5
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra											
### creating New Generation for Row6 ###			
NewGenRow6: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow6			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead6	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive6
			ble $s6, $s1, NewGenDead6
			beq $s6, $s2, NewGenUnchange6
	NewGenDead6: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive6:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange6:# copying the value from Row0 to the NgRow0
			la $t3, Row6
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra	
### creating New Generation for Row7 ###			
NewGenRow7: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow7			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead7	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive7
			ble $s6, $s1, NewGenDead7
			beq $s6, $s2, NewGenUnchange7
	NewGenDead7: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive7:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange7:# copying the value from Row0 to the NgRow0
			la $t3, Row7
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra	
### creating New Generation for Row8 ###			
NewGenRow8: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow8			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead8	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive8
			ble $s6, $s1, NewGenDead8
			beq $s6, $s2, NewGenUnchange8
	NewGenDead8: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive8:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange8:# copying the value from Row0 to the NgRow0
			la $t3, Row8
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra	
### creating New Generation for Row9 ###			
NewGenRow9: 		li $s1, 1    #value of live cell and number of lonely neighbor
			li $s3, 3    #Number of neighbor for regenerate
			li $s4, 4    #Number of neighbor for crowdiness
			li $s2, 2    #Number of neighbor for unchanged cell
			la $t1, NgRow9			
			mul $t2, $s0, 4
			add $t1, $t1, $t2
			bge $s6, $s4, NewGenDead9	# If neighbor Count == 4, the cell die
			beq $s6, $s3, NewGenLive9
			ble $s6, $s1, NewGenDead9
			beq $s6, $s2, NewGenUnchange9
	NewGenDead9: 	# putting 0 in the new gen array  
			li $t9, 0
			sw $t9, ($t1)
			jr $ra	
	NewGenLive9:    # putting 1 in the new gen array
			sw $s1, ($t1)
			jr $ra								
        NewGenUnchange9:# copying the value from Row0 to the NgRow0
			la $t3, Row9
			add $t3, $t3, $t2
			lw $t4,($t3)
			sw $t4, ($t1)
			jr $ra																					
			
###### Display the board ######	
DisplayBoard:		#addi $sp, $sp, -4
			#sw $ra, 0($sp)
			lw $s0, size
			li $s1, 1			#s1 has the value of life
			li $s2, 0
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row0 			#load the Row0 to $t0
			jal PrintRow			#jamp and link PrintRow for Row0
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row1 			#load the Row1 to $t0
			jal PrintRow			#jamp and link PrintRow for Row1
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row2 			#load the Row1 to $t0
			jal PrintRow			#jamp and link PrintRow for Row3
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row3 			#load the Row3 to $t0
			jal PrintRow			#jamp and link PrintRow for Row1
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row4 			#load the Row4 to $t0
			jal PrintRow			#jamp and link PrintRow for Row4
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row5 			#load the Row1 to $t0
			jal PrintRow			#jamp and link PrintRow for Row5
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row6 			#load the Row6 to $t0
			jal PrintRow			#jamp and link PrintRow for Row6
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row7 			#load the Row7 to $t0
			jal PrintRow			#jamp and link PrintRow for Row7
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row8 			#load the Row8 to $t0
			jal PrintRow			#jamp and link PrintRow for Row8
			li $s3, 0 			#$s3 = i = 0
			la $t0, Row9 			#load the Row9 to $t0
			jal PrintRow			#jamp and link PrintRow for Row9
			j NewGeneration	
PrintRow: 		addi $sp, $sp,-4
			sw $ra, ($sp)
			lw $t1, ($t0)			# $t1 = Row [i]
			beq $t1, $s1, PrintLife 	# if $t1 == 1, $t2 = 1, else $t2 = 0
			lb $a0, Death			#print Death
			li $v0, 11
			syscall
			addi $t0, $t0, 4		#increament of the address
			addi $s3, $s3, 1 		#increament of the array counter
			bge  $s3, $s0, DoneRow 		#if i >= 10
			j PrintRow
	PrintLife:	lb $a0, Life			#$a0 = "*"
			li $v0, 11			#print "*" for alive cells
			syscall
			addi $t0, $t0, 4		#increament of the address
			addi $s3, $s3, 1 		#increament of the array counter
			bge  $s3, $s0, DoneRow 		#if i >= 10
			j PrintRow
	DoneRow:	la $a0, EndLine
			li $v0, 4
			syscall	
			lw $ra, ($sp)
			addi $sp, $sp, 4
			jr $ra
								

													 				 				 						
Exit:			la $a0, Bye
			li $a1, 1
			li $v0, 55
			syscall     #showing Good bye message
			
			li $v0, 10
			syscall
