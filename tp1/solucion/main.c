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

trie *t2 = trie_construir("./test.txt");

bool b = buscar_palabra(t, "autores");

printf("el bool dio %i \n", b);

trie_borrar(t);
trie_borrar(t2);
    return 0;
}
	
