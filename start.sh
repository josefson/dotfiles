# git 3rd party tools
git clone https://github.com/rupa/z.git $HOME/bin/z
# git clone https://github.com/junegunn/fzf.git $HOME/bin/fzf
# git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
# git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
# git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
# Powerline fonts
# git clone https://github.com/powerline/fonts.git $HOME/powerline_fonts
# . ~/powerline_fonts/install.sh
# Nerd-Fonts
# git clone https://github.com/ryanoasis/nerd-fonts $HOME/nerd-fonts
# . ~/nerd-fonts/install.sh
git submodule init
git submodule update --init --recursive
# . $HOME/bin/fzf/install
echo "Remember to install direnv"
echo "Linux-> Do a:\n\t sudo apt-get install xclip -> for tmux cp-clipboard compatibility"
echo "Linux-> Do a:\n\t sudo apt-get install exuberant-ctags -> vim tags plugin"
echo "Tmux-> Open tmux and do a C-a + I -> to install tmux plugins"
