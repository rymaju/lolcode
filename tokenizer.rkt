#lang br/quicklang
(require brag/support)

(define-lex-abbrev digits (:+ (char-set "0123456789")))
(define-lex-abbrev varchars (:seq alphabetic (:* (:or alphabetic numeric "_"))  ))
(define-lex-abbrev booleans (:or "WIN" "FAIL"))
(define-lex-abbrev reserved-terms (:or "HAI" "R" "KTHXBYE" "I HAS A" "ITZ" "MAEK" "A"
                                       "HOW IZ I" "YR" "AN YR" "IF U SAY SO" "I IZ" "MKAY"
                                       "FOUND YR" "GTFO" "IT"
                                       "SUM OF" "DIFF OF" "PRODUKT OF" "QUOSHUNT OF"
                                       "MOD OF" "BIGGR OF" "SMALLR OF" "AN"
                                       "BOTH SAEM" "DIFFRINT" "VISIBLE"
                                       "O RLY?" "YA RLY" "MEBBE" "NO WAI" "OIC"
                                       "WTF?" "OMG" "OMGWTF"
                                       "IM IN YR" "IM OUTTA YR" "TIL" "WILE"
                                       "UPPIN" "NERFIN"
                                       ))

(define-lex-abbrev types (:or "TROOF" "YARN" "NUMBR" "NUMBAR" "NOOB"))
(define LINE-SEP (token 'LS 'LS))

(define (make-tokenizer port)
  (define (next-token)
    (define lolcode-lexer
      (lexer-srcloc
       [(:or "\n" ",") LINE-SEP]
       [whitespace (token lexeme #:skip? #t)]
       [(from/to "BTW" "\n") LINE-SEP]
       [(from/to "OBTW" "TLDR") (next-token)]
       [reserved-terms (token lexeme lexeme)]
       [types (token 'TYPE lexeme)]
       [booleans (token 'BOOLEAN (string=? "WIN" lexeme))]
       [digits (token 'INTEGER (string->number lexeme))]
       [(:or (:seq (:? digits) "." digits)
             (:seq digits "."))
        (token 'FLOAT (string->number lexeme))]
       [(:or (from/to "\"" "\"") (from/to "'" "'"))
        (token 'STRING
               (substring lexeme
                          1 (sub1 (string-length lexeme))))]
       [varchars (token 'ID (string->symbol lexeme))]))
    (lolcode-lexer port))  
  next-token)

(provide make-tokenizer)