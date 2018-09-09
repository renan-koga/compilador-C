/* Nao usar a biblioteca do flex*/
%option noyywrap
%x COMMENT

%{
int chars = 0;
int words = 0;
int lines = 1;
int lines_comment = 0;
%}

%%
"void"                        {if (words > 0) printf("\n"); printf("VOID"); chars += strlen(yytext); words++;}
"int"                         {if (words > 0) printf("\n"); printf("INT"); chars += strlen(yytext); words++;}
"char"                        {if (words > 0) printf("\n"); printf("CHAR"); chars += strlen(yytext); words++;}
"return"                      {if (words > 0) printf("\n"); printf("RETURN"); chars += strlen(yytext); words++;}
"break"                       {if (words > 0) printf("\n"); printf("BREAK"); chars += strlen(yytext); words++;}
"switch"                      {if (words > 0) printf("\n"); printf("SWITCH"); chars += strlen(yytext); words++;}
"case"                        {if (words > 0) printf("\n"); printf("CASE"); chars += strlen(yytext); words++;}
"default"                     {if (words > 0) printf("\n"); printf("DAFAULT"); chars += strlen(yytext); words++;}
"do"                          {if (words > 0) printf("\n"); printf("DO"); chars += strlen(yytext); words++;}
"while"                       {if (words > 0) printf("\n"); printf("WHILE"); chars += strlen(yytext); words++;}
"for"                         {if (words > 0) printf("\n"); printf("FOR"); chars += strlen(yytext); words++;}
"if"                          {if (words > 0) printf("\n"); printf("IF"); chars += strlen(yytext); words++;}
"else"                        {if (words > 0) printf("\n"); printf("ELSE"); chars += strlen(yytext); words++;}
"typedef"                     {if (words > 0) printf("\n"); printf("TYPEDEF"); chars += strlen(yytext); words++;}
"struct"                      {if (words > 0) printf("\n"); printf("STRUCT"); chars += strlen(yytext); words++;}
"+"                           {if (words > 0) printf("\n"); printf("PLUS"); chars += strlen(yytext); words++;}
"-"                           {if (words > 0) printf("\n"); printf("MINUS"); chars += strlen(yytext); words++;}
"*"                           {if (words > 0) printf("\n"); printf("MULTIPLY"); chars += strlen(yytext); words++;}
"/"                           {if (words > 0) printf("\n"); printf("DIV"); chars += strlen(yytext); words++;}
"%"                           {if (words > 0) printf("\n"); printf("REMAINDER"); chars += strlen(yytext); words++;}
"++"                          {if (words > 0) printf("\n"); printf("INC"); chars += strlen(yytext); words++;}
"--"                          {if (words > 0) printf("\n"); printf("DEC"); chars += strlen(yytext); words++;}
"&"                           {if (words > 0) printf("\n"); printf("BITWISE_AND"); chars += strlen(yytext); words++;}
"|"                           {if (words > 0) printf("\n"); printf("BITWISE_OR"); chars += strlen(yytext); words++;}
"~"                           {if (words > 0) printf("\n"); printf("BITWISE_NOT"); chars += strlen(yytext); words++;}
"^"                           {if (words > 0) printf("\n"); printf("BITWISE_XOR"); chars += strlen(yytext); words++;}
"!"                           {if (words > 0) printf("\n"); printf("NOT"); chars += strlen(yytext); words++;}
"&&"                          {if (words > 0) printf("\n"); printf("LOGICAL_AND"); chars += strlen(yytext); words++;}
"||"                          {if (words > 0) printf("\n"); printf("LOGICAL_OR"); chars += strlen(yytext); words++;}
"=="                          {if (words > 0) printf("\n"); printf("EQUAL"); chars += strlen(yytext); words++;}
"!="                          {if (words > 0) printf("\n"); printf("NOT_EQUAL"); chars += strlen(yytext); words++;}
"<"                           {if (words > 0) printf("\n"); printf("LESS_THAN"); chars += strlen(yytext); words++;}
">"                           {if (words > 0) printf("\n"); printf("GREATER_THAN"); chars += strlen(yytext); words++;}
"<="                          {if (words > 0) printf("\n"); printf("LESS_EQUAL"); chars += strlen(yytext); words++;}
">="                          {if (words > 0) printf("\n"); printf("GREATER_EQUAL"); chars += strlen(yytext); words++;}
">>"                          {if (words > 0) printf("\n"); printf("R_SHIFT"); chars += strlen(yytext); words++;}
"<<"                          {if (words > 0) printf("\n"); printf("L_SHIFT"); chars += strlen(yytext); words++;}
"="                           {if (words > 0) printf("\n"); printf("ASSIGN"); chars += strlen(yytext); words++;}
"+="                          {if (words > 0) printf("\n"); printf("ADD_ASSIGN"); chars += strlen(yytext); words++;}
"-="                          {if (words > 0) printf("\n"); printf("MINUS_ASSIGN"); chars += strlen(yytext); words++;}
";"                           {if (words > 0) printf("\n"); printf("SEMICOLON"); chars += strlen(yytext); words++;}
","                           {if (words > 0) printf("\n"); printf("COMMA"); chars += strlen(yytext); words++;}
":"                           {if (words > 0) printf("\n"); printf("COLON"); chars += strlen(yytext); words++;}
"("                           {if (words > 0) printf("\n"); printf("L_PAREN"); chars += strlen(yytext); words++;}
")"                           {if (words > 0) printf("\n"); printf("R_PAREN"); chars += strlen(yytext); words++;}
"{"                           {if (words > 0) printf("\n"); printf("L_CURLY_BRACKET"); chars += strlen(yytext); words++;}
"}"                           {if (words > 0) printf("\n"); printf("R_CURLY_BRACKET"); chars += strlen(yytext); words++;}
"["                           {if (words > 0) printf("\n"); printf("L_SQUARE_BRACKET"); chars += strlen(yytext); words++;}
"]"                           {if (words > 0) printf("\n"); printf("R_SQUARE_BRACKET"); chars += strlen(yytext); words++;}
"?"                           {if (words > 0) printf("\n"); printf("TERNARY_CONDITIONAL"); chars += strlen(yytext); words++;}
"#"                           {if (words > 0) printf("\n"); printf("NUMBER_SIGN"); chars += strlen(yytext); words++;}
"->"                          {if (words > 0) printf("\n"); printf("POINTER"); chars += strlen(yytext); words++;}
"printf"                      {if (words > 0) printf("\n"); printf("PRINTF"); chars += strlen(yytext); words++;}
"scanf"                       {if (words > 0) printf("\n"); printf("SCANF"); chars += strlen(yytext); words++;}
"define"                      {if (words > 0) printf("\n"); printf("DEFINE"); chars += strlen(yytext); words++;}
"exit"                        {if (words > 0) printf("\n"); printf("EXIT"); chars += strlen(yytext); words++;}

