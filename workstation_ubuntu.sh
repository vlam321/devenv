#!/bin/bash

sudo apt-get update

# helper func to get user input and determine whether
# software should be installed
user_input(){
  printf "install $1? "
  read in
  if [[ $in == "y" || $in == "Y" || $in == "yes" || $in == "Yes" ]]; then
    eval "$2=1"
  fi
}

# install atom editor
user_input "atom" atom_resp
if [[ $atom_resp == 1 ]]; then
  wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  sudo apt-get update
  sudo apt-get install atom
fi

# install docker
user_input "docker" docker_resp
if [[ $docker_resp == 1 ]]; then
  sudo apt-get remove docker docker-engine docker.io containerd runc
  sudo apt-get update
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
fi

# install docker-compose
user_input "docker-compose" docker_compose_resp
if [[ $docker_compose_resp == 1 ]]; then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

# install go
user_input "go" go_resp
if [[ $go_resp == 1 ]]; then
  sudo apt-get install golang-go
fi

# install dep
user_input "dep" dep_resp
if [[ $dep_resp == 1 ]]; then
  sudo apt-get install go-dep
fi

# install autojump
user_input "autojump" autojump_resp
if [[ $autojump_resp == 1 ]]; then
  sudo apt install autojump
  echo "" >> ~/.zshrc
  echo "# autojump" >> ~/.zshrc
  echo ". /usr/share/autojump/autojump.sh" >> ~/.zshrc
fi

# install hub
user_input "hub" hub_resp
if [[ $hub_resp == 1 ]]; then
  sudo add-apt-repository ppa:cpick/hub
  sudo apt-get update
  sudo apt-get install hub
fi

# install thefuck
user_input "thefuck" thefuck_resp
if [[ $thefuck_resp == 1 ]]; then
  sudo apt install python3-dev python3-pip python3-setuptools
  sudo pip3 install thefuck
  echo "" >> ~/.zshrc
  echo "# thefuck" >> ~/.zshrc
  echo 'eval $(thefuck --alias)' >> ~/.zshrc
fi

# install tldr
user_input "tldr" tldr_resp
if [[ $tldr_resp == 1 ]]; then
  sudo apt-get install tldr
fi

# install fzf
user_input "fzf" fzf_resp
if [[ $fzf_resp == 1 ]]; then
  # install linuxbrew
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  brew install fzf
  echo "" >> ~/.zshrc
  echo "# fzf" >> ~/.zshrc
  echo 'alias ff="fzf"' >> ~/.zshrc
fi

# install vscode
user_input "vscode" vscode_resp
if [[ $vscode_resp == 1 ]]; then
    sudo apt install software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
fi

echo "All done here. Don't forget to sauce dat .zshrc!"
