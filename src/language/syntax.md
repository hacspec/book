# Syntax

```
P ::= [i]\*                     Program items
i ::= array!(t, μ, n)           Array type declaration where n is a natural number
    | fn f([d]+) -> μ b         Function declaration
d ::= x: τ                      Function argument
μ ::= unit|bool|int             Base types
    | Seq<μ>                    Sequence
    | ([μ]+)                    Tuple
τ ::= μ                         Plain type
    | &μ                        Immutable reference
b ::= {[s;]+}                   Block
s ::= let x: τ = e              Let binding
    | x = e                     Variable reassignment
    | if e then b (else b)      Conditional statements
    | for x in e..e b           For loop (integers only)
    | e                         Return expression
    | b                         Statement block
e ::= ()|true|false             Unit and boolean literals
    | n                         Integer literal
    | x                         Variable
    | f([a]+)                   Function call
    | e ⊙ e                     Binary operations
    | ⊘ e                       Unary operations
    | ([e]+)                    Tuple constructor
    | e.(n)                     Tuple field access where n is a natural number
    | x[e]                      Array or sequence index
a ::= e                         Linear argument
    | &e                        Call-site borrowing
⊙ ::= + | - | * | / | &&
    | || | == | != | > | <
⊘ ::= - | ~
```
