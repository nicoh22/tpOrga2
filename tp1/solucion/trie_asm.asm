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
extern fprintf
extern fopen
extern fclose
extern fscanf

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


%define buffer 1024
%define endFile -1;
section .rodata

section .data
rformat db "r"
append db "a"
sformat db "%s"
vactrie db "<vacio> ", 0
endLine db 10, 0
section .text

; FUNCIONES OBLIGATORIAS. PUEDEN CREAR LAS FUNCIONES AUXILIARES QUE CREAN CONVENIENTES
trie_crear:
	; trie *trie_crear(void)
	PUSH RBP;
	MOV RBP, RSP;
	XOR RDI, RDI
	MOV EDI, size_trie; 
	CALL malloc;	
	mov qword [rax + offset_raiz], NULL;
	POP RBP;
	RET;
trie_borrar:
	; COMPLETAR AQUI EL CODIGO
	PUSH RBP;
	MOV RBP, RSP;
	PUSH RDI;
	PUSH RBX;
	PUSH R12;
	PUSH R13;
	MOV RBX, [RDI];
	CMP RBX, NULL;
	JZ .fin;
	MOV RDI, RBX;
	MOV R12, [RDI + offset_sig];
	MOV R13, [RDI + offset_hijos];
	CALL free ; Alineada
	PUSH NULL;
	SUB RSP, 8;
.siguiente:
	CMP R12, NULL;
	JZ .borroHijos;
	PUSH R12; Desalineada
	SUB RSP, 8; 
.borroHijos:	
	CMP R13, NULL;
	JZ .rama;
	MOV RDI, R13;
	MOV R12, [RDI + offset_sig];
	MOV R13, [RDI + offset_hijos];
	CALL free;
	JMP .siguiente;
.rama:
	ADD RSP, 8;
	POP R12;
	CMP R12, NULL;
	JZ .fin;
	MOV RDI, R12;
	MOV R12, [RDI + offset_sig];
	MOV R13, [RDI + offset_hijos];
	CALL free;
	JMP .siguiente;
.fin:
	MOV RDI, [RBP - 8];
	CALL free;
	POP R13;
	POP R12;
	POP RBX;
	POP RDI;
	POP RBP;
	RET;
nodo_crear:
; nodo * nodo_crear (char c)
	PUSH RBP;
	MOV RBP, RSP;
	PUSH RBX;
	SUB RSP, 8; ok
	 	
	CALL convChar;
	MOV BL, AL;
	
	MOV RDI, size_nodo; 
	CALL malloc;	
	mov qword [rax + offset_sig], NULL;
	mov qword [rax + offset_hijos], NULL;
	mov [rax + offset_c], BL;
	mov byte [rax + offset_fin], FALSE;
	ADD RSP, 8;
	POP RBX;
	POP RBP;
	RET;

insertar_nodo_en_nivel:
	; nodo *insertar_nodo_en_nivel (nodo **nivel, char c)
	;RDI **nivel RSI char
	PUSH RBP;
	MOV RBP, RSP;
	SUB RSP, 8;	
	PUSH RBX ;char
	PUSH R12 ;actual
	PUSH R13 ;anterior Alineada
	MOV [RBP - 8], RDI;	
	MOV RDI, RSI;
	CALL convChar;
	MOV RBX, RAX;
	; BL char R12 *nodo
	MOV R13, [RBP - 8];
	MOV R12, [R13];
	CMP R12, NULL;
	JZ .crearEspecial;
.ciclo:	
	CMP R12, NULL;
	JZ .crear;
	MOV DL, [R12 + offset_c];
	CMP DL, BL;
	JZ .hit;
	JG .crear;
	MOV R13, R12;
	MOV R12, [R12 + offset_sig];
	JMP .ciclo;

.crear:
	MOV RDI, RBX;
	CALL nodo_crear;	
	MOV [R13 + offset_sig], RAX;
	MOV [RAX + offset_sig], R12;
	JMP .fin;
.hit:
	MOV RAX, R12;
	JMP .fin;
		 	 
.crearEspecial:
	MOV RDI, RBX;
	CALL nodo_crear;
	MOV [R13], RAX;
.fin:
	POP R13;	
	POP R12;
	POP RBX;
	ADD RSP, 8;
	POP RBP;
	RET;
	
trie_agregar_palabra:
	; void trie_agregar_palabra(trie *t, char *p)
	;RDI trie RSI char*
	;insertar nodo nivel esta bien
	PUSH RBP;
	MOV RBP, RSP;
	PUSH RBX;
	PUSH R12; Alineada
	
	MOV RBX, RDI;
	MOV R12, RSI;
	
.ciclo:
	MOV SIL, [R12] ; char
	CMP SIL, NULL;
	JZ .fin;
	MOV RDI, RBX; **Nodo
	CALL insertar_nodo_en_nivel ; RDI **nodo RSI char =RAX *nodo
	ADD RAX, offset_hijos;
	MOV RBX, RAX;
	ADD R12, 1;
	JMP .ciclo;
	
.fin:
	SUB RBX, offset_hijos;
	MOV byte [RBX + offset_fin], TRUE;
	POP R12;
	POP RBX;
	POP RBP;
	RET;

