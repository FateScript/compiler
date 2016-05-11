
%{            //全局声明部分
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int  line = 1;
%}

digit [0-9]
hex [0-9a-fA-F]
octal [0-7]


keyword1  (auto)|(double)|(int)|(struct)|(break)|(else)|(long)|(switch)|(case)|(enum)|(register)
keyword2  (typedef)|(char)|(extern)|(return)|(union)|(const)|(float)|(short)|(unsigned)|(continue)|(for)
keyword3  (signed)|(void)|(default)|(goto)|(sizeof)|(volatile)|(do)|(while)|(static)|(if)|(_Bool)|(_Complex)|(_Imaginary)

keyword   {keyword1}|{keyword2}|{keyword3}


identifier  [a-zA-Z_][a-zA-Z0-9_]*


universal   \\(u|U){hex}{4}


hex_constant  0[xX]{hex}+{in_suffix}?
octal_constant 0{octal}*{in_suffix}?
normal_constant [1-9]{digit}*{in_suffix}?
first_suffix  [uU]?[lL]{1,2}?
second_suffix  [lL]{1,2}?[uU]?
in_suffix  {first_suffix}|{second_suffix}

integer_constant  {hex_constant}|{octal_constant}|{normal_constant}

flt_suffix [flFL]
digit_seq  {digit}+
hex_seq    {hex}+
exponent  [eE][+-]?{digit_seq}
binary_exponent  [pP][+-]?{digit_seq}
fractional_constant  ({digit_seq}\.)|({digit_seq}?\.{digit_seq})
hex_frac_constant  ({hex_seq}\.)|({hex_seq}?\.{hex_seq})

decimal_flt_constant  ({fractional_constant}{exponent}?{flt_suffix}?)|({digit_seq}{exponent}{flt_suffix}?)
hex_flt_constant      0[xX]({fractional_constant}|{hex_frac_constant}){binary_exponent}{flt_suffix}?

float_constant  {decimal_flt_constant}|{hex_flt_constant}


char_seq       ([^\'\\])|{escape_seq}
escape_seq     (\\{octal}{1,3})|(\\x{hex}+)|{universal}|(\\\')|(\\\")|(\\\\)|(\\a)|(\\b)|(\\f)|(\\n)|(\\r)|(\\t)|(\\v)

char_constant   L?\'{char_seq}+\'

constant   {integer_constant}|{float_constant}|{char_constant}


string_seq      ([^\"\\])|{escape_seq}
string_literal    L?\"{string_seq}*\"



punc1  ("["|"]"|"("|")"|"{"|"}"|"."|"->"|"&"|"*"|"~"|"+"|"++"|"-"|"--"|"!")
punc2  ("/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||")
punc3  ("?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^=")
punc4  ("|="|","|"#"|"##"|"<:"|":>"|"<%"|"%>"|"%:"|"%:%:")

punctuators   {punc1}|{punc2}|{punc3}|{punc4}

white_word    [ \t]

%%


"auto"          {  return AUTO; }
"break"         {  return BREAK; }
"case"          {  return CASE; }
"char"          {  return CHAR; }
"const"         {  return CONST; }
"continue"      {  return CONTINUE; }
"default"       {  return DEFAULT; }
"do"            {  return DO; }
"double"        {  return DOUBLE; }
"else"          {  return ELSE; }
"enum"          {  return ENUM; }
"extern"        {  return EXTERN; }
"float"         {  return FLOAT; }
"for"           {  return FOR; }
"goto"          {  return GOTO; }
"if"            {  return IF; }
"int"           {  return INT; }
"long"          {  return LONG; }
"register"      {  return REGISTER; }
"return"        {  return RETURN; }
"short"         {  return SHORT; }
"signed"        {  return SIGNED; }
"sizeof"        {  return SIZEOF; }
"static"        {  return STATIC; }
"struct"        {  return STRUCT; }
"switch"        {  return SWITCH; }
"typedef"       {  return TYPEDEF; }
"union"         {  return UNION; }
"unsigned"      {  return UNSIGNED; }
"void"          {  return VOID; }
"volatile"      {  return VOLATILE; }
"while"         {  return WHILE; }

"inline"        {  return INLINE; }
"restrict"      {  return RESTRICT; }
"_bool"         {  return _BOOL; }
"_complex"      {  return _COMPLEX; }

"..."           {  return ELLIPSIS; }
">>="           {  return RIGHT_ASSIGN; }
"<<="           {  return LEFT_ASSIGN; }
"+="            {  return ADD_ASSIGN; }
"-="            {  return SUB_ASSIGN; }
"*="            {  return MUL_ASSIGN; }
"/="            {  return DIV_ASSIGN; }
"%="            {  return MOD_ASSIGN; }
"&="            {  return AND_ASSIGN; }
"^="            {  return XOR_ASSIGN; }
"|="            {  return OR_ASSIGN; }
">>"            {  return RIGHT_OP; }
"<<"            {  return LEFT_OP; }
"++"            {  return INC_OP; }
"--"            {  return DEC_OP; }
"->"            {  return PTR_OP; }
"&&"            {  return AND_OP; }
"||"            {  return OR_OP; }
"<="            {  return LE_OP; }
">="            {  return GE_OP; }
"=="            {  return EQ_OP; }
"!="            {  return NE_OP; }
";"             {  return ';'; }
("{"|"<%")      {  return '{'; }
("}"|"%>")      {  return '}'; }
","             {  return ','; }
":"             {  return ':'; }
"="             {  return '='; }
"("             {  return '('; }
")"             {  return ')'; }
("["|"<:")      {  return '['; }
("]"|":>")      {  return ']'; }
"."             {  return '.'; }
"&"             {  return '&'; }
"!"             {  return '!'; }
"~"             {  return '~'; }
"-"             {  return '-'; }
"+"             {  return '+'; }
"*"             {  return '*'; }
"/"             {  return '/'; }
"%"             {  return '%'; }
"<"             {  return '<'; }
">"             {  return '>'; }
"^"             {  return '^'; }
"|"             {  return '|'; }
"?"             {  return '?'; }
("#"|"%:")      {  return '#'; }


{identifier}    {  return IDENTIFIER; }

{constant}      {  return CONSTANT; }

{string_literal}  {  return STRING_LITERAL; }


[ \t\v\f]       {  }
\n              line++;
.               { printf("Line %d: error[%s]\n",line,yytext); }


%%

//以下为函数定义部分
int comment() {
    printf("comment:\n");
    char ch, ch_after;
    int flag = 1;
    while(flag) {
        while ((ch = input()) != '*' && ch != 0) {
            putchar(ch);
        }
        flag = 0;
        if ((ch_after = input()) != '/' && ch != 0) {
            unput(ch_after);
            flag = 1;
        }
    }

    if (ch != 0) {
        putchar(ch_after);
    }
    return 0;
}

int yywrap() {
    return 1;
}
