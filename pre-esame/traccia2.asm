.text
#sezione macro########################################################
.macro prologo
    #stack
    addi $sp, $sp, -12   # alloca spazio per $ra e per salvare l'argomento $a0
    sw   $ra, 4($sp)     # salva l'indirizzo di ritorno
    sw   $a0, 0($sp)     # salva l'argomento x (per sicurezza/chiarezza)
    sb   $a1, 8($sp)     #sala l'argomento y 
.end_macro

.macro epilogo
    #stack
    lw   $ra, 4($sp)
    lw   $a0, 0($sp)
    lbu   $a1, 8($sp)
    addi $sp, $sp, 12
.end_macro

.macro STRING_PRINT
	li $v0, 4
	syscall
.end_macro

.macro INT_PRINT
	li $v0, 1
	syscall
.end_macro

.macro END
    li $v0,10
    syscall
.end_macro
#fine sezione macro######################################################

.globl main

main:
    li $t0, 0 #indiceWord
    li $t1, 0 #indiceByte
    li $t2, 10  #lunghezza

ciclo:
    beqz $t2, fine      #IL T2 VERRà DECREMENTATO come counter per uscire dal ciclo 
    lw $a0,vett1($t0)   #Parametro_1
    lbu $a1,vett2($t1)  #Parametro_2

    jal ELEVA   #chiama la funzione ELEVA e salva il return address 
	
    addi $t0,$t0, 4      #incremento word
    addi $t1,$t1, 1      #incremento byte
    subi $t2,$t2, 1      #decremento t2 
    j ciclo 
fine:
    la $a0, testo_out  #stampa il messaggio di output
    STRING_PRINT
    move $a0, $a3      #metti il contatore in a0 per stamparlo
    INT_PRINT
    END                #esci dal programma 
    
################### ELEVA ##############################################
ELEVA:
    prologo  #predispone lo stack
    #===eleva al quadrato===#
    multu $a0, $a0
    mflo $a0
    multu $a1, $a1
    mflo $a1
    #=======================#
    ##ordinali: più grande in $a0
    slt $s0, $a0, $a1
    bgtz $s0, scambia #se a0 è più piccolo di a1, prima li scambi e poi entra in MULTIPLO
    j multiplo_init 
scambia:
    move $s1, $a0     #usa un registro d'appoggio per scambiare a0 e a1 
    move $a0, $a1
    move $a1, $s1
    j multiplo_init 
    
multiplo_init: 
    jal MULTIPLO #SI CHIAMA LA FUNZIONE INNER
    epilogo	#si ripristinano i registri
    jr $ra 	#si esce da ELEVA
####################ELEVA################################################

##################MULTIPLO###############################################
MULTIPLO:
    prologo       #predispone lo stack
    divu $a0, $a1 #dividi a0 per a1
    mflo $t5      #quoziente in s1
    li $t6, 10    #carica 10 per fare la divisione
    divu $t5,$t6  #esegui divisione per 10
    mfhi $t7      #carica il resto della divisione in t7
    beqz $t7, aumenta_counter #se 0,quindi la divisione non da resto allora è multiplo di 10
finish:    
    epilogo      #ripristina i registri 
    jr $ra       #torna in eleva
aumenta_counter:
addi $a3, $a3,1  #aumenta il counter di uno
j finish         #vai in finish 
#################MULITPLO###############################################



.data
vett1: .word 2,5,1,60000,7,30,55,1,66,22
vett2: .byte 80,15,3,100,5,20,7,4,10,121
testo_out: .asciiz "IL NUMERO DI RISULTATI è: "