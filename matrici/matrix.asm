.data
matrice: .space 36
righe:   .word 3
colonne: .word 3 
testo_pre:  .asciiz "IMMETTI NUMERO (INTERO!):"
tab_sgn:    .asciiz"\t"
new_ln:     .asciiz"\n"

.macro END
	li $v0, 10 
	syscall
.end_macro

.macro INPUT_INT
	li $v0, 5
	syscall
.end_macro 

.macro STRING_PRINT
	li $v0, 4
	syscall
.end_macro 

.macro INTEGER_PRINT
	li $v0, 1
	syscall
.end_macro

.macro INCREASE_INDEX
	li $t0, 3
	mul $s4, $s1, $t0       #righe*num_colonne
	add $s4, $s4, $s2	#(righe*num_colonne+colonna)
	sll $s4, $s4, 2		#(righe*num_colonne+colonna)*4
	add $s4, $s4, $s0	#s4 contiene = indirizzo_base+(righe*num_colonne+colonna)*4
.end_macro

.text
.globl main 
main:
	la $s0, matrice   #inizio matrice
	lw $s1,  righe	  #numero righe
	lw $s2, colonne   #numero colonne 
	##################################
	#!!!!!!!INIZIO CICLO!!!!!!!!!!!!#
	##################################
giro_righe:
	subi  $s1, $s1,1 
	bltz  $s1, stampa
	#reset colonna
	lw $s2, colonne
giro_colonne:
	subi  $s2,$s2,1
	bltz $s2,giro_righe
	########## CORPO #################	
	#stampo testo per UI 
	la $a0, testo_pre
	STRING_PRINT
	
	#prendo int
	INPUT_INT
	#v0 contiene l'intero letto
	
	#calcolo indice
	INCREASE_INDEX
	#fine_calcolo_indice
	
	#inserisco il numero letto nella matrice s4 è l'indice 
	sw $v0,0($s4)
	
	b giro_colonne
	##############################################################
	
stampa:
	la $s0, matrice   #inizio matrice
	lw $s1,  righe	  #numero righe
	lw $s2, colonne   #numero colonne 
	##############################################################
	#!!!!!!!INIZIO CICLO!!!!!!!!!!!!#
	##############################################################
stampa_giro_righe:
	subi  $s1, $s1,1 
	bltz  $s1, fine
	#reset colonna
	lw    $s2, colonne
	#stampoi il mewline
	#stampo il tab
	la $a0, new_ln
	STRING_PRINT
stampa_giro_colonne:
	subi $s2, $s2,1
	bltz $s2, stampa_giro_righe
	#stampo il tab
	la $a0, tab_sgn
	STRING_PRINT
	
	#calcolo indice
	INCREASE_INDEX
	#fine_calcolo_indice
	
	#printo intero
	lw  $a0, 0($s4)
	INTEGER_PRINT
	
	#vado al successivo
	b stampa_giro_colonne
	############################################################	
fine:
	END	
	