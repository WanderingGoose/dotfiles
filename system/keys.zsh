# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias pubkey-ed="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> ED25519 Public key copied to pasteboard.'"
