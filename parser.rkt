#lang brag

program: /"\n"* /"HAI" /"\n"+ block /"KTHXBYE" /"\n"*

block: statement*

statement: (declare | assign) /"\n"+ 

cast: /"MAEK" expression /"A" TYPE

expression: BOOLEAN | INTEGER | FLOAT | STRING | ID | cast

declare: /"I HAS A" ID /"ITZ" expression
       | /"I HAS A" ID

assign: ID /"R" expression
