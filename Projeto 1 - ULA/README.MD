# PROJETO 1 - UNIDADE LÓGICA E ARITMÉTICA DE 32 BITS DO MIPS
### COMP0415 - ARQUITETURA DE COMPUTADORES - T03

## Introdução

Esse projeto tem como propósito descrever em Verilog HDL a Unidade Lógica e Aritmética (ULA) do processador MIPS segundo Henessy e Patterson.

A ULA possui as operações de
- Soma e subtração
- AND, OR bitwise
- Set on less than (slt)
- NOR lógico

O somador/subtrator foi implementado em verilog estrutural, a partir de somadores completos de 1 bit, enquanto as outras operações foram implementadas em modelagem comportamental.

O projeto também implementa as flags de *overflow*, *carry-out* e *zero*.

## Funcionamento

Para verificar o funcionamento e os sinais da ULA e seus módulos utilizando o GTKWave, basta executar *makefile* utilizando
```sh
make
```

### Compilar e executar

Para compilar e executar apenas o testbench, basta utilizar

```sh
make comprun
```

### Visualizar arquivo compilado

Para ver o arquivo compilado no GTKWave, utilize

```sh
make run
```

### Excluir arquivos da compilação

Para limpar os arquivos da compilação:

```sh
make clean
```


## Testbench

O *testbench* é composto por uma suíte de 21 testes, sendo esses:
- 2 testes aleatórios para o AND;
- 2 testes aleatórios para o OR;
- 1 teste aleatório para a soma;
- 2 testes para o carry-out dos somadores de 8 bits que compõem o somador de 32 bits;
- 2 testes para adição com 0 em ambas as entradas;
- 3 testes para subtração com 0 [(0 - valor), (valor - 0) e (0-0)];
- 2 testes aleatórios para o slt
- 1 teste de valores negativos para o slt
- 1 teste aleatório para o NOR
- 2 testes de **overflow** (para soma e para a subtração)
- 2 testes para a flag zero com soma e subtração
- 1 teste para a flag zero com o slt

O funcionamento da ULA está documentado junto à sua descrição, no arquivo *alu_32.v*.
