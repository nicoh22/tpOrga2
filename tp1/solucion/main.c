#include <stdio.h>
#include <stdlib.h>
#include "trie.h"

int contar(char *teclas);

int main(void) {
	// COMPLETAR AQUI EL CODIGO
/*
trie *t = trie_crear();
trie_agregar_palabra(t,"gato");
trie_agregar_palabra(t,"auto");
trie_agregar_palabra(t,"automata");
trie_agregar_palabra(t,"autor");
trie_agregar_palabra(t,"gorrion");
trie_agregar_palabra(t,"autora");
trie_agregar_palabra(t,"nigga");
trie_agregar_palabra(t,"fuah");
trie_agregar_palabra(t,"asdjgljsdkg");
trie_agregar_palabra(t,"topcucurrucu");
trie_agregar_palabra(t,"apepepsdf");
trie_agregar_palabra(t,"faspl");
trie_agregar_palabra(t,"zsjgiojds");
trie_agregar_palabra(t,"djgojsgs");
trie_agregar_palabra(t,"mememoforks");
*/
trie *t2 = trie_construir("./test.txt");
trie_imprimir(t2, "./test.txt");
/*

char *larga= (char*)malloc(1080);
int i;
for(i=0;i<1079;i++) {
	larga[i] = 'a';
}
larga[i] = 0;
trie_agregar_palabra(t,larga);

int longit = contar(larga);
printf("larga = %d\n",longit);

listaP *sth = palabras_con_prefijo(t, "au");

double sum = peso_palabra("gato") + peso_palabra("auto") + peso_palabra("automata") + peso_palabra("autor") + peso_palabra("gorrion") +peso_palabra("autora") + peso_palabra(larga) ;
*/
double (*funct)(char*);
funct = peso_palabra;
/*
double res = trie_pesar(t, funct);
double res2 = sum /(double) 7 ;

printf("PESO TRIE:  %f \n", res);
printf("PESO TRIE c:  %f \n", res2);




trie_imprimir(t, "./test.txt");
*/


double res3 = trie_pesar(t2, funct);
printf("PESO TRIE:  %f \n", res3);
listaP *s = predecir_palabras(t2, "92");

//free(larga);
//lista_borrar(sth);
lista_borrar(s);
//trie_borrar(t);
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
