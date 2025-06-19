#Traccia 4. 
#Realizzare un programma in assembly MARS 
#che rimuove il carattere spazio, " ", da una stringa definita in memoria.

.data
stringa: .asciiz "Hello, Samur4!"
len: .word 14
space: .ascii " "
str_vuota: .asciiz ""

.macro PRINT_STR
.end_macro
.text
.globl main
main:
	la $t0, stringa
	li $t1, 0
	lw $t2, len
	la $a0, str_vuota
ciclo:
	beq  $t1,$t2, fine # se indice = lunghezza stringa si esce
	addi $t1,$t1,1    #aumento indice
	lb   $t3, 0($t0)    #carico la parola
	addi $t0, $t0, 1
	lb   $t4, space     #carico l'ascii bin di spazio in t4 per fare il paragone
	beq  $t3,$t4, spazio_trovato
	#controlla parola
	sb   $t3, 0($a0)
	addi $a0, $a0, 1
	j ciclo
spazio_trovato:
	j ciclo	
fine:
	la $a0, str_vuota
	li $v0, 4
	syscall
	li $v0, 10
	syscall
		