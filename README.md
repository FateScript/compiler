# compiler

###  词法分析器  

词法分析器使用lex写成，采用的环境是ubuntu 14.04，需要预装flex，如果没有flex，可以通过sudo apt-get install flex获得

如果要一步步生成所需文件，则需按照如下步骤：

 * 在终端运行  flex  lexcial_analyser.l，会生成lex.yy.c 文件  
 * 在终端运行  gcc  lex.yy.c  -o  analyser  -ll，会生成analyser二进制程序(在windows下用gcc lex.yy.c -o analyser即可，无需加ll选项)  
 * 运行  ./analyser  demon  (demon为所需要进行词法分析的c源文件)，结果会生成在token.txt  ,并且如果词法分析过程出现错误，则终端会显示No，并且指出哪一行程序的哪一个部分会有错误。如果没有问题，则在屏幕上输出yes  



