.text
.globl main

main: 
    l.s  $f0, r        #raggio del cerchio
    l.s  $f2, pi       #valore pi greco con 5 cifre di precisione
    l.s  $f4, k2       #costante 2 per moltiplicazione
    mul.s $f6,$f4,$f0  #raggio per 2
    mul.s $f8,$f2,$f6  #(raggio per due)per pi_greco 
    .end

.macro end
li $v0, 10 
syscall
.end_macro

 .data
 r: .float 7.0
 pi: .float 3.14159
 k2: .float 2.0 