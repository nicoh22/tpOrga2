#include "trie.h"
#include "listaP.h"
#include <stdlib.h>
// Completar las funciones en C.

listaP *predecir_palabras(trie *t, char *teclas) { //ignorar esto
	listaP *res = lista_crear();
	if ((*teclas == 0) | (teclas == NULL)) return res;
	if (((*t).raiz )== NULL) return res;
	int cantidad = 0;
	while((teclas[cantidad]) != 0){
	cantidad++; 
	}
	
	
	char **letras = (char**)malloc(8 * cantidad); 	
	int *cantletras = (int*)malloc(sizeof(int) * cantidad);
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
	char *palabra = (char*)malloc(cantidad+1);
	palabra[cantidad] = 0;

	int k = 0;
	int h = 0;
	int *cont = malloc(sizeof(int) * cantidad);
	
	while (h<cantidad){
	cont[h] = 0;
	h++;
	}	
	h--; //h es cant - 1
	
	
while(cont[0]<cantletras[0]){
		
		while(k < cantidad){		
			palabra[k] = letras[k][cont[k]];
			k++;
		}
		cont[h]++;
		k = 0;	
		
	while(h>0){	
		if (cont[h]==cantletras[h]){
		cont[h] = 0;
		cont[h - 1]++;
		}
		h--;	
		}
		h = cantidad - 1;
	lista_concatenar(res, palabras_con_prefijo(t, palabra));	

}	



	free(cont);
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


