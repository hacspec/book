# Tutorial: Writing a new backend for `hax`

In this tutorial we're going to look at the process of implementing a
new backend for `hax`. Concretely, we will be looking at the translation
of a *subset of Rust* to a *subset of Typed Scheme*, a dialect of Racket.

While the existing `hax` backends target verification tools like
interactive proof assistants or protocol analyzers, I've chosen this
target language, specifically because we will be able to preserve the
type information from Rust, and because the S-expression based syntax
of Scheme will be a relatively "easy" translation target. After all,
the purpose of this tutorial is to familiarize yourself with the
process of setting up and gettings started with a backend, and the
actual translation is not as important as understanding the mechanisms
which make `hax` tick.

We will proceed following roughly these steps:

1.  State the goals and non-goals of the desired translation.
2.  Make the necessary changes in the frontend to be able to test our
    backend using the `hax` CLI.
3.  Start an Ocaml module for our backend, based on a generic AST
    printer.
4.  Wrangle the Rust AST into translation-shape using `hax` *translation phases*.
5.  Using the `hax` engine's AST visitor mechanisms, collect information
    about our translation target and its dependencies.
6.  Given this information, define translations from Rust AST parts to
    Typed Scheme.

After we have reached our modest goals (more on those in the next
section) with this tutorial backend, I will give some perspective on
things we did not cover in the tutorial and which could be next steps.


The code for this toy backend lives on the
[`jonas/backend-tutorial`](https://github.com/hacspec/hax/tree/jonas/backend-tutorial)
branch of `hax`.


## Before we start: Defining the backend's purpose

Before we get started, we will have to get an understanding what we
want our backend to be able to translate and how these things should
be expressed in the target language.

For the sake of this tutorial, our goal is to be able translate a
single function from our Rust source crate, as well as it's
dependencies in terms of data structures and functions it calls, such
that the result is a Typed Scheme function definition which "behaves
the same", i.e. input and output of the Rust and Typed Scheme
functions should be equivalent modulo perhaps some differences
resulting from differences in the fundamental type systems of both
languages.[^note]

## Basic Setup I: Introducing a new backend option to the `hax` CLI

## Basic Setup II: Starting a backend from the `GenericPrinter` module

## Getting the AST ready for translation: Applying phases

## Before translation: AST analysis using visitors

## Finally: Translating into the target syntax

## Testing the backend

## Next steps




[^note]: There are more caveats here, really, since `hax` operates
only on one crate at the moment. This means, if the source crate has
external dependencies which `hax` does not know about, i.e. anything
other than a (steadily growing!) subset of Rust's `core` library, then
our backend will not be able to tranlate it. Still, in these cases, we
can perhaps fill in a placeholder translation with the expected type
signature and a comment note to manually refine the placeholder
translation.
