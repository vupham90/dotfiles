#!/bin/bash
brew update

brew install ripgrep font-hack-nerd-font go@1.16 kitty

ln -s $(pwd)/.zshrc ~/.zshrc
# ln -s $(pwd)/.tmux.conf ~/.tmux.conf

ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/kitty ~/.config/kitty
