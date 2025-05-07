.globl main 
main:
    lw   $t0, primo_operando     # Carica il primo operando in t0
    lw   $t1, secondo_operando   # Carica il secondo operando in t1
    add  $t0, $t0, $t1           # Accumula in t0 (primo+secondo)
    
    lw   $t1, terzo_operando
    add  $t0, $t0, $t1           # Accumula terzo operando
    
    lw   $t1, quarto_operando
    add  $t0, $t0, $t1           # Accumula quarto operando
    
    lw   $t1, quinto_operando
    add  $t0, $t0, $t1           # Accumula quinto operando

    li   $t2, 5
    div  $t0, $t2
    mflo $t0                     # Media finale in t0

.data
primo_operando:   .word 0
secondo_operando: .word 11
terzo_operando:   .word 7
quarto_operando:  .word 1982
quinto_operando:  .word 10051980
