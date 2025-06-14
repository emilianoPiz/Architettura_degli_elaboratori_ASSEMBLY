#traccia3
#Realizzare un programma in assembly MIPS/MARS che risolvela seguente funzione ricorsiva
#𝑓(𝑥, 𝑦, 𝑧) = 100 se x*z==0
#𝑓(𝑥 − 2, 𝑦 − 3, 𝑧 − 4) + 2𝑥𝑦 − 𝑥𝑧 − 3𝑧 altrimenti

.macro PROLOGO
	addi $sp, $sp, -20        
	sw   $s1, 0($sp)
	sw   $ra, 4($sp)
	sw   $a0, 8($sp)          # Salva x 
	sw   $a1, 12($sp)         # Salva y 
	sw   $a2, 16($sp)         # Salva z 
.end_macro

.macro EPILOGO
	lw   $s1, 0($sp)
	lw   $ra, 4($sp)
	lw   $a0, 8($sp)          # Ripristina valori originali
	lw   $a1, 12($sp)
	lw   $a2, 16($sp)
	addi $sp, $sp, 20
.end_macro

.text
.globl main
main:
############## PRENDI 3 INPUT DA TASTIERA ############################
li $v0, 5
syscall
move $a0, $v0            #X IN A0
li $v0, 5
syscall
move $a1, $v0		     #Y IN A1
li $v0, 5
syscall
move $a2, $v0		     #Z IN A2
####################################################################

############### chiama la funzione ricorsiva ######################
jal F
###################################################################
move $a0, $v0
li $v0, 1
syscall
###############ESCI DAL PROGRAMMA##################################
li $v0, 10
syscall
###################################################################

F:
	PROLOGO
	mulu $t0, $a0, $a2   #xz
	
	#########CASO BASE XY=0
	beqz $t0, caso_base

	###parametri per prossima chiamata
	sub $a0, $a0, 2 #x-2
	sub $a1, $a1, 3 #y-3
	sub $a2, $a2, 4 #z-4
	##############################
	
	###F(x-2,y-3,z-4)######
	jal F	
	move $s1, $v0	     # salvo il risultato della chiamata ricorsiva in s1
	
	#ripristina i valori originali per i calcoli
	lw $a0, 8($sp)       # x originale
	lw $a1, 12($sp)      # y originale  
	lw $a2, 16($sp)      # z originale
	
	
	mult $a0, $a1        # xy
	mflo $t2             # t2= xy
	sll $t2, $t2, 1      # t2 = 2xy
	
	mult $a0, $a2        # xz  
	mflo $t0             # t0 = xz
	
	li $t1, 3
	mult $a2, $t1        # 3z
	mflo $t1             # t1 = 3z
	
	sub $t2, $t2, $t0    # t2 = 2xy - xz
	sub $t2, $t2, $t1    # t2 = 2xy - xz - 3z
	
	add $v0, $s1, $t2  #v0 contiene: f(x-2,y-3,z-4) - 2xy - xz - 3z
	
	j fine_funzione
caso_base:
	li $v0, 100 #carico 100 nel registro v0
fine_funzione:				
	EPILOGO  #ripristina stack
	jr $ra	#torna al return 
	
	
	
	
	