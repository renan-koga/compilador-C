%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

  extern int yylex();
  extern char* yytext;
  extern int lines;
  extern int columns;
	extern int end_file;
	extern int line_comment;
	extern int first;
	char *string;

	void printLine(int line);
	void printErroPointer(int column);
	char *getString(FILE *stdin);
  int yyerror(char *s);

%}
 
/* declare tokens */
%token INT
%token CHAR
%token VOID
%token RETURN
%token DO
%token WHILE
%token FOR
%token IF
%token ELSE
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV
%token REMAINDER
%token INC
%token DEC
%token BITWISE_AND
%token BITWISE_OR
%token BITWISE_NOT
%token BITWISE_XOR
%token NOT
%token LOGICAL_AND
%token LOGICAL_OR
%token EQUAL
%token NOT_EQUAL
%token LESS_THAN
%token GREATER_THAN
%token LESS_EQUAL
%token GREATER_EQUAL
%token R_SHIFT
%token L_SHIFT
%token ASSIGN
%token ADD_ASSIGN
%token MINUS_ASSIGN
%token SEMICOLON
%token COMMA
%token COLON
%token L_PAREN
%token R_PAREN
%token L_CURLY_BRACKET
%token R_CURLY_BRACKET
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token TERNARY_CONDITIONAL
%token NUMBER_SIGN
%token PRINTF
%token SCANF
%token DEFINE
%token EXIT
%token NUM_HEXA
%token NUM_OCTAL
%token NUM_INTEGER
%token IDENTIFIER
%token CHARACTER
%token STRING
%token END_FILE

%token BREAK
%token SWITCH
%token CASE
%token DEFAULT
%token TYPEDEF
%token STRUCT
%token POINTER

%start start 

%%

start: programa END_FILE {printf("SUCCESSFUL COMPILATION."); exit(0);}
;

programa: decl prog1
	| func prog1
;

prog1:
	| programa
;

decl: NUMBER_SIGN DEFINE IDENTIFIER exp
	| decl_var
	| decl_prot
;

func: tipo func1
;

func1: MULTIPLY func1
	| IDENTIFIER param L_CURLY_BRACKET func2
;

func2: decl_var func2
	| comandos R_CURLY_BRACKET
;

decl_var: tipo decl_var1
;

decl_var1: MULTIPLY decl_var1
	| IDENTIFIER decl_var2
;

decl_var2: L_SQUARE_BRACKET exp R_SQUARE_BRACKET decl_var2
	| ASSIGN exp_atr decl_var3
	| decl_var3
;

decl_var3: COMMA decl_var1
	| SEMICOLON
;

decl_prot: tipo decl_prot1
;

decl_prot1: MULTIPLY decl_prot1
	| IDENTIFIER param SEMICOLON
;

param: L_PAREN param1
;

param1: tipo param2
	| R_PAREN
;

param2: MULTIPLY param2
	| IDENTIFIER param3
;	

param3: L_SQUARE_BRACKET exp R_SQUARE_BRACKET param3
	| COMMA tipo param2
	| R_PAREN
;

tipo:	INT
	| CHAR
	| VOID
;

bloco: L_CURLY_BRACKET comandos R_CURLY_BRACKET
;

comandos: list_comandos comandos1
;

comandos1:
	| comandos
;

list_comandos: DO bloco WHILE L_PAREN exp R_PAREN SEMICOLON
	| IF L_PAREN exp R_PAREN bloco list_comandos1
	| WHILE L_PAREN exp R_PAREN bloco
	| FOR L_PAREN list_comandos2
	| PRINTF L_PAREN STRING list_comandos5
	| SCANF L_PAREN STRING COMMA BITWISE_AND IDENTIFIER R_PAREN SEMICOLON
	| EXIT L_PAREN exp R_PAREN SEMICOLON
	| RETURN list_comandos6
	| exp SEMICOLON
	| SEMICOLON
	| bloco
;

list_comandos1:
	| ELSE bloco
;

list_comandos2: SEMICOLON list_comandos3
	| exp SEMICOLON list_comandos3
;

list_comandos3: SEMICOLON list_comandos4
	| exp SEMICOLON list_comandos4
;

list_comandos4: R_PAREN bloco
	| exp R_PAREN bloco
;

list_comandos5: R_PAREN SEMICOLON
	| COMMA exp R_PAREN SEMICOLON
;

list_comandos6: SEMICOLON
	| exp SEMICOLON
;

exp: exp_atr exp1
;

exp1:
	| COMMA exp_atr exp1
;

exp_atr: exp_cond
	| exp_unaria exp_atr1
;

exp_atr1: ASSIGN exp_atr
	| ADD_ASSIGN exp_atr
	| MINUS_ASSIGN exp_atr
;

exp_cond: exp_or_logic exp_cond1
;

