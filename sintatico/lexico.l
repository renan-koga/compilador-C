/* Nao usar a biblioteca do flex*/
%option noyywrap
%x COMMENT

%{
  #include <sintatico.tab.h>

  int chars = 1;
  int lines = 1;
  int columns = 1;
  int line_comment = 0;
  int first = 0;
  int end_file = 0;
%}

%%
"void"                        {line_comment = 0; columns += strlen(yytext); return VOID;}
"int"                         {line_comment = 0; columns += strlen(yytext); return INT;}
"char"                        {line_comment = 0; columns += strlen(yytext); return CHAR;}
"return"                      {line_comment = 0; columns += strlen(yytext); return RETURN;}
"break"                       {line_comment = 0; columns += strlen(yytext); return BREAK;}
"switch"                      {line_comment = 0; columns += strlen(yytext); return SWITCH;}
"case"                        {line_comment = 0; columns += strlen(yytext); return CASE;}
"default"                     {line_comment = 0; columns += strlen(yytext); return DEFAULT;}
"do"                          {line_comment = 0; columns += strlen(yytext); return DO;}
"while"                       {line_comment = 0; columns += strlen(yytext); return WHILE;}
"for"                         {line_comment = 0; columns += strlen(yytext); return FOR;}
"if"                          {line_comment = 0; columns += strlen(yytext); return IF;}
"else"                        {line_comment = 0; columns += strlen(yytext); return ELSE;}
"typedef"                     {line_comment = 0; columns += strlen(yytext); return TYPEDEF;}
"struct"                      {line_comment = 0; columns += strlen(yytext); return STRUCT;}
"+"                           {line_comment = 0; columns += strlen(yytext); return PLUS;}
"-"                           {line_comment = 0; columns += strlen(yytext); return MINUS;}
"*"                           {line_comment = 0; columns += strlen(yytext); return MULTIPLY;}
"/"                           {line_comment = 0; columns += strlen(yytext); return DIV;}
"%"                           {line_comment = 0; columns += strlen(yytext); return REMAINDER;}
"++"                          {line_comment = 0; columns += strlen(yytext); return INC;}
"--"                          {line_comment = 0; columns += strlen(yytext); return DEC;}
"&"                           {line_comment = 0; columns += strlen(yytext); return BITWISE_AND;}
"|"                           {line_comment = 0; columns += strlen(yytext); return BITWISE_OR;}
"~"                           {line_comment = 0; columns += strlen(yytext); return BITWISE_NOT;}
"^"                           {line_comment = 0; columns += strlen(yytext); return BITWISE_XOR;}
"!"                           {line_comment = 0; columns += strlen(yytext); return NOT;}
"&&"                          {line_comment = 0; columns += strlen(yytext); return LOGICAL_AND;}
"||"                          {line_comment = 0; columns += strlen(yytext); return LOGICAL_OR;}
"=="                          {line_comment = 0; columns += strlen(yytext); return EQUAL;}
"!="                          {line_comment = 0; columns += strlen(yytext); return NOT_EQUAL;}
"<"                           {line_comment = 0; columns += strlen(yytext); return LESS_THAN;}
">"                           {line_comment = 0; columns += strlen(yytext); return GREATER_THAN;}
"<="                          {line_comment = 0; columns += strlen(yytext); return LESS_EQUAL;}
">="                          {line_comment = 0; columns += strlen(yytext); return GREATER_EQUAL;}
">>"                          {line_comment = 0; columns += strlen(yytext); return R_SHIFT;}
"<<"                          {line_comment = 0; columns += strlen(yytext); return L_SHIFT;}
"="                           {line_comment = 0; columns += strlen(yytext); return ASSIGN;}
"+="                          {line_comment = 0; columns += strlen(yytext); return ADD_ASSIGN;}
"-="                          {line_comment = 0; columns += strlen(yytext); return MINUS_ASSIGN;}
";"                           {line_comment = 0; columns += strlen(yytext); return SEMICOLON;}
","                           {line_comment = 0; columns += strlen(yytext); return COMMA;}
":"                           {line_comment = 0; columns += strlen(yytext); return COLON;}
"("                           {line_comment = 0; columns += strlen(yytext); return L_PAREN;}
")"                           {line_comment = 0; columns += strlen(yytext); return R_PAREN;}
"{"                           {line_comment = 0; columns += strlen(yytext); return L_CURLY_BRACKET;}
"}"                           {line_comment = 0; columns += strlen(yytext); return R_CURLY_BRACKET;}
"["                           {line_comment = 0; columns += strlen(yytext); return L_SQUARE_BRACKET;}
"]"                           {line_comment = 0; columns += strlen(yytext); return R_SQUARE_BRACKET;}
"?"                           {line_comment = 0; columns += strlen(yytext); return TERNARY_CONDITIONAL;}
"#"                           {line_comment = 0; columns += strlen(yytext); return NUMBER_SIGN;}
"->"                          {line_comment = 0; columns += strlen(yytext); return POINTER;}
"printf"                      {line_comment = 0; columns += strlen(yytext); return PRINTF;}
"scanf"                       {line_comment = 0; columns += strlen(yytext); return SCANF;}
"define"                      {line_comment = 0; columns += strlen(yytext); return DEFINE;}
"exit"                        {line_comment = 0; columns += strlen(yytext); return EXIT;}
" "                           {line_comment = 0; columns++;}
[\n]                          {line_comment = 0; lines++; columns=1;}
"//".*[\n]?                   {first = columns; lines++; columns=1; line_comment = 1;}
"/*"                          {chars = columns+2; BEGIN(COMMENT);}
<COMMENT>"*/"                 {line_comment = 0; columns = chars+1; BEGIN(INITIAL);}
<COMMENT>([^*]|\n)+|.         {int i; for(i=0; i<strlen(yytext); i++) {if (yytext[i] == '\n') { lines++; chars = 1;} else chars++;}}
<COMMENT><<EOF>>              {printf("error:lexical:%d:%d :unterminated comment", lines, columns); exit(0);}
0[x|X]([0-9]+|[a-fA-F]+)      {line_comment = 0; columns += strlen(yytext); return NUM_HEXA;}
0[1-7]+[0-7]*                 {line_comment = 0; columns += strlen(yytext); return NUM_OCTAL;}
[_?a-zA-Z]+[0-9]*             {line_comment = 0; columns += strlen(yytext); return IDENTIFIER;}
[0-9]+                        {line_comment = 0; columns += strlen(yytext); return NUM_INTEGER;}
'.'|[\n]|[\t]|[\0]|[\a]       {line_comment = 0; columns++; return CHARACTER;}
[\"].*[\"]                    {line_comment = 0; columns += strlen(yytext); return STRING;}
<<EOF>>                       {end_file = 1; return END_FILE;}
.                             {printf("error:lexical:%d:%d: %s", lines, columns, yytext); exit(0);}

%%cd