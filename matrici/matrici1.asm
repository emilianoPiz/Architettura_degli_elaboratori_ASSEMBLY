#SEZIONE: MATRICI 
#Traccia 1. Definire una matrice 5x5 di halfword. 
#Realizzare un programma che consente ad un utente di inserire da tastiera il numero di riga ed il numero di colonna (n,m) 
#visualizzare su schermo l'elemento corrispondente.
.data
matrice: .half  1,2,3,4,5        
		6,7,8,9,10
        	11,12,13,14,15
        	16,17,18,19,20
        	21,22,23,24,25
C: .word 5
#t0, numero_colonne C

.text
.globl main
main:
#1) leggi gli interi#######################
	#leggi index_n  in s0
	#leggi index_m   in s1
	li $v0,5
	syscall
	move $s0,$v0 #in s0 indice riga

	li $v0,5
	syscall
	move $s1,$v0 #in s1 indice colonna
##########################################

#2) utilizza s1 ed s0 ( cioè gli input interi ) nella formula per calcolare l'offset
# base+(riga_corrente*num_colonne+colonna_corrente)*n (n="quanti byte occupa l'elemento in memoria?",cioè n=numero di byte)
	#(s0 cioè riga)*(num_colonne Cioè t0)
	lw  $t0, C
	mul $t0, $s1, $t0	#t0 contiene riga*num_colonne
	add $t0, $s0, $t0	#t0 = t0+colonna_corrente o meglio s1, cioè l'intero immesso da input. t0=(riga_corrente*num_colonne+colonna_corrente)
	sll $t0, $t0, 1	        #siccome moltiplichiamo x2 (stiamo usando half-word) possiamo shiftare di 1 a sinistra ed ottenere lo stesso risultato

###QUI $t0 CONTIENE L'OFFSET, 
#QUINDI LO SOMMEREMO ALL'INDIRIZZO DELLA MATRICE PER PUNTARE ALL'ELEMENTO CHE CI INTERESSA LEGGERE
	lh $a0, matrice($t0)     #matrice($t0) è come dire   matrice + t0. ma t0 è l'offset matrice è il puntatore al primo elemento
				 #quindi matrice più offset è l'elemento. lo mettiamo direttamente in a0 per stamparlo
#########################################

#stampa ed esci dal programma
li $v0, 1   #servizio: stampa intero
syscall
li $v0, 10  #servizio: termina programma
syscall
