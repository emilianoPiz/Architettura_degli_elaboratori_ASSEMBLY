.text
.globl main
main:
	l.d   $f4, a
	sqrt.d $f2, $f4 #t4 è doppia precisione quindi occupa anche t5
	li $v0,10
	syscall
	

.data 
a:.double 16.0