exp_cond1:
	| TERNARY_CONDITIONAL exp COLON exp_cond
;

exp_or_logic: exp_and_logic exp_or_logic1
;

exp_or_logic1:
	| LOGICAL_OR exp_and_logic exp_or_logic1
;

exp_and_logic: exp_or exp_and_logic1
;

exp_and_logic1:
	| LOGICAL_AND exp_or exp_and_logic1
;

exp_or: exp_xor exp_or1
;

exp_or1:
	| BITWISE_OR exp_xor exp_or1
;

exp_xor: exp_and exp_xor1
;

exp_xor1:
	| BITWISE_XOR exp_and exp_xor1
;

exp_and: exp_equal exp_and1
;

exp_and1:
	| BITWISE_AND exp_equal exp_and1
;

exp_equal: exp_rel exp_equal1
;

exp_equal1: EQUAL exp_rel exp_equal1
	| exp_equal2
;

exp_equal2:
	| NOT_EQUAL exp_rel exp_equal1
;

exp_rel: exp_shift exp_rel1
;

exp_rel1: LESS_THAN exp_shift exp_rel1
	| exp_rel2
;

exp_rel2: LESS_EQUAL exp_shift exp_rel1
	| exp_rel3
;

exp_rel3: GREATER_THAN exp_shift exp_rel1
	| exp_rel4
;

exp_rel4:
	| GREATER_EQUAL exp_shift exp_rel1
;

exp_shift: exp_add exp_shift1
;

exp_shift1: L_SHIFT exp_add exp_shift1
	| exp_shift2
;

exp_shift2:
	| R_SHIFT exp_add exp_shift1
;

exp_add: exp_mul exp_add1
;

exp_add1: MINUS exp_mul exp_add1
	| exp_add2
;

exp_add2:
	| PLUS exp_mul exp_add1
;

exp_mul: exp_cast exp_mul1
;

exp_mul1: MULTIPLY exp_cast exp_mul1
	| exp_mul2
;

exp_mul2: DIV exp_cast exp_mul1
	| exp_mul3
;

exp_mul3:
	| REMAINDER exp_cast exp_mul1
;

exp_cast: exp_unaria
	| L_PAREN tipo exp_cast1
;

exp_cast1: MULTIPLY exp_cast1
	| R_PAREN exp_cast
;

exp_unaria: exp_pos_fixa
	| INC exp_unaria
	| DEC exp_unaria
	| BITWISE_AND exp_cast
	| MULTIPLY exp_cast
	| PLUS exp_cast
	| MINUS exp_cast
	| BITWISE_NOT exp_cast
	| NOT exp_cast
;

exp_pos_fixa: exp_primaria
	| exp_pos_fixa exp_pos_fixa1
;

exp_pos_fixa1: L_SQUARE_BRACKET exp R_SQUARE_BRACKET
	| INC
	| DEC
	| L_PAREN exp_pos_fixa2
;

exp_pos_fixa2: exp_atr exp_pos_fixa3
	| R_PAREN
;

exp_pos_fixa3: COMMA exp_atr exp_pos_fixa3
	| R_PAREN
;

exp_primaria: IDENTIFIER
	| num
	| CHARACTER
	| STRING
	| L_PAREN exp R_PAREN
;

num: NUM_INTEGER
	| NUM_HEXA
	| NUM_OCTAL
;	

%%

int main(int argc, char **argv){
	string = getString(stdin);
  yyparse();

  return 0;
}

int yyerror(char *s) {
	if (end_file) {
		if (line_comment) {
			lines--;
			columns = first;
		}
		printf("error:syntax:%d:%d expected declaration or statement at end of input", lines, columns);
	}
	else {
		columns -= strlen(yytext);
		printf("error:syntax:%d:%d: %s", lines, columns, yytext);
	}
	printLine(lines);
	printErroPointer(columns);
	fflush(stderr);
}

void printLine(int line) {
	int i, j, size, currentLine=1;

	size = strlen(string);
	for (i=0; i<size; i++) {
		if (line == currentLine) {
			j = i;
			printf("\n");
			while (string[j] != '\n' && string[j] != '\0') {
				printf("%c", string[j]);
				j++;
			}

			break;
		}
		else {
			if (string[i] == '\n') {
				currentLine++;
			}
		}
	}
	printf("\n");
}

void printErroPointer(int column) {
	int i;

	for (i=0; i<column-1; i++) {
		printf(" ");
	}
	printf("^");
}

char *getString(FILE *stdin) {
	char *cadeia, ch;
	int i;

	cadeia = (char *) calloc(10000, sizeof(char));
	
	i = 0;
	while (fscanf(stdin, "%c", &ch) != EOF) {
		cadeia[i] = ch;
		i++;
	}
	cadeia[i] = '\0';
	rewind(stdin);

	return cadeia;
}