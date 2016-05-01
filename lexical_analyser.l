
%{            //全局声明部分
#include <stdio.h>
#include <stdlib.h>
extern char *yytext;
extern FILE *yyin;
extern FILE *yyout;
int  line = 1;
int  hasError = 0;
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
{keyword}              fprintf(yyout, "keyword[%s]\n",yytext);
{identifier}           fprintf(yyout, "identifier[%s]\n", yytext);
{punctuators}          fprintf(yyout, "punctuator[%s]\n",yytext);
{constant}             fprintf(yyout, "constant[%s]\n",yytext);
{string_literal}       fprintf(yyout, "string[%s]\n",yytext);
{white_word}           /* ignore whitespace */;
\n                     line++;
.                      { hasError = 1; printf("line %d: error[%s]\n",line,yytext); }
%%

//以下为函数定义部分
int main(int avgs, char *avgr[]) {
    yyin = fopen(avgr[1], "r");
    yyout = fopen("token.txt","w");
    if (!yyin || !yyout) {
        return 0;
    }
    yylex();
    printf("Token in token.txt\n");
    if(hasError) {
        printf("No\n");
    }else {
        printf("Yes\n");
    }
    fclose(yyin);
    fclose(yyout);
    return 1;
}

int yywrap() {
    return 1;
}
