#!/bin/bash

export USERNAME=`whoami`

alecEnvVersion="VSCode Codespaces"

start() {
    clear
    echo ""
    echo "==========================================================="
    echo "==========================================================="
    echo "                                    !! ATTENTION !!"
    echo "YOU ARE SETTING UP: Alec's Environment (${alecEnvVersion})"
    echo "==========================================================="
    echo ""
    echo -n "* The setup will begin in 5 seconds... "
    sleep 5
    echo -n "Times up! Here we start!"
    echo ""

    cd $HOME
}

install-fonts() {
  mkdir -p ~/.fonts
  cd ~/.fonts
  echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
  sh -c "$(wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip)"
  unzip FiraCode.zip -d ~/.fonts
  fc-cache -fv
}

setup-omz() {
    echo "==========================================================="
    echo "                      Shells Enviroment"
    echo "-----------------------------------------------------------"

    install-starship() {
        echo "-----------------------------------------------------------"
        echo "* Installing Starship:"
        echo "-----------------------------------------------------------"
        sh -c "$(curl -fsSL https://starship.rs/install.sh)"  -- -y

        cp ~/dotfiles/.config/starship.toml
    }

    setup-zsh() {
        echo "* Installing ZSH Custom Plugins & Themes:"
        echo ""
        echo "  - zsh-autosuggestions"
        echo "  - zsh-syntax-highlighting"
        echo "-----------------------------------------------------------"
        cp ~/dotfiles/zsh-config/zsh_plugins.txt ~/.zsh_plugins.txt
    }

    setup-zsh
    install-starship
}

install-nodejs() {
    install-volta() {
      sh -c "$(curl -fsSL https://get.volta.sh)"  -- -y
    }
    install-node() {
        echo "-----------------------------------------------------------"
        echo "* Installing Node 12 and 14"
        echo "-----------------------------------------------------------"
        volta install node@12
        volta install node@14
    }

    install-yarn() {
        volta install yarn@1
    }

    yarn-global-add() {
        echo "-----------------------------------------------------------"
        echo "* Yarn Global Add those packages:"
        echo "-----------------------------------------------------------"
        yarn global add nx@latest
    }


    echo "==========================================================="
    echo "              Setting up NodeJS Environment"

    install-volta
    install-node
    install-yarn
    yarn-global-add
}

zshrc() {
    echo "==========================================================="
    echo "                            Import zshrc                              "
    echo "-----------------------------------------------------------"
    cd $HOME/dotfiles

    cp ~/dotfiles/zsh-config/.aliases.zsh ~/.aliases.zsh
    cp -f ~/dotfiles/zsh-config/.zshrc ~/.zshrc
    chsh -s /usr/bin/zsh $USERNAME
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    echo "source $PWD/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
}

upgrade-packages() {
    echo "==========================================================="
    echo "                      Upgrade packages                     "
    echo "-----------------------------------------------------------"

    sudo apt-get update && sudo apt-get upgrade -y

    # Cleanup
    sudo apt-get autoremove -y
    sudo apt-get autoremove -y
    sudo rm -rf /var/lib/apt/lists/*
}

finish() {
    echo "==========================================================="
    echo "Completed setting up Dotfiles"
    echo "==========================================================="
}

start
install-fonts
setup-omz
install-nodejs
zshrc
upgrade-packages
finish