trie_construir:
	; trie *trie_construir(char *nombre_archivo)
	;RDI *char

	PUSH RBP;
	MOV RBP, RSP;
	PUSH RBX;
	PUSH R12;
	PUSH R13;
	PUSH R14;
	MOV RBX, RDI;
	
	MOV qword RDI, buffer;
	CALL malloc;
	MOV R12, RAX;
	
	XOR RSI, RSI;
	MOV RDI, RBX;
	MOV RSI, rformat;
	CALL fopen;
	MOV R13, RAX;
	;RBX *archivo| R12 *buffer| R13 *stream| R14 trie
	
	CALL trie_crear;
	MOV R14, RAX;
.ciclo:
	XOR RSI, RSI;
	MOV RDI, R13;
	MOV RSI, sformat;
	MOV RDX, R12;
	CALL fscanf;
	CMP EAX, endFile;
	JZ .fin;
	
	MOV RDI, R14;
	MOV RSI, R12;
	CALL trie_agregar_palabra;
	JMP .ciclo;
.fin:	
	MOV RDI, R12; chau buffer
	CALL free;
	
	MOV RDI, R13;
	CALL fclose;
	 
	POP R14;
	POP R13;
	POP R12;
	POP RBX;
	POP RBP;
	RET;
	
trie_imprimir:
	; void trie_imprimir(trie *t, char *nombre_archivo)

	PUSH RBP;
	MOV RBP, RSP;
	SUB RSP, 8;
	PUSH RBX;
	PUSH R12;
	PUSH R13;
	PUSH R14;
	PUSH R15; A
	
	MOV RBX, RDI; *trie
	MOV R12, RSI; *nombre
	XOR RSI, RSI; 0
	MOV RDI, R12; *nombre
	LEA RSI, [append]; formato 
	CALL fopen;
	MOV R13, RAX ; R13 stream RBX trie R12 nombre 
	
	MOV R12, [RBX];
	CMP R12, NULL;
	JZ .vacio;
	
	MOV qword RDI, buffer;
	CALL malloc;
	MOV R14, RAX;
	MOV [RBP-8], RAX;
	
	PUSH NULL;
	SUB RSP, 8;
	XOR RBX, RBX
	
.sigPalabra:
	MOV R15, [R12 + offset_sig];
	CMP R15, NULL;
	JZ .noPush;
	PUSH R15;
	PUSH RBX
	
.noPush: 
; R14 bufferAct R13 stream R12 actNodo RBX contador CL char? R15 sig 
	
	MOV CL, [R12 + offset_c];
	MOV [R14], CL; copia char en buffer
	MOV AL, [R12 + offset_fin]; 
	CMP AL, TRUE;
	JZ .imprimir;
	ADD R14, 1;	
	
	MOV R12, [R12 + offset_hijos];	
	JMP .sigPalabra;
	
.imprimir:
	MOV byte [R14 +1], 32;
	MOV byte [R14 + 2], 0;  
	XOR RSI, RSI;
	MOV RDI, R13;
	MOV RSI, sformat;
	MOV RDX, [RBP - 8];
	CALL fprintf;
	
	CMP [R12 + offset_hijos], NULL
	JZ .rama
	ADD RBX, 1;
	ADD R14, 1;	
	MOV R12, [R12 + offset_hijos];	
	JMP .sigPalabra;	

.rama:
	POP RDX;
	POP R15;
	CMP R15, NULL;
	JZ .liberaBuffer;
	MOV RBX, RDX; 
	MOV R14, [RBP - 8];
	ADD R14, RBX;
	MOV R12, R15;
	JMP .sigPalabra;

.liberaBuffer:
	MOV RDI, [RBP - 8];
	CALL free;		
	JMP .fin;	

.vacio:

 	XOR RAX, RAX;
	MOV AL, 1;
	XOR RSI, RSI;
	XOR RDX, RDX;
	MOV RDI, R13;
	MOV RSI, sformat;
	LEA RDX, [vactrie];
	CALL fprintf;

.fin:
	XOR RSI, RSI;
	XOR RDX, RDX;
	MOV RDI, R13;
	LEA RSI, [sformat];
	LEA RDX, [endLine];
	CALL fprintf;
	
	MOV RDI, R13;
	CALL fclose;

	POP R15;	
	POP R14;
	POP R13;
	POP R12;
	POP RBX;
	ADD RSP, 8;
	POP RBP;
	RET;
		
buscar_palabra:
	; COMPLETAR AQUI EL CODIGO

trie_pesar:
	; COMPLETAR AQUI EL CODIGO

palabras_con_prefijo:
	; COMPLETAR AQUI EL CODIGO
	
;AUX

convChar:
	PUSH RBP;
	MOV RBP, RSP;
	MOV RAX, RDI; 
	
	CMP AL, 122;	
	JG .conv97;

	CMP AL, 97;
	JGE .fin;
	
	CMP AL, 90;
	JG .conv97;
	
	CMP AL, 65;
	JGE .minuscula;
	
	CMP AL, 57;
	JG .conv97;
	
	CMP AL, 48;
	JGE .fin
	
.conv97: 	
	MOV AL, 97;
	JMP .fin;
.minuscula:
	ADD AL, 32;	
.fin: 
	POP RBP;
	RET;

