#lang brag

program: /"\n"* /"HAI" /"\n"+ block /"KTHXBYE" /"\n"*

block: statement*

statement: (declare | assign | define-func | statement-expresssion | return) /"\n"+ 

statement-expresssion: expression

define-func : /"HOW IZ I" ID (/"YR" ID (/"AN YR" ID)*)? /"\n"+ block /"IF U SAY SO"

return: /"FOUND YR" expression
      | /"GTFO"

it: /"IT"

call-func: /"I IZ" ID (/"YR" ID (/"AN YR" ID)*)? /"MKAY"

cast: /"MAEK" expression /"A" TYPE

expression: BOOLEAN | INTEGER | FLOAT | STRING | ID | cast | call-func | it | math

math: "SUM OF" expression /"AN" expression
    | "DIFF OF" expression /"AN" expression
    | "PRODUKT OF" expression /"AN" expression
    | "QUOSHUNT OF" expression /"AN" expression
    | "MOD OF" expression /"AN" expression
    | "BIGGR OF" expression /"AN" expression
    | "SMALLR OF" expression /"AN" expression


declare: /"I HAS A" ID /"ITZ" expression
       | /"I HAS A" ID

assign: ID /"R" expression


