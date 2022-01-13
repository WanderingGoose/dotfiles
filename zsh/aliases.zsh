# ALIASES #
###########
alias cls='clear' # Good 'ol Clear Screen command

## NX ##
alias baa="nx run-many --target=build --all"
alias nxb="nx build"
alias nxta="nx run-many --target=test --all"
alias nxt="nx test"
alias nxbta="baa && nxta"
alias nxaddlib="nx g @nrwl/workspace:lib"
alias nxml="nx migrate latest"
alias nxrm="nx migrate --run-migrations"
