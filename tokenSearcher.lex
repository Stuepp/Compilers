/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>
#include <string.h>

typedef struct no{
	char* lexema; // token na verdade é lexiograma, lexiogreme algo assim
	char* type;
	// add token
	struct no* next;
	struct no* prev;
}Mapa;

Mapa *listaSimbolos = NULL;

void transforma_romano(char *num);
Mapa add_to_end_table(Mapa **table, char* lexema, char* type)
Mapa add_to_start_table(Mapa **table, char* lexema, char* type);
Mapa *search_table(Mapa **table, char*lexema);
void print_table(Mapa no);

%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/*ROMANOS	  [I,V,X,L,C,D,M]*/
/* ========================================================================== */

DIGITO    [0-9]
LOWERCASE [a-z]
UPPERCASE [A-Z]
ID        [a-z][a-z0-9]*
SIMBOLO 	["|" | " " | "#" | "$" | "&" | "," | "." | ":" | ";" | "?" | "@" | "\" | "_" | "`" | "~"]

%%

{DIGITO}+    {printf( "Um valor inteiro: %s (%d)\n", yytext, atoi(yytext) ); add_to_end_table(listaSimbolos, yytext, "inteiro");}

"if"    {printf("condicional if: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");} /* STATEMENT */
"do"		{printf("faça do while: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"while" {printf("condicional while: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"and"   {printf("uniao and: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"then"  {printf("Um then: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"begin" {printf("Um begin: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"end"   {printf("Um end: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"return" {printf("expressao return: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"procedure"     {printf("Um procedure: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "statement");}
"function"      {printf( "Um function: %s\n", yytext ); add_to_end_table(listaSimbolos, yytext, "statement");}

"+" {printf("operador de soma: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "soma");} /* OPERACOES */
"-" {printf("operador de subtracao: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "soma");}
"+=" {printf("operador de soma simplificado: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "soma");}
"-=" {printf("operador de subtracao simplificado: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "soma");}
"*" {printf("operador de multiplicacao: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "multiplicacao");}
"/" {printf("operador de divisao: %s\n", yytext ); add_to_end_table(listaSimbolos, yytext, "multiplicacao");}
"*=" {printf("operador de multiplicacao simplificado: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "multiplicacao");}
"/=" {printf("operador de divisao simplificado: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "multiplicacao");}
"^"	{printf("elevar um número: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "operador");}
"%"	{printf("mod|.. %s\n",yytext); add_to_end_table(listaSimbolos, yytext, "operador");}
"=" {printf("recebe valor (=): %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "operador");}

"!"		{printf("negacação: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");} /* RELACOES */
"==" {printf("comparador de igualdade: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");}
"!=" {printf("compador de diferenca: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");}
">"	{printf("greater then: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");}
"<"	{printf("less then: %s\n", yytext); add_to_end_table(listaSimbolos, yytex, "relacional"t);}
"&&"	{printf("and: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");}
"||"	{printf("or: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "relacional");}

"(" {printf("abre-parenteses: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");} /* CONTEXTO */
")" {printf("fecha-parenteses: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");}
"{" {printf("abre-chaves: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");}
"}" {printf("fecha-chaves: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");}
"[" {printf("abre-conchetes: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");}
"]" {printf("fecha-conchetes: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "contexto");}

{SIMBOLO}	{printf("simbolo: %s\n",yytext); add_to_end_table(listaSimbolos, yytext, "simbolo");} /*{ROMANOS}+	{transforma_romano(yytext); add_to_end_table(listaSimbolos, yytext);}*/
{LOWERCASE}+    {printf("lowercase: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "caixaBaixa");}
{UPPERCASE}+     {printf("uppercase: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "caixaAlta");}
{DIGITO}+"."{DIGITO}*        {printf( "Um valor real: %s (%g)\n", yytext, atof( yytext ) ); add_to_end_table(listaSimbolos, yytext, "real");}

{ID}        {printf("Um identificador: %s\n", yytext ); add_to_end_table(listaSimbolos, yytext, "ID");}
"!"{ID}			{printf("Negação do ID: %s\n", yytext); add_to_end_table(listaSimbolos, yytext, "IDNEGADO");}

"{"[^}\n]*"}"      /*Lembre-se... comentários não tem utilidade! */

[ \t\n]+           /*Lembre-se... espaços em branco não tem utilidade! */

.           printf( "Caracter não reconhecido: %s\n", yytext );

%%
/*
void transforma_romano(char *num){
	int n = 0;
	char romanos[] = {'I','V','X','L','C','D','M'};
	int Nromanos[] = {1,5,10,50,100,500,1000};

	for(int j = 0; j < strlen(num); j++){
		for(int i = 0; i < 7; i++){
			if(num[j] == romanos[i]){
				n += Nromanos[i];
				break;
			}listaSimbolos
		}
	}
	printf("%d\n", n);
}*/

Mapa *add_to_start_table(Mapa **table, char* lexema, char* type){
	Mapa *aux = malloc(sizeof(Mapa)), *newTable = malloc(sizeof(Mapa));
	if(newTable){
		newTable->lexema = lexema;
		newTable->prev = NULL;
		if(*table)
			(*table)->prev = newTable;
		*table = newTable;
	}else{
		printf("ERRO AO ALOCAR MEMORIA\n");
	}
	return table;
}

// will I need to insert in the middle of the table?

Mapa *add_to_end_table(Mapa **table, char* lexema, char* type){
	Mapa *aux = malloc(sizeof(Mapa)), *newTable = malloc(sizeof(Mapa));
	if(newTable){
		newTable->lexema = lexema;
		newTable->type = type;
		newTable->next = NULL;

		if(*table == NULL){ // is the first?
			*table = newTable;
			newTable->prev = NULL;
		}else{
			aux = *table;
			while(aux->next != NULL){
				aux = aux->next;
			}
			aux->next = newTable;
			newTable->prev = aux;
		}
	}else{
		printf("ERRO AO ALOCAR MEMORIA\n");
	}

	return table;
}

Mapa *search_table(Mapa **table, char*lexema){
	Mapa *aux, *no = NULL;

	aux = *table;
	while(aux && aux->lexema != lexema) // to improve, so it can better use the struct, or maybe it's already fine as it is...
		aux = aux->next;
	if(aux)
		no = aux;
	return no;
}

void print_table(Mapa **no){
	Mapa *aux = malloc(sizeof(Mapa));
	aux = no;
	printf("\n***TABLE***\n");
	while(aux != NULL){
		printf("%s , %s\n", aux->lexema, aux->type);
		aux = aux->next;
	}
	printf("\n");
}

int main( argc, argv )
int argc;

char **argv;
{
	++argv, --argc;
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	yylex();
    
	return 0;
}
