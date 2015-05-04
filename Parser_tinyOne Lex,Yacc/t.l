%{
#include <string.h>
#include "y.tab.h"
//char	*yysvalue;
extern YYSTYPE yylval;
%}

%option noyywrap
LETTER	[a-zA-Z]
DIGIT	[0-9]

%%
\"[^\"\n]*\"		{return STRVAL;}
{DIGIT}+ 		{return INTVAL;}
((\.)|(\.[1-9][0-9]*)|([1-9][0-9]*\.[1-9][0-9]*)|([1-9][0-9]*\.))((e|E)?|((e|E)(\+|\-)([1-9][0-9]*))?) {return DOUBLEVAL;}

program {return PROG;}
begin	{return BEG;}
end	{return END;}

while 	{return WHILE;}
for	{return FOR;}
if	{return IF;}
else	{return ELSE;}

integer {return INT;}
double  {return DOUBLE;}
string  {return STRING;}

{LETTER}({LETTER}|{DIGIT}|"_")*	{return IDENTIFIER;}
","	{ return COMMA; }
"=" 	{ return ASSIGNOP; }
"+" 	{ return ADD; }
"-" 	{ return SUB; }
"*"		{ return MUL; }
"/"		{ return DIV; }
"%"		{ return MOD; }

";"		{ return TERMINATOR; }

\=\=	{ return EQ; }
\!\=	{ return NE; }
\<\=	{ return LE; }
\>\=	{ return GE; }
\<		{ return LT; }
\>		{ return GT; }

"(" 	{ return LPAR; }
")" 	{ return RPAR; }



[ \t\r]+	;
[\n]		{yylineno++;}
\/\/[^\n]*					;	// 주석
\/\*(\/|[^\/\*]|\**[^\/\*]+)*\*+\/		;	// 주석
.	{return ERROR;}
%%