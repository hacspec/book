# Proving properties

In the last chapter, we proved one property on the `square` function:
panic freedom. After adding a precondition, the signature of the
`square` function was `x:u8 -> Pure u8 (requires x <. 16uy) (ensures fun _ -> True)`.

This contract stipulates that, given a small input, the function will
*return a value*: it will not panic or diverge. We could enrich the
contract of `square` with a post-condition about the fact it is a
increasing function:

```rust,noplaypen
{{#include sources.rs:square_ensures}}
```
```ocaml
{{#include Sources.fst:square_ensures}}
```

Such a simple post-condition is automatically proven by F*. The
properties of our `square` function are not fasinating. Let's study a
more interesting example: [Barrett reduction](https://en.wikipedia.org/wiki/Barrett_reduction).

## A concrete example of contract: Barrett reduction
While the correctness of `square` is obvious, the Barrett reduction is
not. 

Given `value` a field element (a `i32` whose absolute value is at most
`BARRET_R`), the function `barrett_reduce` defined below computes
`result` such that:

 - `result ≡ value (mod FIELD_MODULUS)`;
 - the absolute value of `result` is bound as follows:
   `|result| ≤ FIELD_MODULUS / 2 · (|value|/BARRETT_R + 1)`.

It is easy to write this contract directly as `hax::requires` and
`hax::ensures` annotations, as shown in the snippet below.

```rust,noplaypen
{{#include sources.rs:barrett}}
```
```ocaml
{{#include Sources.fst:barrett}}
```

Note that we call to `cancel_mul_mod`, a lemma: in Rust, this have no
effect, but in F*, that establishes that `(quotient * 3329) % 3329` is
zero. With the help of that one lemma, F* is able to prove the
reduction computes the expected result.

This Barrett reduction examples is taken from
[libcrux](https://github.com/cryspen/libcrux/tree/main)'s proof of
Kyber which is using hax and F*.

This example showcases an **intrinsic proof**: the function
`barrett_reduce` not only computes a value, but it also ship a proof
that the post-condition holds. The pre-condition and post-condition
gives the function a formal specification, which is useful both for
further formal verification and for documentation purposes.

## Extrinsic properties with lemmas
Consider the `encrypt` and `decrypt` functions below. Those functions
have no precondition, don't have particularly interesting properties
individually. However, the compostion of the two yields an useful
property: encrypting a ciphertext and decrypting the result with a
same key produces the ciphertext again. `|c| decrypt(c, key)` is the
inverse of `|p| encrypt(p, key)`.


```rust,noplaypen
{{#include sources.rs:encrypt_decrypt}}
```
```ocaml
{{#include Sources.fst:encrypt_decrypt}}
```

In this situation, adding a pre- or a post-condition to either
`encrypt` or `decrypt` is not useful: we want to state our inverse
property about both of them. Better, we want this property to be
stated directly in Rust: just as with pre and post-conditions, the
Rust souces should clearly state what is to be proven. 

To this end, Hax provides a macro `lemma`. Below, the Rust function
`encrypt_decrypt_identity` takes a key and a plaintext, and then
states the inverse property. The body is empty: the details of the
proof itself are not relevant, at this stage, we only care about the
statement. The proof will be completed manually in the proof
assistant.

```rust,noplaypen
{{#include sources.rs:encrypt_decrypt_identity}}
```
```ocaml
{{#include Sources.fst:encrypt_decrypt_identity}}
```


