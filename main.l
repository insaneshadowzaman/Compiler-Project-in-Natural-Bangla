/* RE and ACTIONS */
%{

#include <stdio.h>
#include "main.tab.h"
#include<stdlib.h>
int varindex(char *var);

%}

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*[_]?[a-zA-Z0-9]*
DIGIT [0-9]

%%

"#" {
	return shesh;
}

"purno"	     { 
	// printf("Found FullNumber type\n");
	return INT; 
	}

"die" {
	return DIE;
}

"vognangsho"	     { 
	// printf("Found RealNumber type\n");
	return FLOAT; }

"holo" {
	return ASSIGN;
}

"hoe" {
	return BOOL_EXPR_CLOSE;
}

"theke" {
	return THAN;
}

"nahole_jodi" {
	return ELSE_IF;
}

"ar" {
	return AR;
}


\( {
	return LP;
}
\) {
	return RP;
}

"shesh" {
	return END_BLOCK;
}

"hole" {
	return HOLE;
}

"tahole" {
	return START_BLOCK;
}

"jodi"      { 
	// printf("lex : Found if\n"); 
	return JODI; }

"nahole"    { return NAHOY; }

"ghurlam"  { return FOR; }

"jog"        { return SUM; }

"biog"        { return SUB; }

"gun"        { return MUL; }

"vag"        { return DIV; }

"boro"       { return ISGREATER; }

"choto"       { return ISLESS; }

"boro_shoman"     { return ISGREATEREQU; }
"choto_shoman"      { return ISLESSEQU; }

"ebong" { return AND; }
"othoba" { return OR; }
"na" { return NOT; }

"er_sine"    { return SINE; }
"er_cos"    { return COS; }
"er_tan"    { return TAN; }
"er_lon"    { return LN; }
"er_fact" { return FACTORIAL; }
"er_upore" { return TOTHEPOWER; }

"dhori"  { return Switch; }


"er_"{IDENTIFIER}+ {
	yylval.id = yytext;
	yylval.id[yyleng] = '\0';
	return FUNCTION;
}
[ \t\n]*	{}

{IDENTIFIER} {
			char * p;
			p=(char *) calloc(strlen(yytext)+1, sizeof(char));
			strcpy(p,yytext);
			yylval.id = p;
			// printf("lex : Found Identifier : %s\n", yytext);
			return Variable;
		}

"-"?{DIGIT}+ {
	yylval.DOB=atof(yytext);
	// printf("Fount number : %lf\n", yylval.DOB);
	return Number;
	}

"-"?{DIGIT}+?"."{DIGIT}+ {
	yylval.DOB=atof(yytext);
	// printf("Fount number : %lf\n", yylval.DOB);
	return Number;
	}

\/\/.* {
	//comments
}

	
%%


int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();

}
