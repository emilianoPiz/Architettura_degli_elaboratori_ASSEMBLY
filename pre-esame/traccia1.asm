
.text
.macro END
li $v0, 10
syscall
.end_macro


.globl main
main:
li $t0, 31     #mask
li $t1, 18     #target
li $t2, 28     #iterazioni mancanti
li $t3, 0      #counter occorrenze

li $v0, 5 
syscall        #immetti intero 
move $s0, $v0  #sposto l'intero in t3


ciclo:
    beqz $t2, stampa
    and  $t4, $s0, $t0   #mask AND input 
    bne  $t4, $t1, shift #se t4 != t1 shifta direttamente
    addi $t5, $t5, 1     #se t4==t1 incrementa e poi shifta

shift:
    srl  $s0, $s0, 1
    subi $t2, $t2, 1
j ciclo 

stampa:
    la $a0, string  #carica il flavour text 
    li $v0, 4
    syscall
    move $a0, $t5
    li $v0, 1
    syscall
    END

.data
string: .asciiz "NUMERO OCCORRENZE: "