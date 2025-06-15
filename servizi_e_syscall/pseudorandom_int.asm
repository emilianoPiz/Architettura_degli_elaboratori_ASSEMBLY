.globl main
main:
	li      $a0, 10		#inizio del range
	li	$a1, 1000	#fine del range
	li 	$v0, 1		#servizio: random int range-> inserisce un numero pseudo random nel range tra a0 e a1 in a0
	syscall 		#esegui system service
	move 	$t0, $a0	#sposta il numero rando da ao in $t0
	j 	end		#salta a fine

end:	
li $v0, 10			#servizio: exit (terminate execution) 
syscall
