echo 'Update configs'
git checkout

echo 'remove old configs'
rm -rf ~/.config/nvim
rm -rf ~/.vim
rm ~/.vimrc
rm ~/.tmux.conf
rm -rf ~/.config/alacritty/

echo 'create symlincs'

# TMUX config
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Alacritty config
mkdir -p ~/.config/alacritty/
ln -s ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# VIM config
ln -s ~/dotfiles/vim ~/.config/nvim
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/init.vim ~/.vimrc

vim +PlugInstall +qall

cd /usr/local/bin/ && ln -s /Users/den/dotfiles/tmux-session tmux-session
