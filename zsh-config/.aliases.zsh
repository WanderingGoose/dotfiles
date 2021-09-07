# ALIASES #
###########

## NX ##
alias baa="nx run-many --target=build --all"
alias nxb="nx build"
alias nxta="nx run-many --target=test --all"
alias nxt="nx test"
alias nxbta="baa && nxta"
alias nxaddlib="nx g @nrwl/workspace:lib"