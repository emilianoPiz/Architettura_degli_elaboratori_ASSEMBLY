.text
.globl main
main:
    la $a0, testo_pre_input #carico il primo carattere il a0
    #stampo il testo di interfaccia a terminale
    li $v0, 4    # 4 servizo print string
    syscall
    #######

    #leggo il numero
    li $v0, 5    # 5 servizio read integer
    syscall
    #######

    move $s0, $v0 #salvo n in $s0 per un uso sicuro e immodificabile
    move $a0, $s0 #copio il valore per comodità, $a0 = n (per input a CALCOLA_QUADRATO se necessario)
    move $a2, $s0 #uso l'intero immesso come indice da scalare per il primo ciclo, $a2 = n 
    move $a3, $s0 #uso l'intero immesso come indice da scalare per il secondo ciclo, $a3 = n 

    # init $a1 = 0.
    li $a1, 0

    bgtz $s0, CALCOLA_QUADRATO # Se n (in $s0) > 0, salta a CALCOLA_QUADRATO
    
    li $a0, 0       # Imposta il risultato finale a 0 per n <= 0
    j PRINT_RESULTS # Salta direttamente alla stampa (il cubo di 0 è 0)

CALCOLA_QUADRATO:
    add  $a1, $a1, $s0 # $a1 = $a1 + n_originale
    subi $a2, $a2, 1
    bgtz $a2, CALCOLA_QUADRATO
   
    li $a0, 0      # init $a0 come accumulatore per il cubo.

CALCOLA_CUBO:
    add  $a0, $a0, $a1 # $a0 = $a0 + (n*n)
    subi $a3, $a3, 1
    bgtz $a3, CALCOLA_CUBO
    # !!! al termine di questo ciclo, $a0 contiene n*n*n. !!!

PRINT_RESULTS: 
   
    la $a0, new_line 
    #stampo un new-line per mandare la risposta dell'output a capo rispetto ai testi di input
    li $v0, 4    # 4 servizo print string
    syscall
    #######
    la $a0, testo_post_proc 
    #stampo il testo di interfaccia a terminale
    li $v0, 4    # 4 servizo print string
    syscall
    #######

    li $v0, 1    # 1 servizio print integer
    syscall

    # Termina il programma
    li $v0, 10
    syscall

.data
testo_pre_input: .asciiz "Immetti un numero positivo (n>0)"
testo_post_proc: .asciiz "il cubo del numero è: "
new_line: .asciiz "\n"
