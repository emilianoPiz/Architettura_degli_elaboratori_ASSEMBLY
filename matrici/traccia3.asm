#Traccia 3. 
#Definire una matrice righe_3x4colonnee di byte. 
#Realizzare un programma in linguaggio assemblativo che 
#inizializza la matrice con un valore casuale tra 0 e 10.

.macro RANDOM_NUMBER_10
	li $a1, 10
	li $v0, 42
	syscall
.end_macro

.macro PRINT_STR
	li $v0, 4
	syscall 
.end_macro

.data
matrix:   .space 12
C:	  .word  4
riga:	  .word  0 
colonna:  .word  0
new_line: .asciiz "\n"
tab: 	  .asciiz "\t"

.text
.globl main
main:
	la $t0, matrix
	lw $s7,C   #4
	mul $s2, $s7,$s0 #dimensione bi-array = 12
	lw $s4,colonna      #indice colonna
	lw $s3,riga   	    #indice riga
	
ciclo_righe:
	beq $s3, 3, fine
	#riduco di uno indice righe
	addi $s3, $s3, 1 
	add $s4, $zero, $zero 
	la $a0, new_line
	PRINT_STR	
	
ciclo_colonne:
	beq $s4, 4, ciclo_righe
	addi $s4, $s4,1 
	
	#base +(riga*num_colonne+colonna)*word in s5
	mul $s5, $s3, $s7   #riga * numero_colonne
	add $s5, $s5, $s4   #riga*numero_colonne + colonna_corrente
	
	RANDOM_NUMBER_10 
	
	move $s6, $a0 #numero random in s0
	sb  $s6,matrix($s5)  #s5 elemento
	  
	move $v0,$s6
	li $v0,1    #printo intero corrente
	syscall 
	
	la $a0, tab
	PRINT_STR
	
	j ciclo_colonne
	
fine:
	li $v0, 10
	syscall
	 
	 
	 
	 