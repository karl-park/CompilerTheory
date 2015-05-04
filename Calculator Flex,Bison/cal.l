%{
	#include <stdlib.h>
	#include <stdio.h>
	#include "cal.tab.h"
	extern YYSTYPE yylval;
	void yyerror(char*);
	int varindex(char *var);
%}

%%

[ \t] ; // 공백 무시

([0-9]+) { yylval.dval = atoi(yytext); return INT;} // 정수 판별

(([0-9]+(\.[0-9]*)?)|([0-9]*\.[0-9]+)) { yylval.dval = atof(yytext); return FLOAT;}  // 실수 판별

[-+()=/%*\n] { return *yytext; } // 연산자 및 심볼 판별

[a-zA-Z][a-zA-Z0-9_]*  { yylval.ivar = varindex(yytext); return VARIABLE;}  // 변수 판별

. {char msg[11]; sprintf(msg,"%s <%s>","invalid character",yytext); yyerror(msg); }  // 에러 출력
%%

int yywrap(void){
  return 1;
}

void yyerror(char *s){
	fprintf(stderr,"%s\n",s);
	return;
}