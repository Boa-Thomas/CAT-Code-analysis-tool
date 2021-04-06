# programa de Alex Lago(19201517) e Luan Barreto(19202934)
.data

Arq: .asciiz "C:/Users/Luan Barreto/Desktop/homer.ppm"
Tam: .space 1024
.align 2
Imag: .word

.text
 
 main:
	li $v0, 13
	la $a0, Arq
	li $a1, 0
	li $a2, 0
	syscall
	
	li $t2, 0
	li $t3, 0
	li $gp, 0

	move $a0, $v0
	li $v0, 14
	la $a1, Tam
	li $a2, 1
	syscall
	
	lbu $t1, 0($a1)
	bne $t1, 80, termina
	
	li $v0, 14
	syscall
	
	li $t0, 0
	
Loop:
	li $v0, 14
	syscall
		
	lbu $t1, 0($a1)
	sb $t1, Tam+0($gp)
	addi $gp, $gp, 1
				
	beq $t1, 9, Soma
	bne $t1, 9, Loop
		
Soma:
	addi $t0, $t0, 1
	blt $t0, 4, Loop

	li $s0, 0x10040000
	li $t3, 65536
	li $t2, 0

Concerta:
	li $v0, 14
	la $a1, Imag
	li $a2, 1
	syscall
		
	addi $a1, $a1, 1
	li $v0, 14
	syscall
	
	addi $a1, $a1, 1
	li $v0, 14
	syscall
	
	subi $a1, $a1, 2
	lw $t1, 0($a1)
	
	srl $t4, $t1, 16
	andi $sp, $t1, 0xff
	andi $t1, $t1, 0x00ff00
	sll $sp, $sp, 16
	or $t1, $t1, $t4
	or $t1, $t1, $sp
	
	sw $t1, 0($s0)
	addi $s0, $s0, 4
	addi $t2, $t2, 1
	blt $t2, $t3, Concerta
	li $t3, 0
	li $t2, 0

Headder:
	la $t1, Tam+0($t2)
	lbu $a0, 0($t1)
	li $v0, 11
	syscall
		
	addi $t3, $t3, 1
	addi $t2, $t2, 1
		
	ble $t3, $gp, Headder

termina:
	li $v0, 10
	syscall
