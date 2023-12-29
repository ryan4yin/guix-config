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

1. `'a`: a syntax sugar of `(quote a)`, a symbol `a` is not evaluated.
1. `#t` and `#f`: true and false
1. `'()` or `nil`: empty list
1. `(list arg1 arg2 …)` or `'(arg1 arg2 …)`: a linked list, 
1. `cons* arg1 arg2 …`: similar to `(list arg1 arg2 …)`, but its last cons cell is a dotted list, which does not have `nil` for its cdr.
   1. This function is called `list*` in some other Schemes and in Common LISP.


```bash
scheme@(guile-user)> (cons* 1 2 3 4 5)
$4 = (1 2 3 4 . 5)
scheme@(guile-user)> (list 1 2 3 4 5)
$5 = (1 2 3 4 5)
scheme@(guile-user)> '(1 2 3 4 5)
$6 = (1 2 3 4 5)

scheme@(guile-user)> '(1 2)
$7 = (1 2)
scheme@(guile-user)> (cons 1 (cons 2 '()))
$8 = (1 2)
;; a list which does not have `nil` for its cdr is called a dotted list.
scheme@(guile-user)> (cons 1 2)
$9 = (1 . 2)
```

## FAQ

### 1. In which scenarios should I use `cons*` instead of `list` / `cons`?

1. `cons` create a pair with two elements, the first element is its `car` and the second element its `cdr`.
2. `(list a b ...)` create a linked list with multiple elements, and a `nil` is appended to the end of the list.
3. `(cons* a b ... g h)` create a linked list with multiple elements, but the last element is not `nil`, it is the last element of the list.

`cons*` is useful when you want to **insert multiple elements at the front of a list**. For example, `(cons* 1 2 3 '(4 5 6))` will insert `1 2 3` at the front of `(4 5 6)`, and the result is `(1 2 3 4 5 6)`.

nonguix's installation description use `cons* ... %default-channels` to insert its channel infront of guix's default channels.

if we use `list ... %default-channels`, the result have an extra `nil` at the end of the list, which is not what we want.

```bash
scheme@(guile-user) [1]> (list 1 2 3 (list 4 5 6))
$13 = (1 2 3 (4 5 6))
scheme@(guile-user) [1]> '(1 2 3 (4 5 6))
$14 = (1 2 3 (4 5 6))
scheme@(guile-user) [1]> (cons* 1 2 3 (list 4 5 6))
$15 = (1 2 3 4 5 6)
```

### 2. How to install package vai `config.scm`?

1. `guix search <package-name>` to find the package's location.
   1. For example, `guix search kitty` will show the package's location is `gnu/packages/terminals.scm`.
1. add `(use-package-modules terminals)` to the top of `config.scm`.
1. add `kitty` to the `packages` list in `config.scm`.

### 3. Documentation?

1. docs for `use-modules`: it's provided by guile, see <https://www.gnu.org/software/guile/manual/html_node/Using-Modules.html>
1. docs for `use-service-modules`, `use-package-modules` & `use-system-modules`: No docs for them. But you can read their definition in source code: <https://git.savannah.gnu.org/cgit/guix.git/tree/gnu.scm#n143>
1. Source code: <https://git.savannah.gnu.org/cgit/guix.git/tree/>

### 4. Why `guix pull` so slow?(stuck in `computing guix derivation`)

> https://guix.gnu.org/manual/en/html_node/Channels-with-Substitutes.html

When running `guix pull`, Guix will first compile the definitions of every available package. This is an expensive operation for which substitutes (see Substitutes) may be available.

As for nonguix, you can add its official substitutes to speed up the `guix pull` process, search 'substitutes' in <https://gitlab.com/nonguix/nonguix> for details.

> In NixOS, `nix` has no compilation phase and is a fully interpreted language, so `nix flake update` is much faster than `guix pull`.

The substitutes you added into `config.scm` will only be available after the first `guix system reconfigure` finished!
To speed up the first reconfigure, see nonuix's official README for details.

#### 5. `guix system reconfigure` so slow?(stuck in `build phase`)

Same as above, you can add nonguix's substitutes to speed up the `guix system reconfigure` process.

