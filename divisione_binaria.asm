.text
.globl main
main:
	lw $t0, dividendo
	lw $t1, divisore
	div $t2, $t0,$t1
li $v0, 10

.data
divisore:  .word 3
dividendo: .word 9