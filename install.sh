#!/bin/bash
brew update

brew install ripgrep font-hack-nerd-font go@1.16 alacritty tmux

ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf

ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/alacritty ~/.config/alacritty
