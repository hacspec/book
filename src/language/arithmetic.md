# Arithmetic

hacspec overloads the arithmetic operators for a wide variety of types
corresponding to mathematical values used in cryptographic specifications.

All of these types implement the `Numeric` trait defined by the hacspec standard
library. The arithmetic operators work for all kinds of integers, but also
arrays and sequences (point-wise operations).

Note that the list of types implementing `Numeric` is hardcoded in the
hacspec compiler, and as of this day cannot be extended by the user.

While the Rust compiler can infer the type of integer literals automatically,
this feature is not implemented by the hacspec compiler:

```
let w: u32 = 0; // ERROR: an integer without a suffix will have type usize
let x: u64 = 0x64265u64; // GOOD
let y: u64 = 4u64; // GOOD
```

hacspec also makes the distinction between public and secret integers;
see the hacspec standard library documentation for more details.
