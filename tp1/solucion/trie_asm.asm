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
extern lista_crear
extern lista_agregar
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
rformat db "r", 0
append db "a"
sformat db "%s", 0
vactrie db "<vacio> ", 0
section .text
endLine db 10, 0

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
	LEA RSI, [rformat];
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
	CMP byte [R12], 60
	JZ .fin
	
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
	 
	MOV RAX, R14 
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
	ADD RBX, 1;
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
	
	CMP qword [R12 + offset_hijos], NULL
	JZ .rama
	ADD RBX, 1;
	ADD R14, 1;	
	MOV R12, [R12 + offset_hijos];	
	JMP .sigPalabra;	

.rama:
	POP RBX;
	POP R15;
	CMP R15, NULL;
	JZ .liberaBuffer; 
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
	MOV RSI, sformat;
	MOV RDX, endLine;
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
	; bool f(*trie, char +p) RDI trie RSI char
	PUSH RBP
	MOV RBP, RSP
	PUSH RBX
	PUSH R12
	
	MOV RBX, RSI
	MOV R12, [RDI]
	
	CMP R12, NULL
	JZ .false
	
.ciclo:	;r12 nodoact rbx *char act r13
	MOV CL, [RBX];
	CMP CL, [R12 + offset_c]; 
	JZ .hit;
	MOV R12, [R12 + offset_sig];
	CMP R12, NULL
	JZ .false
	JMP .ciclo	
.hit:
	CMP byte [RBX + 1], NULL 
	JZ .fin
	ADD RBX, 1;
	MOV R12, [R12 + offset_hijos]
	CMP R12, NULL
	JZ .false 
	JMP .ciclo

.false:
	XOR RAX, RAX
	MOV AL, FALSE
	JMP .salida	
.fin: ;
	XOR RAX, RAX 
	MOV AL, [R12 + offset_fin]
	
.salida:
	POP R12
	POP RBX
	POP RBP
	RET
	
trie_pesar:
	; double trie_pesar(trie *t, double (*funcion_pesaje)(char*))
	PUSH RBP
	MOV RBP, RSP
	SUB RSP, 24
	PUSH RBX
	PUSH R12
	PUSH R13
	PUSH R14
	PUSH R15
	
	MOV RBX, [RDI]
	;MOV [RBP - 16], RBX 
	MOV [RBP - 24], RSI
	CMP RBX, NULL
	JZ .returncero
	
	
	MOV qword RDI, buffer
	CALL malloc
	MOV R13, RAX
	MOV [RBP-8], RAX
	
	PUSH NULL
	PUSH 0
	MOV R14, RBX
	XOR RBX, RBX
	XOR R12, R12	
	

	MOV qword [RBP - 16], NULL
	
	
.siguiente:
	MOV R15, [R14 + offset_sig]
	CMP R15, NULL
	JZ .ciclo
	PUSH R15
	PUSH RBX	
	
.ciclo:	;[RBP-8] INBUF R13 bufact rbx cont1 r12 cont2 R14nodo
	MOV DL, [R14 + offset_c]
	MOV [R13], DL
	MOV AL, [R14 + offset_fin]; 
	CMP AL, TRUE;
	JZ .pesar
.retoma:ADD R13, 1
	ADD RBX, 1
	MOV R14, [R14 + offset_hijos]
	CMP R14, NULL
	JZ .popear
	JMP .siguiente

.popear:
	POP RAX
	POP R14
	CMP R14, NULL
	JZ .fin
	SUB RBX, RAX
	SUB R13, RBX
	JMP .siguiente
	
.pesar:	
	MOV byte [R13 + 1], 0
	MOV RDI, [RBP - 8]
	CALL [RBP - 24]
	ADD R12, 1
	MOVSD xmm1, [RBP - 16]
;	MOV [RBP - 16], RAX
;	ADDSD XMM1, [RBP - 16]
	ADDSD XMM1, XMM0
	MOVQ [RBP - 16], XMM1
	JMP .retoma

.returncero:

	PXOR XMM0, XMM0
	JMP .salir
