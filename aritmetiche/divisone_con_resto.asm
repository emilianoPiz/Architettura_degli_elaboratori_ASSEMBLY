.text
.globl main

main: 
	lw $t1, dividendo
	lw $t2, divisore
	div $t1,$t2
	mflo $t3     #carica quoziente da lo in $t3
	mfhi $t4     #carica resto da hi in $t4
li $v0, 10
syscall

.data
dividendo:  .word 10
divisore:   .word 3