# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Setup

```sh
ln -s "$PWD" ~/.config/nvim
ln -s "$PWD/gitui" ~/.config/gitui
```

`gitui/theme.ron` themes the gitui TUI (`<leader>gg`, from the
`util.gitui` extra) to match the onedark colorscheme. gitui only reads
its config from `~/.config/gitui`, hence the second symlink.
