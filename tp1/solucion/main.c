#include <stdio.h>
#include "trie.h"

int main(void) {
	// COMPLETAR AQUI EL CODIGO
trie* t = trie_crear();

trie_imprimir(t, "test.txt");

trie_borrar(t);

    return 0;
}

