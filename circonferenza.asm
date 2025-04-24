.text
.globl main

main: 
    l.s  $f1, r   #raggio del cerchio
    l.s  $f2, pi  #valore pi greco con 5 cifre di precisione
    l.s  $f3, k2  #costante 2 per moltiplicazione
    mul.s $f4,$f3,$f1 #raggio per 2
    mul.s $f5,$f2,$f4 #(raggio per due)per pi_greco 
    .end

.macro end
li $v0, 10 
syscall
.end_macro

 .data
 r: .float 7.0
 pi: .float 3.14159
 k2: .float 2.0 