/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>
#include <string.h>

struct Mapa{
	char* token;
	Mapa* next;
	Mapa* prev;
} struct Mapa tabelaSimbolos;

void transforma_romano(char *num);
%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

DIGITO    [0-9]
ROMANOS	  [I,V,X,L,C,D,M]
LOWERCASE [a-z]
UPPERCASE [A-Z]
ID        [a-z][a-z0-9]*
SIMBOLO 	["|" | " " | "#" | "$" | "&" | "," | "." | ":" | ";" | "?" | "@" | "\" | "_" | "`" | "~"]

%%

{DIGITO}+    {printf( "Um valor inteiro: %s (%d)\n", yytext, atoi( yytext ) );}

"if"    {printf("condicional if: %s\n", yytext);}
"do"		{printf("faça do while: %s\n", yytext);}
"while" {printf("condicional while: %s\n", yytext);}
"and"   {printf("uniao and: %s\n", yytext);}
"then"  {printf("Um then: %s\n", yytext);}
"begin" {printf("Um begin: %s\n", yytext);}
"end"   {printf("Um end: %s\n", yytext);}
"return" {printf("expressao return: %s\n", yytext);}
"procedure"     {printf("Um procedure: %s\n", yytext);}
"function"      {printf( "Um function: %s\n", yytext );}

"+" {printf("operador de soma: %s\n", yytext);}
"-" {printf("operador de subtracao: %s\n", yytext);}
"*" {printf("operador de multiplicacao: %s\n", yytext);}
"/" {printf("operador de divisao: %s\n", yytext );}
"^"	{printf("elevar um número: %s\n", yytext);}
"=" {printf("recebe valor (=): %s\n", yytext);}
"==" {printf("comparador de igualdade: %s\n", yytext);}
"!"		{printf("negacação: %s\n", yytext);}
"!=" {printf("compador de diferenca: %s\n", yytext);}
"+=" {printf("operador de soma simplificado: %s\n", yytext);}
"-=" {printf("operador de subtracao simplificado: %s\n", yytext);}
"*=" {printf("operador de multiplicacao simplificado: %s\n", yytext);}
"/=" {printf("operador de divisao simplificado: %s\n", yytext);}
">"	{printf("greater then: %s\n", yytext);}
"<"	{printf("less then: %s\n", yytext);}
"%"	{printf("mod|.. %s\n",yytext);}
"&&"	{printf("and: %s\n", yytext);}
"||"	{printf("or: %s\n", yytext);}

"(" {printf("abre-parenteses: %s\n", yytext);}
")" {printf("fecha-parenteses: %s\n", yytext);}
"{" {printf("abre-chaves: %s\n", yytext);}
"}" {printf("fecha-chaves: %s\n", yytext);}
"[" {printf("abre-conchetes: %s\n", yytext);}
"]" {printf("fecha-conchetes: %s\n", yytext);}

{SIMBOLO}	{printf("simbolo: %s\n",yytext);}
{ROMANOS}+	{transforma_romano(yytext);}
{LOWERCASE}+    {printf("lowercase: %s\n", yytext);}
{UPPERCASE}+     {printf("uppercase: %s\n", yytext);}
{DIGITO}+"."{DIGITO}*        {printf( "Um valor real: %s (%g)\n", yytext, atof( yytext ) );}

{ID}        {printf("Um identificador: %s\n", yytext );}
"!"{ID}			{printf("Negação do ID: %s\n", yytext);}

"{"[^}\n]*"}"     /* Lembre-se... comentários não tem utilidade! */

[ \t\n]+          /* Lembre-se... espaços em branco não tem utilidade! */

.           printf( "Caracter não reconhecido: %s\n", yytext );

%%

void transforma_romano(char *num){
	int n = 0;
	char romanos[] = {'I','V','X','L','C','D','M'};
	int Nromanos[] = {1,5,10,50,100,500,1000};

	for(int j = 0; j < strlen(num); j++){
		for(int i = 0; i < 7; i++){
			if(num[j] == romanos[i]){
				n += Nromanos[i];
				break;
			}
		}
	}
	printf("%d\n", n);
}

void start_table(Mapa table){
	table.token = NULL;
	table.next = NULL;
	table.token = NULL;
}

Mapa add_to_start_table(Mapa **table, char* token){
	Mapa *aux, *newTable = malloc(Mapa);
	if(newTable){
		newTable->token = token;
		newTable->prev = NULL;
		if(*table)
			(*table)->prev = newTable;
		*table = newTable;
	}else{
		printf("ERRO AO ALOCAR MEMORIA\n");
	}
}

// will I need to insert in the middle of the table?

Mapa add_to_end_table(Mapa **table, char* token){
	Mapa *aux, *newTable = malloc(Mapa);
	if(newTable){
		newTable->token = token;
		newTable->next = NULL;

		if(*table == NULL){ // is the first?
			*talbe = newTable;
			newTable->prev = NULL;
		}else{
			aux = *table;
			while(aux->next){
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
