#Jorge Luiz Satler Coltro e Vinicius Afonso Heinen

.data
ARQ: .asciiz "C:/Users/Vinicius/Documents/UFSC/Micro/homer.ppm"
CAB: .space 1024
arquivo: .space 1024
ABRIR: .asciiz "Digite o caminho do arquivo que deseja abrir:\n"
IMG: .word 0

.text
Caminho:
	li $v0, 4
	la $a0, ABRIR
	syscall 

	li $v0, 8
	la $a0, arquivo
	la $a1, 1024
	syscall

Main:
	li $v0, 13
	la $a0, ARQ
	li $a1, 0
	li $a2, 0
	syscall

	move $a0, $v0
	li $v0, 14
	la $a1, CAB
	li $a2, 1
	syscall

	lbu $k1, 0($a1)
	bne $k1, 80, Final

	li $v0, 14
	syscall

	lbu $k1, 0($a1)
	bne $k1, 54, Final

	li $k0, 0

Leitura_rep:
	li $v0, 14
	syscall

	lbu $k1, 0($a1)
	sb $k1, CAB($t5)
	addi $t5, $t5, 1

	beq $k1, 10, Somatorio
	bne $k1, 10, Leitura_rep		

Somatorio:
	addi $k0, $k0, 1
	blt $k0, 4, Leitura_rep

Parametros:
	li $s0, 0x10010000
	li $t1, 65536
	li $t0, 0

Correcao:
	li $v0, 14
	la $a1, IMG
	li $a2, 1
	syscall

	li $v0, 14
	addi $a1, $a1, 1
	syscall

	addi $a1, $a1, 1
	li $v0, 14
	syscall

	subi $a1, $a1, 2
	lw $k1, 0($a1)

	srl $t2, $k1, 16
	andi $t3, $k1, 0xff
	andi $k1, $k1, 0x00ff00
	sll $t3, $t3, 16
	or $k1, $k1, $t2
	or $k1, $k1, $t3

Print_imagem:
	sw $k1, 0($s0) 	
	addi $s0, $s0, 4 	
	addi $t0, $t0, 1	
	blt $t0, $t1, Correcao

Resetar:
	li $t1, 0
	li $t0, 0

Cabecalho:
	la $k1, CAB($t0)
	lbu $a0, 0($k1)
	li $v0, 9
	syscall

	addi $t1, $t1, 1
	addi $t0, $t0, 1

	ble $t1, $t5, Cabecalho

Final:
	li $v0, 10
	syscall