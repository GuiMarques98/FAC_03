.data
msg_leitura: 	.asciiz "Informe o valor de arcoseno que deseja calcular: "
constante: 	.word 6
fatorial: 	.word 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600
binom: 		.word 1, 2, 6, 20, 70, 252, 924, 3432, 12870, 48620, 184756


.text
main:
[
	la $s1, fatorial
	la $s2, binom


	jal le_double	#Funcao de leitura de um double


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

