/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>
%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

DIGITO    [0-9]
LOWERCASE [a-z]
UPPERCASE [A-Z]
ID        [a-z][a-z0-9]*

%%

{DIGITO}+    {printf( "Um valor inteiro: %s (%d)\n", yytext, atoi( yytext ) );}

"if"    {printf("condicional if: %s\n", yytext);}
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
"=" {printf("recebe valor (=): %s\n", yytext);}
"==" {printf("comparador de igualdade: %s\n", yytext);}
"!=" {printf("compador de diferenca: %s\n", yytext);}
"+=" {printf("operador de soma simplificado: %s\n", yytext);}
"-=" {printf("operador de subtracao simplificado: %s\n", yytext);}
"*=" {printf("operador de multiplicacao simplificado: %s\n", yytext);}
"/=" {printf("operador de divisao simplificado: %s\n", yytext);}

"(" {printf("abre-parenteses: %s", yytext);}
")" {printf("fecha-parenteses: %s", yytext);}
"{" {printf("abre-chaves: %s", yytext);}
"}" {printf("fecha-chaves: %s", yytext);}
"[" {printf("abre-conchetes: %s", yytext);}
"]" {printf("fecha-conchetes: %s", yytext);}

{LOWERCASE}+    {printf("lowercase: %s\n", yytext);}


{UPPERCASE}+     {printf("uppercase: %s\n", yytext);}

{DIGITO}+"."{DIGITO}*        {
            printf( "Um valor real: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

{ID}        {printf( "Um identificador: %s\n", yytext );}

"{"[^}\n]*"}"     /* Lembre-se... comentários não tem utilidade! */

[ \t\n]+          /* Lembre-se... espaços em branco não tem utilidade! */

.           printf( "Caracter não reconhecido: %s\n", yytext );

%%



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
