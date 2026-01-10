#Busca binaria, aprendida com Bruno Prado. Agora em assembly :P
#lista de registradores
# $s0 = endereco do array
# $s1 = valor a ser procurado
# $t2 = delimitador inicial (necessario para indicar onde comeca a particao da busca)
# $t3 = delimitador final (necessario para indicar onde termina a particao de busca)
# $t4 = pivo [(inicio+final)/2] 
# $t5 = valor armazenado no pivo
# $t6 = pivo * 4 (offset)
# $t7 = endereco do array + offset do pivo
# $s3 = valor final

.data
	#array contendo valores a serem buscados (ordenado)
	array: .word 1,2,8,17,20,40,42,60,75,80,81,82,84,90,125,162,200,4096,8192
	tamArray: .word 19 # tamanho do array
	lineFeed: .asciiz "\n"
	fraseInicial: .asciiz "Insira o valor que deseja procurar: "
	fraseFinal: .asciiz "O valor esta armazenado na posicao "
	fraseNaoEncontrado: .asciiz " (nao encontrado)"
.text

main:
	#carrega o array
	la $s0, array
	
	#carrega e imprime a frase inicial
	la $a0, fraseInicial 
	li $v0, 4 		#codigo de syscall para imprimir string
	syscall
	
	#le o valor digitado e o coloca em $s1
	li $v0, 5 		#codigo de syscall para armazenar inteiro
	syscall
	move $s1, $v0 	#move o valor digitado para o registrador correspondente
	
	#obtem o valor do inicio (inicialmente 0) e aloca em $t2
	move $t2, $zero
	
	# obtem o tamanho do array -1 e o coloca em $t3
	lw $t3, tamArray
	subi $t3, $t3, 1 
	
	
	li $s3, -1		#define registrador de valor final como -1 (nao encontrado)
	#inicia a busca
	jal bSearch
	
	#impressao da frase final e da posicao do numero procurado
	la $a0, lineFeed 	# '\n'
	li $v0, 4 	
	syscall
	
	la $a0, fraseFinal 	#imprime a frase final...
	syscall
	
	move $a0, $s3		
	li $v0, 1		#...e a posicao do valor desejado
	syscall
	
	beq $s3, -1, naoEncontradoTexto #caso o valor de $s3 seja -1, desvia para a funcao de "nao encontrado"
	
	li $v0, 10		#codigo de syscall para encerrar o programa
	syscall
		
bSearch:
	addi $sp,$sp, -4	#aloca espaco na stack para armazenar o return address (em $ra)
	sw $ra, 0($sp)	#armazena o valor de $ra na stack
	
	#caso base: valor nao encontrado. Como determinar:
	bgt, $t2,$t3, finalizar # se del. inicial > del. final, busca finalizada
	
	add $t4, $t2, $t3 	# pivo = inicio+final
	srl $t4, $t4, 1 	# pivo = pivo/2
	
	sll $t6, $t4, 2	#offset pivo (pivo*4)
	add $t7,$s0,$t6	#array+offset pivo
	lw $t5, 0($t7)	#carrega valor do pivo no registrador
	
	beq $t5, $s1, encontrado #se o valor do pivo for o valor desejado, desvia para finalizar funcao

	bgt $t5, $s1, pivoMaiorQueValor # se o valor do pivo for maior que o valor desejado, desvia para determinar novos delimitadores
	
	blt $t5, $s1, pivoMenorQueValor # se o valor do pivo for menor que o valor desejado, desvia para determinar novos delimitadores

pivoMenorQueValor:
	addi $t2, $t4, 1
	jal bSearch 		#faz mais um passo recursivo em bSearch
	j finalizar 		#retorno recursivo de bSearch
pivoMaiorQueValor:
	subi $t3, $t4, 1 	#insere pivo-1 como delimitador final
	jal bSearch 		#faz mais um passo recursivo em bSearch
	j finalizar 		#retorno recursivo de bSearch
	
encontrado:
	move $s3, $t4 	#define o valor final como o valor do pivo
	j finalizar		#finaliza a busca com o valor encontrado
finalizar:
	lw $ra, 0($sp)	#carrega o endereco de retorno da stack no $ra
	addi $sp, $sp, 4	#"desaloca" espaco na stack
	jr $ra		#retorna para o valor em "$ra"
	
#se o valor desejado nao estiver no array, imprime o "-1", bem como a mensagem de "nao encontrado"
naoEncontradoTexto:
	la $a0, fraseNaoEncontrado #carrega o valor da string "(nao encontrado)" em $a0
	li $v0, 4		  #define codigo para imprimir string
	syscall
	
	li $v0, 10 #codigo de syscall para encerrar o programa
	syscall


	
	
	
	
	
	


