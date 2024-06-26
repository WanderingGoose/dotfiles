## NX ##
alias nxbaa="pnpm exec nx run-many --target=build --all"
alias nxb="pnpm exec nx build"
alias nxba="pnpm exec nx run-many --target=build --all=true --parallel=6 --skip-nx-cache=true"
alias nxta="pnpm exec nx run-many --target=test --parallel=true --maxParallel=6 --all=true --skip-nx-cache=true"
alias nxt="pnpm exec nx test"
alias nxbta="nxba && nxta"
alias nxaddlib="pnpm exec nx g @nrwl/workspace:lib"
alias nxml="pnpm exec nx migrate latest"
alias nxrm="pnpm exec nx migrate --run-migrations"
