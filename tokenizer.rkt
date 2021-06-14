#lang br/quicklang
(require brag/support)
(require br-parser-tools/lex)

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
                                       "UPPIN" "NERFIN" "SMOOSH" "GIMMEH" "!"
                                       ))

(define-lex-abbrev types (:or "TROOF" "YARN" "NUMBR" "NUMBAR" "NOOB"))
(define LINE-SEP (token 'LS 'LS))

(define tokenize-as-string? #f)

(define (make-tokenizer port)
  (define (next-token)
    (define lolcode-lexer
      (if tokenize-as-string?
          (lexer-srcloc
           [(:or "\"" "'")
            (let ()
              (set! tokenize-as-string? #f)
              (token 'STRING-END 'STRING-END))]
           [":)"
            (token 'CHAR "\n")]
           [":>"
            (token 'CHAR "\t")]
           ["::"
            (token 'CHAR ":")]
           [(from/to ":{" "}")
            (let ()
              (if (string-contains? lexeme "\"")
                  ; We have skipped "through" the end of a string
                  ; i.e. ":{X" ... "}" => (token ":{X\" ... \"}")
                  (error (string-append "Error in lexer: interpolated string not closed. "
                          "             You probably forgot the closing '}' bracket somehwere."))
                  (token 'ID (string->symbol
                              (substring lexeme
                                         2 (sub1 (string-length lexeme)))))))]
           [":\""
            (token 'CHAR "\"")]
           [any-char
            (token 'CHAR lexeme)])
      
          (lexer-srcloc
           [(:or "\n" ",") LINE-SEP]
           [(:or "...\n") (next-token)]
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
           ; idea: when hitting a quote enter "string mode"
           ; parse each char literally, or match on :{X} etc

           [(:or "\"" "'")
            (let ()
              (set! tokenize-as-string? #t)
              (token 'STRING-START 'STRING-START))]
           #|
       [(:or (from/to "\"" "\"") (from/to "'" "'"))
        (token 'STRING
               (substring lexeme
                          1 (sub1 (string-length lexeme))))]
       |#
           [varchars (token 'ID (string->symbol lexeme))])))
    (lolcode-lexer port))  
  next-token)




(provide make-tokenizer)