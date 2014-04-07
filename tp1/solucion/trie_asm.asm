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
;hola
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
	MOV RDI R12
	MOV R12 [RDI + offset_sig]
	MOV R13 [RDI + offset_hijos]
	CALL free
	JMP .siguiente
.fin:
	MOV RDI [RBP - 8]
	CALL free
	
	POP R13
	POP R12
	POP RBX
	POP RDI
	POP RBP
	RET
	
nodo_crear:
; nodo * nodo_crear (char c)

	PUSH RBP
	MOV RBP RSP
	PUSH RBX
	SUB RSP 8
	MOV BL DIL 
	
	CMP BL 122	
	JG .conv97

	CMP BL 97
	JGE .fin
	
	CMP BL 90
	JG .conv97
	
	CMP BL 65
	JGE .minuscula
	
	CMP BL 57
	JG .conv97
	
	CMP BL 48
	JGE .fin
	
.conv97: 	
	MOV BL 97
	JMP .fin
	
.minuscula:
	ADD BL 32
.fin:
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
	; nodo *insertar_nodo_en_nivel (nodo **nivel, char c)
	;RDI **nivel RSI char
	PUSH RBP
	MOV RBP RSP	
	PUSH RBX
	PUSH R12
	
	MOV RBX RSI
	MOV R12 RDI	
.ciclo:	
	CMP [R12] NULL
	JZ .crear
	
.crear:
	
	MOV RDI size_nodo
	CALL malloc
	mov [rax + offset_sig] 
	mov [rax + offset_hijos] 
	mov [rax + offset_c] BL
	mov [rax + offset_fin] false
	
.fin:	
	POP R12
	POP RBX
	POP RBP
	RET
	
trie_agregar_palabra:
	; void trie_agregar_palabra(trie *t, char *p)
	;RDI trie RSI char*
	PUSH RBP
	MOV RBP RSP
	PUSH RBX
	PUSH R12
	
	MOV RBX [RDI]
	MOV R12 RSI
	CMP RBX NULL	
	JZ ?
.ciclo:
	MOV DIL [R12]
	CMP DIL NULL
	JZ .fin
	
	
.fin:	
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



