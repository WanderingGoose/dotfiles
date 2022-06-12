#!/usr/bin/env bash

install_volta() {
    curl https://get.volta.sh | bash

    source ~/.zshrc
}

install_node() {
    echo "      -----------------------------------------------------------"
    echo "      Installing Node 12, 14, 16, and 18"
    echo "      -----------------------------------------------------------"
    volta install node@12
    volta install node@14
    volta install node@16
    volta install node@18
}

install_yarn() {
    echo "      Installing Yarn"
    volta install yarn@1
}

echo "==========================================================="
echo "              Setting up NodeJS Environment"
echo "==========================================================="

echo "  🌩️  Checking for Volta installation 🌩️"
if test ! $(which volta); then
    echo "    🌩️  Installing Volta for you."

    install_volta
    install_node
    install_yarn

    echo "    🌩️  Volta, Node, and Yarn installed"
else
    echo "    🌩️  Volta already installed"
fi

echo ""
exit 0
