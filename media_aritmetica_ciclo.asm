.globl main 
main:
    la   $t0, primo_operando  # indirizzo del primo numero
    li   $t1, 5               # numero elementi
    li   $t2, 0               # accumulatore somma
    li   $t3, 0               # contatore ciclo

loop:
    lw   $t4, 0($t0)          # carica il numero corrente
    add  $t2, $t2, $t4        # aggiorna somma totale
    addi $t0, $t0, 4          # punta al prossimo elemento
    addi $t3, $t3, 1          # incrementa contatore
    blt  $t3, $t1, loop       

    div  $t2, $t1             # calcola media (somma/5)
    mflo $t0                  # media finale in $t0

.data
primo_operando:   .word 0
secondo_operando: .word 11
terzo_operando:   .word 7
quarto_operando:  .word 1982
quinto_operando:  .word 10051980
