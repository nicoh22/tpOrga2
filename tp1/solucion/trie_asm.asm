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
false: db FALSE
true: db TRUE
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
	PUSH RBP
	MOV RBP RSP
	PUSH RDI
	PUSH RBX
	PUSH R12
	PUSH R13
	MOV RBX [RDI]
	CMP RBX NULL
	JZ .fin
	
	MOV RDI RBX
	MOV R12 [RDI + offset_sig]
	MOV R13 [RDI + offset_hijos]
	CALL free ; Alineada
	PUSH NULL
	SUB RSP 8
.siguiente:
	CMP R12 NULL
	JZ .borroHijos
	PUSH R12	; Desalineada
	SUB RSP 8 
.borroHijos:	
	CMP R13 NULL
	JZ .rama
	MOV RDI R13
	MOV R12 [RDI + offset_sig]
	MOV R13 [RDI + offset_hijos]
	CALL free
	JMP .siguiente
.rama:
	ADD RSP 8
	POP R12
	CMP R12 NULL
	JZ .fin
	
.fin:
	MOV RDI [RBP - 8]
	CALL free
	POP R13
	POP R12
	POP RBX
	POP RBP
	RET
	
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
	mov [rax + offset_fin] false
	
	
	ADD RSP 8
	POP RBX
	POP RBP
	RET

insertar_nodo_en_nivel:
	; COMPLETAR AQUI EL CODIGO

trie_agregar_palabra:
	; void trie_agregar_palabra(trie *t, char *p)
	;RDI trie RSI char*
	PUSH RBP
	MOV RBP RSP
	PUSH RBX
	MOV RBX [RDI]
	CMP RBX NULL
	je
.null:


.notnull:	
	
	
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
	
;AUX

nodo_borrar:
	PUSH RBP
	MOV RBP RSP
	
	CALL free
	
	POP RBP
	RET

