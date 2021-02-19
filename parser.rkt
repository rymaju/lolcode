#lang brag

program: /LS* /"HAI" /LS+ block /"KTHXBYE" /LS*

block: statement*

statement: (declare | assign | define-func | visible |
            statement-expresssion | return | if-then | case-statement | loop) /LS+ 

statement-expresssion: expression

define-func : /"HOW IZ I" ID (/"YR" ID (/"AN YR" ID)*)? /LS+ block /"IF U SAY SO"

return: /"FOUND YR" expression
      | /"GTFO"

it: /"IT"

visible: /"VISIBLE" expression

if-then: /"O RLY?" /LS+ "YA RLY" /LS+ block
                       ("MEBBE" expression /LS+ block)*
                       ("NO WAI" /LS+ block)? /"OIC"

case-statement: /"WTF?" /LS+ (/"OMG" expression /LS+ block)+ ( /"OMGWTF" /LS+ block)? /"OIC"



call-func: /"I IZ" ID (/"YR" ID (/"AN YR" ID)*)? /"MKAY"

cast: /"MAEK" expression /"A" TYPE

expression: BOOLEAN | INTEGER | FLOAT | STRING | ID | cast | call-func | it | math | compare 

math: "SUM OF" expression /"AN" expression
    | "DIFF OF" expression /"AN" expression
    | "PRODUKT OF" expression /"AN" expression
    | "QUOSHUNT OF" expression /"AN" expression
    | "MOD OF" expression /"AN" expression
    | "BIGGR OF" expression /"AN" expression
    | "SMALLR OF" expression /"AN" expression

loop: /"IM IN YR" /ID ("UPPIN" | "NERFIN") /"YR" ID ("TIL"|"WILE") expression /LS+ block /"IM OUTTA YR" /ID

compare: ("BOTH SAEM" | "DIFFRINT") expression /"AN" expression
       
declare: /"I HAS A" ID /"ITZ" expression
       | /"I HAS A" ID

assign: ID /"R" expression