.fin:
	MOVDQA XMM1, [RBP-16] 
	
	PXOR XMM2, XMM2
	MOVQ XMM2, R12 
	CVTDQ2PD XMM2, XMM2

	DIVSD XMM1, XMM2
	MOVQ XMM0,XMM1
	
	mov rdi, [rbp - 8]
	CALL free
.salir:	
	POP R15
	POP R14
	POP R13
	POP R12
	POP RBX
	ADD RSP, 24
	POP RBP
	RET
	
palabras_con_prefijo:
	; listaP* (trie* t, char * prefijo) 
	PUSH RBP
	MOV RBP, RSP
	SUB RSP, 16
	PUSH RBX
	PUSH R12
	PUSH R13
	PUSH R14
	
	MOV RBX, RDI
	MOV R12, RSI
	
	CALL lista_crear
	MOV R13, RAX 
	
	CMP R12, NULL
	JZ .vacio
	
	MOV RDI, [RBX]
	MOV RSI, R12
	CALL nodo_prefijo
	
	MOV R14, RAX; R14nodopre R13lista R12*char RBX*trie
	CMP R14, NULL
	JZ .vacio
	MOV [RBP - 16], RBX
	MOV qword RDI, buffer
	CALL malloc
	MOV RBX, RAX
	MOV [RBP - 8], RBX
	
	
	PUSH NULL
	SUB RSP, 8
	;rbx bufferact r12 pref R14 nodo 
	
.cargarPrefijo:
	MOV CL, [R12]
	CMP CL, NULL
	JZ .prefijoPalabra
	MOV [RBX], CL
	ADD RBX, 1
	ADD R12, 1
	JMP .cargarPrefijo
	
.prefijoPalabra:
	MOV RDI, [RBP - 16]
	MOV RSI, R12	
	CALL buscar_palabra
	CMP RAX, TRUE
	JNE .hijos
	MOV RDI, R13
	MOV RSI, R12
	CALL lista_agregar
	
.hijos:	; R14 nodoinicio R12 *c pref() RBX buf R13 lista R8 sig RCX cont
	MOV R14, [R14 + offset_hijos]
	XOR RCX, RCX
	JMP .nopush
.ciclo:
	MOV R8, [R14 + offset_sig]
	CMP R8, NULL
	JZ .nopush
	PUSH R8
	PUSH RCX
.nopush:	
	MOV DL, [R14 + offset_c]
	MOV [RBX], DL
	MOV DL, [R14 + offset_fin]
	CMP DL, TRUE
	JNE .noagregar
	MOV byte [RBX + 1], 0 
	MOV RDI, R13
	MOV RSI, [RBP - 8]
	PUSH rcx
	SUB rsp, 8
	CALL lista_agregar
	ADD rsp, 8
	POP rcx
.noagregar:
	ADD RCX, 1
	ADD RBX, 1
	MOV R14, [R14 + offset_hijos]
	CMP R14, NULL
	JNE .ciclo
	POP RAX
	POP R14
	CMP r14, NULL
	JZ .end
	SUB RCX, RAX
	SUB RBX, RCX
	JMP .ciclo
.end:
	MOV RDI, [RBP - 8]
	CALL free
		
.vacio:	
	MOV RAX, R13
	POP R14
	POP R13
	POP R12
	POP RBX
	ADD RSP, 16
	POP RBP
	RET
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
	
	
nodo_prefijo: ;*nodo RDI *Char RSI
	PUSH RBP
	MOV RBP, RSP
	PUSH RBX
	PUSH R12
	
	MOV RBX, RDI
	MOV R12, RSI
	; RBX nodo act R12 char act
	MOV CL, [R12]

.ciclo:
	CMP [RBX + offset_c], CL
	JZ .hijos
	MOV RBX, [RBX + offset_sig]
	CMP RBX, NULL
	JZ .miss
	JMP .ciclo	
.hijos:
	ADD R12, 1
	MOV CL, [R12]
	CMP CL, NULL
	JZ .fin 	
	MOV RBX, [RBX + offset_hijos]
	CMP RBX, NULL
	JZ .miss
	JMP .ciclo
	
.miss: 
	
	MOV qword RAX, NULL
	JMP .salida
.fin:
	MOV RAX, RBX
	
.salida:
	POP R12
	POP RBX
	POP RBP
	RET
	
