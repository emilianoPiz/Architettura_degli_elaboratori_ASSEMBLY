.text
.globl main

main:	
	lw $t1 , x  #valore x della somma binaria
	lw $t2 , y  #valore y della somma binaria
	add $t0,$t1,$t2 #istruzione di somma (addition) 
	
li $v0,10	#termine del programma
syscall

.data 	#assegnazione delle word dentro i registri 
x:2	
y:8