#!/bin/bash
brew update

brew install alacritty ripgrep 

ln -s $(pwd)/zsh/.zshrc ~/.zshrc

ln -s $(pwd)/nvim ~/.config/nvim
ln -s $(pwd)/alacritty ~/.config/alacritty
