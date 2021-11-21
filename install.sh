#!/bin/bash
brew update

brew install alacritty ripgrep 

ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf

ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/alacritty ~/.config/alacritty
