#Scrivere un programma in linguaggio assemblativo MARS che, 
#definiti due numeri (word) in memoria spazio e tempo, 
#che fanno riferimento ad un punto mobile nello spazio, 
#determina : La velocità del punto che si muove in modo rettilineo uniforme (risultato in $t0)
# formula velocità = deltaT/deltaS

.globl main 

main: 
	lw   $t1, tempo  #carica tempo in t1
	lw   $t3, spazio #carica spazio in t3
	div  $t1,$t3     #esegui la divisione intera
	mflo $t0	     #carica il quoziente in t0
	j    end 	     #salta a fine programma

end:
li $v0, 10
syscall


.data 
spazio: .word 10
tempo:  .word 10