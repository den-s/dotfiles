echo 'Update configs'
git checkout
echo 'create symlincs'

# TMUX config
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Alacritty config
ln -s ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# VIM config
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc
