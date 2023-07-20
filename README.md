# dotfiles

Dotfiles for various *nix tools.

## Setup

### Prerequisites

- [stow](https://www.gnu.org/software/stow/) (optional, but recommended)

### Use

Run the following to "install" the dotfiles for a given application (ie folder name):

```sh
stow --dotfiles --restow --target="$HOME" "$app"
```

Note you may have to delete existing files if they are not managed by stow already.
