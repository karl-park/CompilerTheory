%{
    enum{
	none      = 0,
	identifier= 1,
	number    = 2,
	charCon   = 3,
	plus      = 4,
	minus     = 5,
	times     = 6,
	slash     = 7,
	rem       = 8,
	eql       = 9,
	neq       = 10,
	lss       = 11,
	leq       = 12,
	gtr       = 13,
	geq       = 14,
	assign    = 15,
	semicolon = 16,
	comma     = 17,
	period    = 18,
	lpar      = 19,
	rpar      = 20,
	lbrack    = 21,
	rbrack    = 22,
	lbrace    = 23,
	rbrace    = 24,		
	begin_ = 25,
	double_= 26,
	else_= 27,
	end_= 28,
	eof = 29,
	if_= 30,
	integer_= 31,
	new_= 32,
	nextDouble_= 33,
	nextInteger_= 34,
	nextLine_= 35,
	print_= 36,
	print_line_= 37,
	program_= 38,
	string_= 39,
	while_= 40,		
	increment_ = 41,
	decrement_ = 42,
	err = -1
    }TokenCodes;

    char *TokenNames[44] = {
	"none",	"identifier","number ","char","+",
	"-","*","/","%","==","!=","<","<=",">",
	">=","=","terminator;",",",".","lpar(",
	"rpar)","lbrak[","rbrak]","lbrace{",
	"rbrace}","begin", "double", "else", "end","eof", "if", "integer",
	"new", "nextDouble","nextInteger","nextLine","print", "print_line",
	"program", "string", "while","increment","decrement","ERR"
    };

    typedef struct token {
	int kind;   int col;
	int line;   int val;
	char *string;
    }Token;	

    char *keyword[16] = {
	"begin", "double", "else", "end","eof", "if", "integer",
	"new", "nextDouble","nextInteger","nextLine","print", "print_line",
	"program", "string", "while"    
    };

    int keywordVal[16] = {
	25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
	38, 39, 40
    };
    
    
%}
    
DIGIT   [0-9]
LETTER  [a-zA-Z]
IDENTIFIER [a-zA-Z][a-zA-Z]*
CONSTSTRING \"[^"]*\"

%%
begin|double|else|end|if|integer|new|nextDouble|nextInteger|nextLine|print|print_line|program|string|while	{printf("keyword\t%s\n",yytext);}
{CONSTSTRING}	{printf("constString\t%s\n",yytext);}
"("		{printf("left parenthes\t%s\n",yytext);}
")"   		 {printf("right parenthes\t%s\n",yytext);}
","		{printf("comma\t%s\n",yytext);}
{DIGIT}+  {printf("number\t%d\n",atoi(yytext));}
{DIGIT}+"."{DIGIT}*	{printf("float\t%f\n",atof(yytext));}
{IDENTIFIER}    {printf("identifier\t%s\n",yytext);}
"+"|"-"|"*"|"/"|"%"	{printf("operator\t%s\n",yytext);}
"="	{printf("assign\t%s\n",yytext);}
"=="	{printf("equal\t%s\n",yytext);}
"!="	{printf("notequal\t%s\n",yytext);}
">="    {printf("greaterthan\t%s\n",yytext);}
'<='    {printf("lessthan\t%s\n",yytext);}
";"	{printf("terminator\t%s\n",yytext);}
"/*"[^*/\n]*"*/"	; /* \/* *\/ 안의 내용은 주석 */
"//".*		; /* 주석 */
[ \t\n]+ 		; /* whitespace 무시 */
.   printf("---I don't know this char : %s---\n", yytext );   

%%
 
main(argc, argv)
int argc;
char **argv;
{
    ++argv, --argc;  /* skip over program name */
    if (argc>0)
        yyin = fopen(argv[0],"r");
    else
        yyin = stdin;
    yylex();
}
