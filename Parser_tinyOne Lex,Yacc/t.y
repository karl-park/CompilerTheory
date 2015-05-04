%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylineno;
extern char* yytext;

%}

%union {
	int intval;
 	double doubleval;
// 	char *strval;
}
 
%token <intval>		INTVAL
%token <doubleval>	DOUBLEVAL
//%token <strval>		IDENTIFIER

// %token INT DOUBLE STRING PROG BEG END WHILE FOR IF ELSE STRVAL TERMINATOR EQ NE LE GE LT GT LPAR RPAR ERROR
%token INT DOUBLE STRING PROG BEG END WHILE FOR IF ELSE STRVAL TERMINATOR ERROR IDENTIFIER COMMA

%type <doubleval> factor

%error-verbose

%right	ASSIGNOP
%left	EQ NE
%left	GE LE GT LT
%left	ADD SUB
%left	MUL DIV MOD
%left	UMINUS UPLUS
%left	'!'
%left	LPAR RPAR


%start program

%%
program :  PROG IDENTIFIER BEG inner_code END {printf("1-good");}
	;
inner_code : variable_declaration_list stmt_list
	;
variable_declaration_list: 
	  variable_declaration_list variable_declaration
	| variable_declaration
	;
variable_declaration:
	| INT declaration_expression TERMINATOR
	| DOUBLE declaration_expression TERMINATOR
	| STRING declaration_expression TERMINATOR
	;
declaration_expression : 
	  variable_name
	| assignment_expression
	| variable_name COMMA declaration_expression
	| assignment_expression COMMA declaration_expression
	;
variable_name: IDENTIFIER
	;
stmt_list :
	  BEG stmt_list END
	| stmt_list stmt
 	| stmt
	;
stmt :
	| expression_statement
	| selection_statement
	| iteration_statement
	;  
selection_statement:
	  IF LPAR expression RPAR stmt
	| IF LPAR expression RPAR stmt ELSE stmt
	;
iteration_statement:
	  WHILE LPAR expression RPAR BEG stmt_list END
	| FOR LPAR expression TERMINATOR expression TERMINATOR expression RPAR BEG stmt_list END
	;
expression_statement :
	expression TERMINATOR
	;

expression:
	  IDENTIFIER LPAR argument_list RPAR
	| LPAR expression RPAR
	| '!' expression 
	| unary_expression 
	| multiplicative_expression
	| additive_expression
	| relational_expression 
	| assignment_expression	
	| INT variable_name
	| DOUBLE variable_name
	| IDENTIFIER
	| STRVAL
	| factor	
	| prepost_expression
	;
prepost_expression:
	  ADD ADD expression
	| SUB SUB expression
	| expression ADD ADD
	| expression SUB SUB
	;
argument_list:
	| argument_list ',' expression
	| expression
	;
unary_expression:
	  ADD expression
	| SUB expression
	;
multiplicative_expression:
	  expression DIV expression
	| expression MUL expression
	| expression MOD expression
	;
additive_expression:
	  expression ADD expression
	| expression SUB expression
	;
relational_expression:
	  expression LT expression
	| expression GT expression
	| expression LE expression
	| expression GE expression
	| expression EQ expression 
	| expression NE expression
	;
assignment_expression:
	  variable_name ASSIGNOP expression
	;
factor:
	  INTVAL			{ $$ = $1; }
	| DOUBLEVAL			{ $$ = $1; }
	;
%%


int main() {
    int result;
   
    printf("------------------------\n"); 
    printf("Panki's Parsing Machine.\n");
    printf("------------------------\n");
    result = yyparse();
    if(result == 0){
    	printf("Parsing Complished.\n");
	printf("------------------------\n");
	printf("Please Press Ctrl+Z\n");
    }else{
    	printf("Error Detected. Please confirm the File.\n");
    }
    return 0;
}

int yyerror (char *s) /* Called by yyparse on error */
{
    fprintf (stderr, "Line:%d-%s\n", yylineno, s);
    return 0;
}