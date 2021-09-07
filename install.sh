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
setup-omz
install-nodejs
zshrc
upgrade-packages
finish
