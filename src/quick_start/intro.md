# Quick start with hax and F*

You want to try hax out on a Rust crate of yours? This chapter is what you are looking for!

## Setup the tools

 - **user-checkable** [Install the hax toolchain](https://github.com/hacspec/hax?tab=readme-ov-file#installation).  
   <span style="margin-right:30px;"></span>🪄 Running `cargo hax --version` should print some version info.
 - **user-checkable** [Install F*](https://github.com/FStarLang/FStar/blob/master/INSTALL.md)

## Setup the crate you want to verify

*Note: the instructions below assume you are in the folder of the specifc crate (**not workspace!**) you want to extract.*

 - **user-checkable** Create the folder `proofs/fstar/extraction` folder, right next to the `Cargo.toml` of the crate you want to verify.  
   <span style="margin-right:30px;"></span>🪄 `mkdir -p proofs/fstar/extraction`
 - **user-checkable** Copy [this makefile](https://gist.github.com/W95Psp/4c304132a1f85c5af4e4959dd6b356c3) to `proofs/fstar/extraction/Makefile`.  
   <span style="margin-right:30px;"></span>🪄 `curl -O proofs/fstar/extraction/Makefile https://gist.githubusercontent.com/W95Psp/4c304132a1f85c5af4e4959dd6b356c3/raw/64fd922820b64d90f4d26eaf70ed02e694c30719/Makefile`
 - **user-checkable** Add `hax-lib` and `hax-lib-macros` as dependencies to your crate.  
   <span style="margin-right:30px;"></span>🪄 `cargo add --git https://github.com/hacspec/hax hax-lib hax-lib-macros`

## Extract the functions you are interested in

*Note: the instructions below assume you are in the folder of the
specific crate you want to extract.*

Run the command `cargo hax into fstar` to extract every item of your
crate as F* modules in the subfolder `proofs/fstar/extraction`.

Probably, your Rust crate contains mixed kinds of code: some is
critical (e.g. the library functions at the core of your crate) while
some other is not (e.g. the binary driver that wrap the library). In
this case, you likely want to extract only partially your crate, so
that you can focus on the important part.

If you want to extract a function
`your_crate::some_module::my_function`, you need to tell `hax` to
extract nothing but `my_function`: 
`cargo hax into -i '-** +your_crate::some_module::my_function' fstar`.
Note this command will extract `my_function` but also any item
(function, type, etc.) from your crate which is used directly or
indirectly by `my_function`.

## Start F* verification
After running the hax toolchain on your Rust code, you will end up
with various F* modules in the `proofs/fstar/extraction` folder. The
`Makefile` in `proofs/fstar/extraction` will run F*.

1. **Lax check:** the first step is to run `OTHERFLAGS="--lax" make`,
   which will run F* in "lax" mode. The lax mode just make sure basic
   typechecking works: it is not proving anything. This first step is
   important because there might be missing libraries. If F* is not
   able to find a defintion, it is probably a `libcore` issue: you
   probably need to edit the F* library, which lives in the
   `proofs-libs` directory in the root of the hax repo.
2. **Typecheck:** the second step is to run `make`. This will ask F*
   to typecheck fully your crate. This is very likely that you need to
   add preconditions and postconditions at this stage. Indeed, this
   second step is about panic freedom: if F* can typecheck your crate,
   it means your code *never* panics, which already is an important
   property.

To go further, please read the next chapter.
