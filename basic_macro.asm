.text
.globl main
main:
	lw $t1, x
	lw $t2, y
	add $t3,$t2,$t1
	.end
.data
x:1
y:2
.macro end
li $v0,10
syscall
.end_macro 