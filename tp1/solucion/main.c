#include <stdio.h>
#include "trie.h"

int main(void) {
	// COMPLETAR AQUI EL CODIGO
trie *t = trie_crear();
trie_agregar_palabra(t,"gato");
trie_agregar_palabra(t,"auto");
trie_agregar_palabra(t,"automata");
trie_agregar_palabra(t,"autor");
trie_agregar_palabra(t,"gorrion");

trie_imprimir(t, "./test.txt");

bool b = buscar_palabra(t, "autores");
trie *t2 = trie_construir("./test.txt");
listaP *sth = palabras_con_prefijo(t, "au");
lista_borrar(sth);
double (*funct)(char*);
funct = peso_palabra;
double res = trie_pesar(t, funct);

trie_imprimir(t2, "./test.txt");

printf("el bool dio %i \n", b);
printf("PESO TRIE:  %f \n", res);

predecir_palabras(t, "123");
trie_borrar(t);
trie_borrar(t2);
    return 0;
}
	
