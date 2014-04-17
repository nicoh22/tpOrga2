#include "trie.h"
#include "listaP.h"
#include <stdio.h>
// Completar las funciones en C.

listaP *predecir_palabras(trie *t, char *teclas) { //ignorar esto
	listaP *res = crear_lista();
	if (*teclas == 0 | teclas == 0) then return res;
	if (t.raiz == 0) then return res;
	
	int cantidad = 0;
	while(*teclas[cantidad] != 0){
	cantidad++; 
	}
	
	
	char **letras = malloc(8 * cantidad); 	
	int *cantletras = malloc(sizeof(int) * cantidad);
	int j = 0;
	while(j < cantidad){
		switch (teclas[j]) {
			case '1':
			letras[j] = "1";
			cantletras[j] = 1;
			break;
			case '2':
			letras[j] = "2abc";
			cantletras[j] = 4;
			break;
			case '3':
			letras[j] = "3def";
			cantletras[j] = 4;
			break;
			case '4':
			letras[j] = "4ghi";
			cantletras[j] = 4;
			break;
			case '5':
			letras[j] = "5jkl";
			cantletras[j] = 4;
			break;
			case '6':
			letras[j] = "6mno";
			cantletras[j] = 4;
			break;
			case '7':
			letras[j] = "7pqrs";
			cantletras[j] = 5;
			break;
			case '8':
			letras[j] = "8tuv";
			cantletras[j] = 4;
			break;
			case '9':
			letras[j] = "9wxyz";
			cantletras[j] = 5;
			break;
			case '0':
			letras[j] = "0";
			cantletras[j] = 1;
			break;
			default:
			letras[j] = "";
			cantletras[j] = 0;
			break;
		}
		j++;
	}
	
	listaP *tmp;
	
	while(j < cantidad){	
		while(j < cantLetras[j]){
		letras[k][j] 
		
		tmp = palabras_con_prefijo(t, )
		res = concatenar(res, tmp)
		}
	}
	free(letras);
	free(cantletras);
	free(palabra);
	return res;
}

double peso_palabra(char *palabra) {
	int i = 0;	
	int j = 0;
	while(*palabra != 0){
		i = i + *palabra;
		j = j + 1;
	palabra = palabra + 1; 
	}
	double res;
	res = (double)i/(double)j;
	return res;	 
}
