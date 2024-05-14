# dotfiles

Dotfiles for various *nix tools.

## Setup

### Prerequisites

- [stow](https://www.gnu.org/software/stow/) (optional, but recommended)
- [just](https://github.com/casey/just) (optional)

### Use (With only stow)

Install tools manually, use the following to configure their dotfiles.

Run the following to "install" the dotfiles for a given application (ie folder name):

```sh
stow --dotfiles --restow --target="$HOME" "$app"
```

Note you may have to delete existing files if they are not managed by stow already.

### Use (with Just)

```sh
just
```

To list available options:

```sh
just --list
```
