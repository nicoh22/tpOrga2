#include <stdio.h>
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



listaP *sth = palabras_con_prefijo(t, "au");



double (*funct)(char*);
funct = peso_palabra;

double res = trie_pesar(t, funct);


printf("PESO TRIE:  %f \n", res);


listaP *s = predecir_palabras(t, "28");

lista_borrar(sth);
lista_borrar(s);
trie_borrar(t);
    return 0;
}

int contar(char *teclas){
	int cantidad = 0;
	while((teclas[cantidad]) != 0){
	cantidad++; 
	}
	return cantidad;
}
