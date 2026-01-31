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

.text 

main:
	#carrega o array
	#li $t0, 0  #valor previamente carregado nos registradores
	
	#le o valor digitado e o coloca em $t1
	addi $t1, $zero, 75
	add $a0, $t1, $zero
	addi $v0,$zero, 1 
	
	#obtem o valor do inicio (inicialmente 0) e aloca em $t2
	add $t2, $zero, $zero
	
	# obtem o tamanho do array -1 e o coloca em $t3
	lw $t3, 76($0)
	addi $t3, $t3, -1
	
	#define registrador de valor final como -1 (não encontrado)
	addi $s0,$zero, -1
	#inicia a busca	
#se o valor desejado não estiver no array, imprime o "-1", bem como a mensagem de "não encontrado"


bSearch:
	
	bgt $t2, $t3, naoEncontrado #se inicio> final, o valor não foi encontrado(não está na lista)
	
	#definição do pivo
	add $t4, $t2, $t3 	# pivo = inicio+final
	srl $t4, $t4, 1 	#pivo = pivo/2
	
	sll $t6, $t4, 2 	#offset do array (cada valor possui 4 bytes) pivoOffset = pivo*4
	add $t7, $t0, $t6	#valor para busca = valor do endereço do array + pivoOffset
    lw $t5, 0($t7) 	#carrega valor na posicao do pivo em $t5
	beq $t5, $t1, encontrado #se array[pivo] == valorDesejado, retorna o valor encontrado
            
	# se array[pivo] > valor desejado, faz a busca na a segunda parte do array (de pivo+1 até final)
    	
    bgt $t5, $t1, vetorMaiorQueElemento
            
    # senão, faz a busca na primeira metade do array (de inicio ate pivo+1)
	addi $t2, $t4, 1
	j bSearch
	
vetorMaiorQueElemento:
	addi $t3, $t4, -1
	j bSearch
	
naoEncontrado:
	addi $a0, $zero, -1 	#define o valor final como o valor do pivo
	addi $v0,$zero, 1		#...e a posição do valor desejado
	sw $s0, 100($zero)
	
	addi $v0,$zero, 10 #encerra o programa

encontrado:
	add $s0, $t4, $zero 	#define o valor final como o valor do pivo
	add $a0, $s0, $zero
	addi $v0,$zero, 1		#...e a posição do valor desejado
	sw $s0, 80($zero)
	
	addi $v0,$zero, 10 #encerra o programa
	

	
	
	
	
	
	


