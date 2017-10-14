.data

msg_leitura: 	.asciiz "Informe o valor de arcoseno que deseja calcular: "
fatorial: 	.word 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600
binom: 		.word 1, 2, 6, 20, 70, 252, 924, 3432, 12870, 48620, 184756

.text
main:

	la $s5, fatorial # load fatorial
	la $s6, binom #load binom
	
	# exponenciacao com 4
	add $s3, $zero, 4
	
	lwc1 $f8, 0($s5)
	cvt.d.w $f8, $f8
	
	jal le_double	#Funcao de leitura de um double

	#apenas com 5 termos da série 
	
	add $s0, $zero, 0 # contador do for 
	
	for: 			
		lwc1 $f8, ($s5) #valor de (2n)!
		cvt.d.w $f8, $f8 #converte pra double
		
		#pega o 4 e converte para double 
		mtc1 $s3, $f10 
		cvt.d.w $f10, $f10
		
		#divide pela exponenciacao de 4^n
		div.d $f8, $f8, $f10 
		
		sll $s3, $s3, 2 #multiplica por 4
		
		
		mtc1 $zero,$f10  #seta 0 no $f10
		cvt.d.w $f10, $f10 #converte 
		
		#(2n+1)
		
		sll $s4, $s3, 1
		addi $s4, $s4, 1 #(2n+1)
		
		mtc1 $s4, $f10 
		cvt.d.w $f10, $f10
		
		div.d $f8, $f8, $f10 #divide 
		
  		la $s5, 4($s5)# proximo fatorial  
  		la $s6, 4($s6)# proximo binom
  		
  		
  		add $s0, $s0, 1 
  		
	bne $s0, 4, for

	li $v0, 10	#Carrega o valor de encerramento do programa
	syscall		#Encerra o programa

le_double:
	la $a0, msg_leitura	#Carrega endereco da string
	li $v0, 4	#Carrega o valor referente ao print da string
	syscall		#Chamada de sistema
	
	li $v0, 7	#Carrega o valor referente a leitura de um double
	syscall		#Chamada de sistema
	
	jr $ra		#Retorno pra o local onde foi chamado

calc_arcsen:
	
imprime_saida:

calc_exp_double:

calc_4_exp:
	li $t0, 2
	sllv $v0, $t0, $a0
	
	sw   $v0, -88($fp)
	lwc1 $f4, -88($fp)
	cvt.s.w $f0, $f4
	
	jr $ra
