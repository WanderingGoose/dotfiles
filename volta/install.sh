#!/usr/bin/env bash

install_volta() {
    curl https://get.volta.sh | bash

    source ~/.zshrc
}

install_node() {
    echo "      -----------------------------------------------------------"
    echo "      Installing Node 12 and 14"
    echo "      -----------------------------------------------------------"
    volta install node@12
    volta install node@14
}

install_yarn() {
    echo "      Installing Yarn"
    volta install yarn@1
}

yarn_global_add() {
    echo "      -----------------------------------------------------------"
    echo "       Yarn Global Add these packages:                          "
    echo "      -----------------------------------------------------------"
    echo ""
    echo "        Installing NX"
    yarn global add nx@latest
    echo "        NX installed successfully"
    echo ""
    echo "      Yarn Global Add completed successfully"
}

echo "==========================================================="
echo "              Setting up NodeJS Environment"
echo "==========================================================="

echo "  🌩️ Checking for Volta installation 🌩️"
if test ! $(which volta); then
    echo "    🌩️ Installing Volta for you."

    install_volta
    install_node
    install_yarn
    yarn_global_add

    echo "    🌩️ Volta, Node, and Yarn installed"
else
    echo "    🌩️ Volta already installed"
fi

echo ""
exit 0
