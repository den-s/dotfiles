echo 'Update configs'
git checkout

echo 'remove old configs...'
rm -rf ~/.config/nvim
# rm ~/.tmux.conf
# rm -rf ~/.config/alacritty
rm -rf ~/.config/fish
rm -rf ~/.config/kitty
echo ' done'

echo 'create symlinks'

# TMUX config
# ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Fishell config
ln -s ~/dotfiles/fish ~/.config/fish

# Alacritty config
# ln -s ~/dotfiles/alacritty ~/.config/alacritty

# kitty config
ln -s ~/dotfiles/kitty ~/.config/kitty

# VIM config
ln -s ~/dotfiles/vimlazy ~/.config/vim

vim +PlugInstall +qall

# cd /usr/local/bin/ && ln -s /Users/den/dotfiles/tmux-session tmux-session
