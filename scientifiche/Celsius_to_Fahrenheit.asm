# Scrivere un programma che converta un valore da scala Celsius a scala Fahrenheit
#Definire in memoria una variabile intera (word) riportante il valore in scala Celsius
#Riportare il risultato in scala Fahrenheit in $t0 e in una cella in memoria
#ES: gradoC=38 quindi $t0=100
#OSS: Utilizzare le operazione tra interi (il valore risultante può essere approssimato)
# 1F = (9/5*nC)+32

.globl main 
main:
	lw   $t1, Celsius   # celsius
	li   $t3, 9	        # costante 9 
	mul  $t5, $t1, $t3  # celsius per 9
	li   $t7, 5	        # costante 5	
	div  $t5,$t7	    # 9C diviso 5
	mflo $t2	        # sposta il quoziente in t2
	addi $t0, $t2,32    # (9/5*C)+32
	j    end	        # fine programma
	
end:
li $v0,10
syscall	

.data
Celsius: .word 38 