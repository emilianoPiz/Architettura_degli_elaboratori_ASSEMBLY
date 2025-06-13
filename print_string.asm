# scrivere un semplice programma che definisce una stringa in memoria e la stampa a console usando la syscall appropriata

.text
.globl main
 
main:
	la $a0, testo    #carico il testo
	j print #vado a stampa
	
	
	li,$v0, 10 #carico servizo di fine
	syscall    #fine
print:
	li $v0, 4 #carico il servizio che stampa caratteri
	syscall   #stampo
	
	
	
.data
testo: .asciiz "do it"
