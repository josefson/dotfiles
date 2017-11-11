# git 3rd party tools
git clone https://github.com/rupa/z.git $HOME/bin/z
git clone https://github.com/kennethreitz/autoenv.git $HOME/bin/autoenv
git clone https://github.com/sunaku/dasht.git $HOME/bin/dasht
git clone https://github.com/junegunn/fzf.git $HOME/bin/fzf
git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $HOME/.pyenv/plugins/pyenv-virtualenvwrapper
git clone https://github.com/powerline/fonts.git $HOME/powerline_fonts
git submodule init
git submodule update --init --recursive
echo "Linux-> Do a:\n\t sudo apt-get install xclip -> for tmux cp-clipboard compatibility"
echo "Linux-> Do a:\n\t sudo apt-get install exuberant-ctags -> vim tags plugin"
echo "Tmux-> Open tmux and do a C-a + I -> to install tmux plugins"
echo "cd powerline_fonts and ./install.sh"
. $HOME/bin/fzf/install
