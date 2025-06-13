.globl main
main:
	li      $a0, 10		#inizio del range
	li 	$v0, 1		#servizio:print integer
	syscall 		#esegui system service
	j 	end		#salta a fine

end:	
li $v0, 10			#servizio: exit (terminate execution) 
syscall
