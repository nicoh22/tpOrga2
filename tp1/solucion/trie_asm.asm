global trie_crear
global nodo_crear
global insertar_nodo_en_nivel
global trie_agregar_palabra
global trie_construir
global trie_borrar
global trie_imprimir
global buscar_palabra
global palabras_con_prefijo
global trie_pesar

extern malloc
extern free

; SE RECOMIENDA COMPLETAR LOS DEFINES CON LOS VALORES CORRECTOS
%define offset_sig 0
%define offset_hijos 8
%define offset_c 16
%define offset_fin 17

%define size_nodo 18

%define offset_raiz 0

%define size_trie 8

%define offset_prim 0

%define offset_valor 0
%define offset_sig_lnodo 0

%define NULL 0

%define FALSE 0
%define TRUE 1

section .rodata

section .data

section .text

; FUNCIONES OBLIGATORIAS. PUEDEN CREAR LAS FUNCIONES AUXILIARES QUE CREAN CONVENIENTES

trie_crear:
	; trie *trie_crear(void)
	PUSH RBP
	MOV RBP RSP
	MOV RDI size_trie 
	CALL malloc	
	
	mov [rax + offset_raiz] NULL
	
	POP RBP
	RET
	
trie_borrar:
	; COMPLETAR AQUI EL CODIGO

nodo_crear:
; nodo * nodo_crear (char c)
	PUSH RBP
	MOV RBP RSP
	PUSH RBX
	SUB RSP 8
	MOV RBX RDI 
	
	MOV RDI size_nodo 
	CALL malloc
	
	
	mov [rax + offset_sig] NULL
	mov [rax + offset_hijos] NULL
	mov [rax + offset_c] BL
	mov [rax + offset_fin] FALSE
	
	
	ADD RSP 8
	POP RBX
	POP RBP
	RET

insertar_nodo_en_nivel:
	; COMPLETAR AQUI EL CODIGO

trie_agregar_palabra:
	; COMPLETAR AQUI EL CODIGO

trie_construir:
	; COMPLETAR AQUI EL CODIGO

trie_imprimir:
	; COMPLETAR AQUI EL CODIGO

buscar_palabra:
	; COMPLETAR AQUI EL CODIGO

trie_pesar:
	; COMPLETAR AQUI EL CODIGO

palabras_con_prefijo:
	; COMPLETAR AQUI EL CODIGO

