# programma per ottenere un intero random in un intervallo scelto. 
# L'estremo superiore dell'intervallo ($a1) non può essere minore 
# dell'estremo inferiore ($a0) ne essere negativo. Altrimenti:
# Runtime exception … Upper bound of range cannot be negative (syscall 42)

.globl main
main:
	li      $a0, 0		#inizio del range
	li	    $a1, 1000	#fine del range
	li 	    $v0, 42		#servizio: random int range-> inserisce un numero pseudo random nel range tra a0 e a1 in a0
	syscall     		#esegui system service
	move 	$t0, $a0	#sposta il numero rando da ao in $t0
	j 	end		        #salta a fine

end:	
li $v0, 10			    #servizio: exit (terminate execution) 
syscall
