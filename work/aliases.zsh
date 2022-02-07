if [ -d "$PROJECTS/work/salucro.react" ]; then
  ## Commands ##
  alias getallv4="cd ~/source/work && ./get-latest-all.sh"

  ## PPv4 ##
  alias ppv4="cd ~/source/work/patient-portal-reactor/source"
  alias pp4code="ppv4 && code ."

  ## Salucro React Monorepo ##
  alias smono="cd ~/source/work/salucro-react/salucro"

  ## Laradock && Docker ##
  alias lara="cd ~/source/work/salucro.laradock"
  alias dcus="cd ~/source/work/salucro.laradock && docker-compose up -d --build"
  alias dcd="docker-compose down"
  alias dcps="docker-compose ps"
  alias dprune="docker system prune --all --force --volumes"
  alias dcew="docker-compose exec workspace bash"
  alias dcen="docker-compose exec nginx bash"
  alias dclemur="docker-compose up -d --build redis phpredisadmin nats"
  alias ws-migrate="cd ~/source/work/salucro.laradock; docker-compose exec workspace bash -c 'cd salucro.laradock; make workspace-migrate'"
  alias ws-compose="cd ~/source/work/salucro.laradock; docker-compose exec workspace bash -c 'cd salucro.laradock; make workspace-composer-install'"
  alias wsall="ws-migrate && ws-compose"
  alias v4update="getallv4 && wsall"

  ## SAPI
  alias sapi="cd ~/source/work/sapi"
  alias scode="cd ~/source/work/sapi && code ."

  ## Go ##
  alias sog="cd ~/go/src/salucro.go"
  alias sogdc="docker-compose up -d --build nats memcached"

  ## React Monorepo && Docker ##
  alias rmono="cd ~/source/work/react-monorepo"
  alias dock-sal="cd ~/source/work/docker-salucro.com"
  alias dock-sal-up="dock-sal && dcd && docker-compose up -d --build apache2 mysql workspace cache sftp nats go weasel"

  ## Batch Check Scanner
  alias bcss="cd ~/source/work/salucro-panini-batch/src"
  alias bmui="cd ~/source/work/salucro-panini-batch/metrics/Salucro.ParaScript.Metrics.UI"

  ## Salucro
  alias scom="cd ~/source/work/salucro.com"

  ## SSH ##
  alias sshdev="ssh dev -N"

  ## Hosted Payment Page ##
  alias hpp="cd ~/source/work/hosted-payment-page"

  ## FETG ##
  alias fetg="cd ~/source/work/fetg"
  alias fetg-nx="cd ~/source/work/fetg/NX"
  alias fetg-nx-salucro="cd ~/source/work/fetg/NX/salucro"

  ## Salucro NX monorepo ##
  alias nxmono="cd ~/source/work/salucro-react/salucro"

fi
