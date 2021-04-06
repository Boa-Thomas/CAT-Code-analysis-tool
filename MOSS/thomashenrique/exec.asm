#	Alunos: Henrique Pereira Ramos (19203630) e Thomas Adriaan Topfstedt (19204155)

.data
ARQ: .asciiz "C:/Users/conta/Desktop/mario.ppm"
CAB: .space 2
.align 2
FLTTYP: .word
.text

Main_run:

	li $t2, 0
	li $t7, 0
	li $a1, 0
	li $v0, 0
	li $t3, 0

File_open:
	
	li $v0, 13
	li $a1, 0 				#syscall open file flag
	la $a0, ARQ 				#file path 
	li $a2, 0 				#Syscall open file mode
	syscall
	
File_type:
	move $a0, $v0
	li $v0, 14
	la $a1, CAB 				#Input buffer
	li $a2, 1 				#File max read char
	syscall
File_read: 					#Check p6 format
	li $v0, 0	
	lbu $t1, 0($a1) 			#Load byte from file on vector a1
	bne $t1, 80, File_read_end 
	
	li $v0, 14
	syscall
	
	lbu $t1, 0($a1) 			#Load byte from file
	bne $t1, 54, File_read_end
	
	li $t0, 0
	
File_header: 					#Read file header loop
	
	li $v0, 14
	syscall
		
	lbu $t1, 0($a1)
	sb $t1, CAB+0($t7)
	addi $t7, $t7, 1
	
File_read_branch_check: 			#Branch depending of de equality
			
	beq $t1, 10, File_part_advance
	bne $t1, 10, File_header
		
		
File_part_advance:

	addi $t0, $t0, 1
	blt $t0, 4, File_header

	li $t2, 0
	li $t3, 65536 				#256x256
	li $s0, 0x10010000			#static date
	
BGR_to_RGB: 					# BGR to RGB conversion 

	li $v0, 14
	la $a1, FLTTYP
	li $a2, 1
	syscall
	
Red_channel:

	addi $a1, $a1, 1
	li $v0, 14
	syscall
	
Blue_channel:	

	addi $a1, $a1, 1
	li $v0, 14
	syscall
	
Bits_swap:
 							
	subi $a1, $a1, 2
	lw $t1, 0($a1)
	
	j Bitwise #Jumps to bitwise function

IMG_print:

	sw $t1, 0($s0) 				#save pixel data from vector s0 to the registry t1
	addi $s0, $s0, 4 			#advances to the next pixel of the image
	addi $t2, $t2, 1			#adds one to the pixel count
	blt $t2, $t3, BGR_to_RGB		#img conversion
	li $t3, 0 				#zero counters
	li $t2, 0
	
File_header_print:

	la $t1, CAB+0($t2)			#load address inside the vector t2
	lbu $a0, 0($t1)				#load byte inside vector t1
	li $v0, 11
	syscall
	
File_step_counter_addup:
		
	addi $t3, $t3, 1			#counter++
	addi $t2, $t2, 1			#counter++
		
	ble $t3, $t7, File_header_print 	#loop the process
	j File_read_end

Bitwise:
	srl $t4, $t1, 16 			#shift to the right 16	
	andi $t5, $t1, 0xff			#bitwise compare
	andi $t1, $t1, 0x00ff00			#bitwise compare
	sll $t5, $t5, 16			#shift left 16
	or $t1, $t1, $t4
	or $t1, $t1, $t5
	j IMG_print

File_read_end: 					#program end execution

	li $v0, 10
	syscall
