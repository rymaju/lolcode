#lang reader "reader.rkt"
HAI
    I HAS A X
    X R 2
    VISIBLE ":{X} times" BTW should output "2 times"
    VISIBLE ":{X}:{X} times" BTW should output "22 times"
    VISIBLE "::" BTW should output ":"
    VISIBLE ":>tab" BTW should output "    tab"
    VISIBLE "::{X}" BTW should output ":{X}"

KTHXBYE









