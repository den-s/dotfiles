echo 'Update configs'
git checkout

echo -n 'remove old configs...'
rm -rf ~/.config/nvim
rm -rf ~/.vim
rm ~/.vimrc
rm ~/.tmux.conf
rm ~/.config/alacritty/alacritty.yml
rm ~/.config/fish/config.fish
rm ~/.config/kitty/kitty.conf
echo ' done'

echo 'create symlinks'

# TMUX config
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Fishell config
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish

# Alacritty config
mkdir -p ~/.config/alacritty/
ln -s ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# kitty config
mkdir -p ~/.config/kitty/
ln -s ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

# VIM config
ln -s ~/dotfiles/vim ~/.config/nvim
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/init.vim ~/.vimrc

vim +PlugInstall +qall

cd /usr/local/bin/ && ln -s /Users/den/dotfiles/tmux-session tmux-session
