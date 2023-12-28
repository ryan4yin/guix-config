# guix-config

My dotfiles for GNU Guix


## Tutorials

Tutorials for Guile Scheme Language:

- [A Scheme Primer](https://spritely.institute/static/papers/scheme-primer.html): for a basic understanding of Scheme
- [Guile 3.0 Manual](https://www.gnu.org/software/guile/manual/): The most important part of this manual is API Reference, when in doubt, check the API Reference.

How to practice Guile Scheme Language(on NixOS):

```bash
nix shell nixpkgs#racket-minimal --command "racket"
```

Tutorials for Guix itself:

- [GNU Guix Reference Manual](https://guix.gnu.org/en/manual/en/guix.html): read this first for installation and basic usage & setup.
- [GNU Guix Cookbook](https://guix.gnu.org/en/cookbook/en/guix-cookbook.html): read this after you have your Guix installed and have some basic knowledge about Guix.

## Notes

1. `cons* arg1 arg2 …`: a syntax sugar of `(cons arg1 (cons arg2 (cons … argn)))`

