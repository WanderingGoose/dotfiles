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

install-nodejs