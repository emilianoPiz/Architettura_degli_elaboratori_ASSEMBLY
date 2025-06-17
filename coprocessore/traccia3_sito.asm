#traccia3
#Scrivere un programma in linguaggio assembaltivo MIPS/MARS che Calcola la distanza tra due punti (x1,y1) (x2,y2).
#NB:i punti x1,y1,x2,y2 sono interi definiti in memoria; 
#la distanza si ottine con la radice quadrata di (x1-x2)^2+(y1-y2)^2

.data
X_UNO: .word 1
Y_UNO: .word 40
X_DUE: .word 1
Y_DUE: .word 20

.text
.macro	END
	li $v0, 10 
	syscall
.end_macro

.globl main
main:
	#DATI
	#leggi i numeri definiti in memoria
	lw $t0, X_UNO		#x nei registri pari, y nei dispari 
	lw $t1, Y_UNO
	lw $t2, X_DUE
	lw $t3, Y_DUE	
	
	#sposta gli int nel corpoc
	mtc1 $t0, $f0 #x1
	mtc1 $t1, $f2 #y1
	mtc1 $t2, $f4 #x2
	mtc1 $t3, $f6 #y2
	
	#converti gli int nel coproc
	cvt.s.w $f0,$f0  #x1
	cvt.s.w $f2,$f2  #y1  
	cvt.s.w $f4,$f4  #x2
	cvt.s.w $f6,$f6	 #y2
	
	#CONTI
	#x1-x2
	sub.s $f20, $f0, $f4
	#y1-y2
	sub.s $f22, $f2, $f6
	#(x1-x2)^2
	mul.s $f20, $f20, $f20
	#(y1-y2)^2
	mul.s $f22, $f22, $f22
	#(x1-x2)^2 + (y1-y2)^2
	add.s $f20, $f20, $f22
	#radice quadrata di (x1-x2)^2 + (y1-y2)^2
	sqrt.s $f20, $f20
	
	#STAMPA
	li $v0, 2
	mov.s $f12, $f20
	syscall
	
	END