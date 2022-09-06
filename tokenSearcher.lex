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

{DIGITO}+    {
            printf( "Um valor inteiro: %s (%d)\n", yytext,
                    atoi( yytext ) );
            }

{DIGITO}+"."{DIGITO}*        {
            printf( "Um valor real: %s (%g)\n", yytext,
                    atof( yytext ) );
            }

{LOWERCASE}+    {
        printf("a lowercase: %s\n", yytext);
}

{UPPERCASE}+     {
        printf("a uppercase: %s\n", yytext);
}

"if"    {printf("condicional if: %s\n", yytext);}

"and"   {printf("uniao and: %s\n", yytext);}

"then"  {printf("Um then: %s\n", yytext);}

"begin" {printf("Um begin: %s\n", yytext);}

"end"   {printf("Um end: %s\n", yytext);}

"procedure"     {printf("Um procedure: %s\n", yytext);}

"function"      {printf( "Um function: %s\n", yytext );}

{ID}        printf( "Um identificador: %s\n", yytext );

"+"|"-"|"*"|"/"   printf( "Um operador: %s\n", yytext );

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
