# compiler

###  词法分析器  

词法分析器使用lex生成，采用的环境是ubuntu 14.04，需要预装flex，如果没有flex，可以通过sudo apt-get install flex获得

如果要一步步生成所需文件，则需按照如下步骤：

 * 在终端运行  flex  lexcial_analyser.l，会生成lex.yy.c 文件  
 * 在终端运行  gcc  lex.yy.c  -o  analyser  -ll，会生成analyser二进制程序(在windows下用gcc lex.yy.c -o analyser即可，无需加ll选项)  
 * 运行  ./analyser  demon  (demon为所需要进行词法分析的c源文件)，结果会生成在token.txt  ,并且如果词法分析过程出现错误，则终端会显示No，并且指出哪一行程序的哪一个部分会有错误。如果没有问题，则在屏幕上输出yes  

### 语法分析器  

语法分析器位于syntax文件夹中，用lex与yacc进行生成，如果需要一步步生成所需文件，按如下步骤进行：  

 * 在终端运行 flex lexcial.l，生成lex.yy.c文件  
 * 终端运行yacc -d syntax.y，生成y.tab.h与y.tab.c文件  
 * 运行gcc y.tab.h y.tab.c lex.yy.c -o analyser生成analyser二进制文件  
 * 运行./analyser demon （demon为所需要进行词法分析的文件），如果不存在语法错误，则会输出Parse complete.否则输出Parse failed并且会报出第一个出现语法错误的地方  
 * 注意：语法分析与词法分析过程不包含预处理过程  

#### 声明  
词法分析与语法分析采用C99标准写成，具体内容可以查看C99.pdf  

