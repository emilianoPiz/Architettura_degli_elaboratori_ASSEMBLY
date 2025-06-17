#traccia 4
#realizzare un programma che risolve la formula per risolvere le equazioni di secondo grado
#cioè dato a,b,c in input trova x1,x2=-b+sqrt(b^2+4ac)/2a
#se d<0 non esistono soluzioni reali
#se d == 0 due soluzioni reali coincidenti
#se d>0 allora due soluzioni reali distinte

.macro END
	li $v0,10 
	syscall
.end_macro

.macro PRINT_STR
	li $v0, 4
	syscall
.end_macro


.data
pre_input_str: .asciiz "immetti a,b,c (<0) per trovare x1,x2 della loro equazione di secondo grado [ x1,2=(ax^2+bx+c) ]"
a_str:.asciiz "a: "
b_str:.asciiz "b: "
c_str:.asciiz "c: "
new_line: .asciiz "\n"
tab: .asciiz "\t"
condizione_2soluzioni_reali: .asciiz "DUE SOLUZIONI REALI: "
condizione_2soluzioni_coincidenti: .asciiz "DUE SOLUZIONI COINCIDENTI: "
condizione_2soluzioni_non_reali:.asciiz "DUE SOLUZIONI NON REALI :( "
zerof: .float 0.0
duef: .float 2.0
quattrof:.float 4
#dati
#x 
#a in s0
#b in s1
#c in s2

.text
.globl main 
main:
	###############ZONA INPUT##############################
	la $a0, pre_input_str   #stampa il messaggio di benvenuto
	PRINT_STR
	la $a0, new_line   #stampa una riga
	PRINT_STR
	
	la $a0, a_str    #stampa il messaggio che indica quale variabile sta per immettere
	PRINT_STR
	li $v0, 5
	syscall		#immetti intero
	move $s0,$v0 	#in s0 a
	la $a0, new_line   #stampa una riga
	PRINT_STR
	
	la $a0, b_str   #stampa il messaggio che indica quale variabile sta per immettere
	PRINT_STR
	li $v0, 5
	syscall		#immetti intero
	move $s1,$v0 	#in s1 b
	la $a0, new_line   #stampa una riga
	PRINT_STR
	
	
	la $a0, c_str   #stampa il messaggio che indica quale variabile sta per immettere
	PRINT_STR
	li $v0, 5
	syscall		#immetti intero
	move $s2,$v0    #in s2 c
	la $a0, new_line   #stampa una riga
	PRINT_STR
	###############FINE ZONA INPUT##############################
	
	###############INIZIO CALCOLI COPROCESSORE##################	
	#mandare i numeri nel coproc
	mtc1 $s0,$f0 # a in f0
	mtc1 $s1,$f2 # b in f2
	mtc1 $s2,$f4 # c in f4
	############################
	
	#convertire i numeri da ca2 in virgola mobile
	cvt.s.w $f0, $f0   
	cvt.s.w $f2, $f2
	cvt.s.w $f4, $f4
	###########################################
	
	#calcola il delta	
	#d = sqrt.s(b^2-4ac)
	#1#
	mul.s $f6, $f0, $f4 #in f6 ac 
	l.s $f8, quattrof    #carica 4 in f8
	mul.s $f8,$f8,$f6  #in f8 4ac
	#2#
	mul.s $f6,$f2,$f2 #in f6 b^2
	#3#
	sub.s $f6, $f6, $f8 #in f6, b^2-4ac
	#controllo il delta <=0
	l.s $f30, zerof
	c.le.s $f30 , $f6
	bc1t soluzioni_reali
	#ESISTONO SOLO SOLUZIONI NON REALI
	la $a0, condizione_2soluzioni_non_reali
	PRINT_STR
	END
soluzioni_reali: 
	#4#
	sqrt.s $f6, $f6 # in f6 c'è il valore del delta
	###
	c.eq.s $f30, $f6
	bc1t soluzioni_coincidenti
	#x1,x2=-b+-sqrt(b^2+4ac)/2a
	
	#x1 in f20 e poi si stampa  
	neg.s $f16, $f2       #-b
	add.s $f8 ,$f16,$f6   #-b+delta
	l.s $f10, duef        #2 in float 
	mul.s $f12, $f10, $f0 #in f12 -> 2a
	div.s $f20, $f8,$f12  #x1 in f20
	#######################
	
	#x2 in f22 e poi si stampa
	sub.s $f14 ,$f16,$f6  #-b-delta
	div.s $f22, $f14,$f12 #x2 in f20
	
	#stampa le soluzioni##############
	la $a0, condizione_2soluzioni_reali
	PRINT_STR
	la $a0, new_line
	PRINT_STR
	la $a0, tab
	PRINT_STR
	mov.s $f12, $f20
	li $v0,2
	syscall
	la $a0, tab
	PRINT_STR
	mov.s $f12, $f22
	li $v0,2
	syscall
	#fine stampa########################
	END
soluzioni_coincidenti:

    #x1,2 in f20 e poi si stampa  
	neg.s $f16, $f2       #-b
	add.s $f8 ,$f16, $f6  #-b+delta
	l.s   $f10, duef      #2 in float 
	mul.s $f12, $f10, $f0 #in f12 -> 2a
	div.s $f20, $f8,$f12  #x1 in f20
	#######################

	#stampa le soluzioni##############
	la $a0, condizione_2soluzioni_coincidenti
	PRINT_STR
	la $a0, new_line
	PRINT_STR
	la $a0, tab
	PRINT_STR
	mov.s  $f12, $f20
	li $v0,2
	syscall
	#fine stampa########################
	END