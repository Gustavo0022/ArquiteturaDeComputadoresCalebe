#Busca binária, aprendida com Bruno Prado. Agora em assembly :P

#lista de registradores
# $t0 = endereço do array
# $t1 = valor a ser procurado
# $t2 = valor inicial (necessário para indicar onde começa a busca na particao da busca)
# $t3 = tamArray - 1
# $t4 = pivo ($t2 + $t3)/2 [(inicio+final)/2] 
# $t5 = valor armazenado no pivo
# $t6 = pivo * 4 (offset)
# $t7 = endereco do pivo +  offset do pivo
# $s0 = valor final

.data
	#array contendo valores a serem buscados (ordenado)
	array: .word 1,2,8,17,20,40,42,60,75,80,81,82,84,90,125,162,200,4096,8192
	tamArray: .word 19
	lineFeed: .asciiz "\n"
	fraseInicial: .asciiz "Insira o valor que deseja procurar: "
	fraseFinal: .asciiz "O valor esta armazenado na posicao "
	fraseNaoEncontrado: .asciiz " (nao encontrado)"
.text

main:
	#carrega o array
	la $t0, array
	
	##carrega e imprime a frase inicial
	la $a0, fraseInicial
	li $v0, 4
	syscall
	
	#le o valor digitado e o coloca em $t1
	li $v0, 5
	syscall
	move $t1, $v0 
	
	#obtem o valor do inicio (inicialmente 0) e aloca em $t2
	move $t2, $zero
	
	# obtem o tamanho do array -1 e o coloca em $t3
	lw $t3, tamArray
	subi $t3, $t3, 1
	
	#define registrador de valor final como -1 (não encontrado)
	li $s0, -1
	#inicia a busca
	jal bSearch
	
	#impressão da frase final e da posicao do numero procurado
	la $a0, lineFeed 	# '\n'
	li $v0, 4 
	syscall
	
	la $a0, fraseFinal 	#imprime a frase final...
	syscall
	
	move $a0, $s0	
	li $v0, 1		#...e a posição do valor desejado
	syscall
	
	beq $s0, -1, naoEncontradoTexto
	
	li $v0, 10 #encerra o programa
	syscall
	
	
#se o valor desejado não estiver no array, imprime o "-1", bem como a mensagem de "não encontrado"
naoEncontradoTexto:
	la $a0, fraseNaoEncontrado
	li $v0, 4
	syscall
	
	li $v0, 10 #encerra o programa
	syscall

		
bSearch:
	bgt $t2, $t3, naoEncontrado #se inicio> final, o valor não foi encontrado(não está na lista)
	
	#definição do pivo
	add $t4, $t2, $t3 	# pivo = inicio+final
	div $t4, $t4, 2 	#pivo = pivo/2
	
	mul $t6, $t4, 4 	#offset do array (cada valor possui 4 bytes) pivoOffset = pivo*4
	add $t7, $t0, $t6	#valor para busca = valor do endereço do array + pivoOffset
            lw $t5, 0($t7) 	#carrega valor na posicao do pivo em $t5
            
            beq $t5, $t1, encontrado #se array[pivo] == valorDesejado, retorna o valor encontrado
            
            #se array[pivo] > valor desejado, faz a busca na a segunda parte do array (de pivo+1 até final)
            bgt $t5, $t1, vetorMaiorQueElemento 
            
            #senão, faz a busca na primeira metade do array (de inicio ate pivo+1)
	addi $t2, $t4, 1
	j bSearch
	
vetorMaiorQueElemento:
	subi $t3, $t4, 1
	j bSearch
	
encontrado:
	move $s0, $t4 	#define o valor final como o valor do pivo
	jr $ra 		#retorna a funcao ($t4 = -1) (não encontrado)
naoEncontrado:
	jr $ra 		#retorna a funcao ($t4 = pivo) 

	
	
	
	
	
	


