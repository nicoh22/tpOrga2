#include <stdio.h>
#include <stdlib.h>
#include "trie.h"

void test1();
void test2();
void test3();

int main(void) {
	// COMPLETAR AQUI EL CODIGO
	test1();
	test2();
	test3();
    return 0;
}

void test1(){
	trie *t = trie_crear();
	trie_imprimir(t,"./pruebacorta.txt");
	trie_borrar(t);
}

void test2(){
	trie *t = trie_crear();
	trie_agregar_palabra(t,"prueba");
	trie_imprimir(t,"./pruebacorta.txt");
	trie_borrar(t);
}


void test3(){
	trie *t = trie_crear();
	trie_agregar_palabra(t,"casa");
	trie_agregar_palabra(t,"casco");
	trie_agregar_palabra(t,"ala");
	trie_agregar_palabra(t,"cama");
	trie_imprimir(t,"./pruebacorta.txt");
	trie_borrar(t);
}
