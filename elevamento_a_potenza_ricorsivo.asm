.text
.globl main

main: 
	lw $t0, base
	lw $t1, esponente
	lw $t2, val
	j salto   #etichetta di salto
salto:
	beq $t1, $zero, fine   #caso base, esponente = 0 salta in fine
	mul $t2, $t2, $t0
	addi $t1, $t1, -1
	j salto                #caso ricorsivo, dopo la moltiplicazione esp è ancora >0, torna in salto
fine: 
li $v0, 10                 #fine del programma
syscall

.data                      #assegnazione dati 
base:	  .word 2    
esponente:.word 3 
val :     .word 1 