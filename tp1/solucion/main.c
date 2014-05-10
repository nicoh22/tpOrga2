#include <stdio.h>
#include <stdlib.h>
#include "trie.h"

int contar(char *teclas);

int main(void) {
	// COMPLETAR AQUI EL CODIGO
trie *t = trie_crear();
trie_agregar_palabra(t,"gato");
trie_agregar_palabra(t,"auto");
trie_agregar_palabra(t,"automata");
trie_agregar_palabra(t,"autor");
trie_agregar_palabra(t,"gorrion");
trie_agregar_palabra(t,"autora");

char *larga= (char*)malloc(1024);
int i;
for(i=0;i<1023;i++) {
	larga[i] = 'a';
}
larga[i] = 0;
trie_agregar_palabra(t,larga);


listaP *sth = palabras_con_prefijo(t, "au");

double sum = peso_palabra("gato") + peso_palabra("auto") + peso_palabra("automata") + peso_palabra("autor") + peso_palabra("gorrion") +peso_palabra("autora") + peso_palabra(larga) ;

double (*funct)(char*);
funct = peso_palabra;

double res = trie_pesar(t, funct);
double res2 = sum /(double) 7 ;

printf("PESO TRIE:  %f \n", res);
printf("PESO TRIE c:  %f \n", res2);

listaP *s = predecir_palabras(t, "28");

trie_imprimir(t, "./test.txt");
trie *t2 = trie_construir("./test.txt");
trie_imprimir(t2, "./test.txt");



free(larga);
lista_borrar(sth);
lista_borrar(s);
trie_borrar(t);
trie_borrar(t2);
    return 0;
}

int contar(char *teclas){
	int cantidad = 0;
	while((teclas[cantidad]) != 0){
	cantidad++; 
	}
	return cantidad;
}
