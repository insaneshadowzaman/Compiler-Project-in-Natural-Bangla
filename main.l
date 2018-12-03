/* RE and ACTIONS */
%{

#include <stdio.h>
#include "main.tab.h"
#include<stdlib.h>
int varindex(char *var);

int cmnts = 0;
int keywords = 0;
int function_calls = 0;
int ids = 0;
int ops = 0;
int ints = 0;
int floats = 0;
int sp = 0;
int newline = 0;
int punc = 0;

%}

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*[_]?[a-zA-Z0-9]*
DIGIT [0-9]

%%

"#" {
	punc++;
	// printf("sehs\n");
	return shesh;
}

"purno"	     { 
	// printf("Found FullNumber type\n");
	keywords++;
	return INT; 
	}

"die" {
	keywords++;
	return DIE;
}

"vognangsho"	     { 
	keywords++;
	// printf("Found RealNumber type\n");
	return FLOAT; }

"holo" {
	ops++;
	return ASSIGN;
}

"hoe" {
	punc++;
	return BOOL_EXPR_CLOSE;
}

"theke" {
	keywords++;
	return THAN;
}

"nahole_jodi" {
	keywords++;
	return ELSE_IF;
}

"ar" {
	punc++;
	return AR;
}


\( {
	punc++;
	return LP;
}
\) {
	punc++;
	return RP;
}

"shesh" {
	punc++;
	return END_BLOCK;
}

"hole" {
	punc++;
	return HOLE;
}

"tahole" {
	keywords++;
	// printf("Found tahole\n");
	return START_BLOCK;
}

"jodi"      { 
	keywords++;
	// printf("lex : Found if\n"); 
	return JODI; }

"nahole"    {
	keywords++;
	 return NAHOY; }

"ghurlam"  {
	keywords++;
	 return FOR; }

"jog"        { ops++;
return SUM; }

"biog"        { ops++; return SUB; }

"gun"        { ops++; return MUL; }

"vag"        { ops++; return DIV; }

"boro"       { ops++; return ISGREATER; }

"choto"       { ops++; return ISLESS; }

"boro_shoman"     { ops++; return ISGREATEREQU; }
"choto_shoman"      { ops++; return ISLESSEQU; }

"ebong" { ops++; return AND; }
"othoba" { ops++; return OR; }
"na" { ops++; return NOT; }

"er_sine"    { ops++; return SINE; }
"er_cos"    { ops++; return COS; }
"er_tan"    { ops++; return TAN; }
"er_lon"    { ops++; return LN; }
"er_fact" { ops++; return FACTORIAL; }
"er_upore" { ops++; return TOTHEPOWER; }

"dhori"  { keywords++;return Switch; }


"ferot" {
	// printf("ferot\n");
	return BACK;
}


"er_"{IDENTIFIER}+ {
		char * p;
		p=(char *) calloc(strlen(yytext)+1, sizeof(char));
		strcpy(p,yytext);
		yylval.id = p;
		function_calls++;
		return FUNCTION;
}

{IDENTIFIER} {
			char * p;
			p=(char *) calloc(strlen(yytext)+1, sizeof(char));
			strcpy(p,yytext);
			yylval.id = p;
			ids++;
			return Variable;
		}

"-"?{DIGIT}+ {
	yylval.DOB=atof(yytext);
	// printf("Fount number : %lf\n", yylval.DOB);
	ints++;
	return Number;
	}

"-"?{DIGIT}+?"."{DIGIT}+ {
	yylval.DOB=atof(yytext);
	// printf("Fount number : %lf\n", yylval.DOB);
	floats++;
	return Number;
	}

\/\/.* {
	cmnts++;
	//comments
}

[ \t\n]*	{ sp++; }
	
%%


int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
	fclose(yyin);
    printf("\n\nTotal Keywords is : %d\n", keywords);
    printf("Total Function_calls is : %d\n", function_calls);
    printf("Total Identifiers is : %d\n", ids);
    printf("Total Operators is : %d\n", ops);
    printf("Total Integers is : %d\n", ints);
    printf("Total Floats is : %d\n", floats);
    printf("Total Spaces is : %d\n", sp);
    printf("Total Punctuations is : %d\n", punc);
    printf("Total comments is : %d\n", cmnts);
}