" "                           {chars++;}
[\n]                          {lines++; chars=0;}
"//".*"\n"                    {lines++; chars=0;}
"/*"                          {BEGIN(COMMENT);}
<COMMENT>"*/"                 {BEGIN(INITIAL);}
<COMMENT>([^*]|\n)+|.         {int i; lines_comment = lines; chars+=2; for(i=0; i<strlen(yytext); i++) {words++; chars++; if (yytext[i] == '\n') { lines++; chars = 0;}} chars+=2;}
<COMMENT><<EOF>>              {if (words > 0) printf("\n"); printf("error:lexical:%d:%d :unterminated comment", lines_comment, chars+1); return 0;}
0[x|X]([0-9]+|[a-fA-F]+)      {if (words > 0) printf("\n"); printf("NUM_HEXA(%s)",yytext); chars += strlen(yytext); words++;}
0[1-7]+[0-7]*                 {if (words > 0) printf("\n"); printf("NUM_OCTAL(%s)",yytext); chars += strlen(yytext); words++;}
[_?a-zA-Z]+[0-9]*             {if (words > 0) printf("\n"); printf("IDENTIFIER(%s)",yytext); chars += strlen(yytext); words++;}
[0-9]+                        {if (words > 0) printf("\n"); printf("NUM_INTEGER(%s)",yytext); chars += strlen(yytext);  words++;}
[\'](.|"\\n"|"\\t"|"\\0"|"\\a")[\']                     {if (words > 0) printf("\n"); printf("CHARACTER(%c)",yytext[1]); chars++; words++;}
[\"].*[\"]                    {if (words > 0) printf("\n"); printf("STRING("); int i; for(i=1;i<strlen(yytext)-1;i++) printf("%c",yytext[i]); printf(")"); chars += strlen(yytext); words++;}
.                             {if (words > 0) printf("\n"); printf("error:lexical:%d:%d: %s", lines, chars+1, yytext); words++;}

%%

int main(int argc,char *argv){
  yylex();
  return 0;
}
