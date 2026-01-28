#include <stdio.h>
#include <stdlib.h>

int array[] = {1,2,8,17,20,40,42,60,75,80,81,82,84,90,125,162,200,4096,8192};
int size = 19;

/* int buscaBinaria(int valorProcurado,int *array, int tamanho){
    int pivo = tamanho/2;
    int inicio = 0, final = tamanho-1;

    while(inicio <= final && array[pivo] != valorProcurado){
        if(array[pivo] > valorProcurado)
            final = pivo -1;
        else if(array[pivo] <= valorProcurado)
            inicio = pivo+1;   
        pivo = (inicio + final)/2;
    }
    if(array[pivo] == valorProcurado)
        return pivo;
    return -1;
} */

int buscaBinariaRec(int valorProcurado,
    int *array, int inicio, int final){
    
    if(inicio<=final){
        int pivo =  (final+inicio)/2;
        if(array[pivo] == valorProcurado)
            return pivo;
        if(array[pivo] > valorProcurado)
            return buscaBinariaRec(valorProcurado,
                array,inicio,pivo-1);
        else
            return buscaBinariaRec(valorProcurado,
                array,pivo+1,final);
    }
    return -1;
    
}



int main(int argc, char** argv){
    int valorProcurado;
    if(argc == 2)
        valorProcurado = (int) strtol(argv[1], (char **)NULL, 10);
    else{
        printf("Insira o valor que deseja procurar:");
        scanf("%d", &valorProcurado);
    }
    //int resultado = buscaBinaria(valorProcurado,array,size);
    int resultado2 = buscaBinariaRec(valorProcurado,array,0,size-1);
    printf("\nO valor esta armazenado na posicao %d", resultado2);
    if(resultado2 == -1)
        printf(" (nao encontrado)");
}