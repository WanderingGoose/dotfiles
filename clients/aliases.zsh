## Frame Draggers Unionworks
alias @fdu="cd ~/source/frame-draggers-union"
alias @fdu:affected="@fdu && @fdu:build && @fdu:test"
alias @fdu:build="@fdu && pnpm build"
alias @fdu:test="@fdu && pnpm test"
alias @fdu:serve="@fdu && pnpm serve"

## Panda
alias @panda="cd ~/source/panda"
alias @panda:affected="@panda && pnpm build && pnpm test"
