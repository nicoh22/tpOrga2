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


; SE RECOMIENDA COMPLETAR LOS DEFINES CON LOS VALORES CORRECTOS
%define offset_sig 8
%define offset_hijos 16
%define offset_c 17
%define offset_fin 18

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
	; COMPLETAR AQUI EL CODIGO

trie_borrar:
	; COMPLETAR AQUI EL CODIGO

nodo_crear:
; nodo * nodo_crear (char c)
	SUB RBP 8
	MOV DL DIL
	MOV RCX NULL
	MOV RDI size_nodo 
	call malloc
	mov [rax] RCX
	mov [rax + offset_sig] RCX
	mov [rax + offset_hijos] DIL
	mov [rax + offset_c] TRUE
	ADD RBP 8
	

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

