#Si scriva la routine assembler MIPS che implementa la funzione ricorsiva definita come segue:
#f(x,y,z) = 0 se x,y,z sono tutti 0
#f(x,y,z) = x * f(z+1,x-2,y) altrimenti

#A A0     B A1     C A2
# caso base: x y z = 0
# passo ricorsivo x * v0
.macro PROLOGO
	addi $sp, $sp -16
	sw   $a0, 0($sp) 
	sw   $a1, 4($sp) 
	sw   $a2, 8($sp) 
	sw   $ra, 12($sp) 
.end_macro

.macro EPILOGO
	lw   $a0, 0($sp) 
	lw   $a1, 4($sp) 
	lw   $a2, 8($sp) 
	lw   $ra, 12($sp) 
	addi $sp, $sp 16
.end_macro

.macro READ_INT
	li $v0, 5
	syscall
.end_macro

.text 
.globl main 
main:
	READ_INT
	move $a0, $v0    #x
	READ_INT
	move $a1, $v0    #y
	READ_INT
	move $a2, $v0   #z 
	
	jal F
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
F:
	PROLOGO
	#corpo della funzione	
	lw  $s0, 0($sp) #x serve per il calcolo nel passo ricorsivo
	lw   $t0, 0($sp) 
	lw   $t1, 4($sp)
	lw   $t2, 8($sp) 
	#uso tre registri, la loro somma sarà 0 solo quando a0,a1,a2, saranno 0 cont
	#se la loro somma è superiore a tre salto a caso base 
	move $t4, $zero
	move $t5, $zero
	move $t6, $zero
	seq $t4, $t0, $zero     # se x_originale = 0, setta t4 a 1
	seq $t5, $t1, $zero     # se y_originale = 0, setta t5 a 1
	seq $t6, $t2, $zero     # se z_originale = 0, setta t6 a 1
	add $t4, $t4, $t5
	add $t4, $t4, $t6
	beq $t4, 3, caso_base 

	#scambio i parametri
	#z in x      a2 in a0
	#x in y      a0 in a1
	#y in z      a1 in a2
	addi $t3, $t2, 1   # z + 1
	addi $t7, $t0, -2  # x - 2
	move $a0, $t3
	move $a1, $t7
	move $a2, $t1
	jal F

	lw $s0, 0($sp) 
	mul $v0, $s0, $v0
	#esco
finisci:
	EPILOGO
	jr $ra	

caso_base:
	li $v0, 0
	EPILOGO
	jr $ra