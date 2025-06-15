#SEZIONE: MATRICI
#Traccia 2. Definire una matrice 5x4 di word. FATTO 
#Realizzare un programma in linguaggio assemblativo che 
#consente di sommare il valore degli elementi di una colonna il cui valore è inserito da tastiera da un utente.

.data
matrice: .word 10,2,3,1
	       10,24,23,1
	       10,20,30,1
	       10,23,11,1
	       10,24,63,1
C: .word 4

.text
.globl main
main:
	#INIT
	move $s0, $zero 	 #somma totale degli elementi nella colonna scelta
	move $s1, $zero          #indice da aumentare
	lw $s3, C                #s3 numero colonne
	li $v0, 5
	syscall			
	move $s2, $v0	         #INTERO LETTO  in s2
	#FINE INIT
ciclo:
	# calcolo indice corrente
	mul $t0, $s1, $s3 # riga* num colonne
	add $t0, $t0, $s2 # t0 = #s3 numero colonne
	sll $t0, $t0, 2   # t0 punta all'elemento, dobbiamo solo sommargli l'indirizzo contenente l'inizio della matrice

	#carico nel processore la word all'indice corrente, la metto in t1
	lw $t1, matrice($t0)
	
	#somma su s0. s0= elemento corrente + s0
	add $s0, $t1, $s0
	
	#esco dal loop: aumento gli indici e vedo se indice == lunghezza_in_righe 
	addi, $s1, $s1, 1 
	#controllo se l'indice è uguale a 5 
	li   $t1, 5 	     #t1 ha esaurito il suo scopo, può essere usato per contenere il 5 da usare come paragone
	seq  $t1, $t1, $s1   #se l'indice è uguale a 5 $t1 diventa 1, altrimenti t1 diventa 0
	bgtz $t1, fine	     #se t1 è maggiore di 0 (quindi se è vero indice_corrente=lunghezza_massima) vai in fine
	j ciclo		     #se t1 è 0, allora mancano dei giri fare, fai un altro giro 
fine:
	move $a0, $s0   #metti la somma in a0 per printarla 
	li $v0, 1
	syscall
	
	li $v0, 10 	#esci dal programma 
	syscall 

