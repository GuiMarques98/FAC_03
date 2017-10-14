.data

message:		.asciiz "O valor calculador com os primeiros 5 temos da série é:"
msg_leitura: 	.asciiz "Informe o valor de arcoseno que deseja calcular: "
fatorial: 	.word 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600
binom: 		.word 1, 2, 6, 20, 70, 252, 924, 3432, 12870, 48620, 184756

.text
main:

	# ---REGISTRADORES---
	# $f6 e $f4 -auxiliar flutuante
	# $f8 - número da leitura 
	# $f12  - resposta
	
	# $s0 - contador do for 
	# $s3  - exponenciacao de 4 
	# $s4  - auxiliar inteiro
	# $s5 e $s6 - vão apontar para a os binmomioes e fatorial na memória respectivamente
	
	# --- OBESERVAÇÃO ---
	# * Como o número de termos da série é constante, preferimos deixar na memória para evitar alguns cáculos
	#   Para escrever esses termos é simples, o binomio obedece a relação b(n,k) = b(n,k-1) + b(n-1,k-1) e assim
	#   podemos usar um algoritmo de programação dinâmica para cria-los, como o foco do trabalho é ponto flutuante
	#   preprocessamos esses termos e deixamos na memória.
	
	
	la $s5, fatorial # load fatorial
	la $s6, binom #load binom
	
	# exponenciacao com 4
	add $s3, $zero, 4
	
	jal le_double	#Funcao de leitura de um double
	
	xor $s0, $s0, $s0 #zerando contador inteiro
	
 	mtc1 $zero ,$f12 # zerando $f12 que será nosso resultado 
 	cvt.d.w $f12, $f12 # convertendo (não é necessário mas esse passo está aqui somente pra garantir)
	
	for: 			
	
		#pega a exponenciacao de 4^n e converte para double  
		mtc1 $s3, $f6
		cvt.d.w $f6, $f6 
		
		sll $s3, $s3, 2 # já realiza a exponenciação para próxima interação  	 
		
		#(2n+1)
		sll $s4, $s0, 1 # 2n
		addi $s4, $s4, 1 #(2n+1)

		mtc1 $s4, $f4 
		cvt.d.w $f4, $f4
		
		mul.d $f6, $f6, $f4 # termo (2n+1)*4^n 
		div.d $f6, $f8, $f6 # realiza a divisão
		
		lwc1 $f4, 0($s6) # carrega o binomio
		cvt.d.w $f4, $f4
		
		mul.d $f6, $f6, $f4 #multiplica novamente
		
		add.d $f12, $f12, $f6
		
  		la $s6, 4($s6)# proximo binom
  		
  		add $s0, $s0, 1 
  		
	bne $s0, 4, for
	
	la $a0, message
	li $v0, 4
	syscall 

	li $v0, 3
	syscall 

	li $v0, 10	#Carrega o valor de encerramento do programa
	syscall		#Encerra o programa

le_double:

	la $a0, msg_leitura	#Carrega endereco da string
	li $v0, 4	#Carrega o valor referente ao print da string
	syscall		#Chamada de sistema
	
	li $v0, 7	#Carrega o valor referente a leitura de um double
	syscall		#Chamada de sistema

	mov.d $f8, $f0 # salvando no lugar certo 
	
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
