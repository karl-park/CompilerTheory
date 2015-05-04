%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	int yylex();
	
	#define NVARS 100
	char *vars[NVARS]; double vals[NVARS]; int isDoubleVals[NVARS]; int nvars=0;

	int isDoubleTerm = 0;
	int isDoubleMuldiv = 0;
	int isDoubleExpr = 0;
%}
%union {
	double dval; int ivar;
	}

%token <dval> FLOAT
%token <dval> INT;
%token <ivar> VARIABLE

%type <dval> expr
%type <dval> muldiv
%type <dval> term

%%
program: line program
	   | line
	   ;

line: expr '\n' { printf("%g\n",$1); isDoubleExpr = 0; } 
	| VARIABLE '=' expr '\n' { vals[$1] = $3; isDoubleVals[$1] = isDoubleExpr; }
	;

expr: expr '+' muldiv { 
					if(isDoubleMuldiv == 1)
						isDoubleExpr = 1;
					if(isDoubleMuldiv == 0){
						int c1 = $1;
						int c2 = $3;
						$$ = c1 + c2;
					}else $$ = $1 + $3;}
	| expr '-' muldiv {
					if(isDoubleMuldiv == 1)
						isDoubleExpr = 1;
					if(isDoubleMuldiv == 0){
						int c1 = $1;
						int c2 = $3;
						$$ = c1 - c2;
					}else $$ = $1 - $3;}
	| muldiv { if(isDoubleMuldiv == 1) isDoubleExpr = 1;$$ = $1; }
	;

muldiv: muldiv '*' term {
					if(isDoubleTerm == 1)
						isDoubleMuldiv = 1;
					if(isDoubleMuldiv == 0){
						int c1 = $1;
						int c2 = $3;
						$$ = c1*c2;
					}else $$ = $1 * $3; }
	| muldiv '/' term {
					if(isDoubleTerm == 1)
						isDoubleMuldiv = 1;
					if(isDoubleMuldiv == 0){
						int c1 = $1;
						int c2 = $3;
						$$ = (c1/c2);
					}else $$ = $1 / $3; }
	| muldiv '%' term {
					if(isDoubleTerm == 1)
						isDoubleMuldiv = 1;
					if(isDoubleMuldiv == 0){
						int c1 = $1;
						int c2 = $3;
						$$ = (c1 % c2);
					}else{printf("float not allowed in this.\n"); return;}}
	| term { if(isDoubleTerm == 1) isDoubleMuldiv = 1; $$ = $1;}
	;

term:'(' expr ')' { $$ = $2; isDoubleTerm = isDoubleExpr;}
	| '-' term { $$ = -$2; }
	| VARIABLE { $$ = vals[$1]; isDoubleTerm = isDoubleVals[$1]; }
	| FLOAT { $$ = $1; isDoubleTerm = 1;}
	| INT {$$ = $1; isDoubleTerm = 0; }
	;

%%


int varindex(char *varname){
	int i;
	for (i=0; i<nvars; i++)
		if (strcmp(varname,vars[i])==0)
			return i;
	vars[nvars] = strdup(varname);
	return nvars++;
}

int main(void){
	printf("---------------------------------------------------\n");
	printf("Program : myCalculator\n");
	printf("Made by ParkPanki, Hadong Global Univ.\n");
	printf("Modified on 2015-04-24\n");
	printf("---------------------------------------------------\n");
	printf("Usage:1.Number Calculating ex)\n3+4\n-98.2+9.4*2\n");
	printf("Usage:2.Variable Calculating ex)\nfirstVar=9.4\nsecondVar=-2.4\nfirstVar+9.4*secondVar\n");
	printf("---------------------------------------------------\n");

	yyparse();
	return 0;
}