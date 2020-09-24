#!/usr/bin/env bash

function source_setup_rc() {
  export SETUP_RC=$HOME/.setuprc
  echo 'export SETUP_RC=$HOME/.setuprc' > $SETUP_RC
  export SETUP_HOME=`dirname $(readlink -f $0)`
  echo "export SETUP_HOME=$SETUP_HOME" >> $SETUP_RC
  echo 'export SETUP_D=$SETUP_HOME/setup.d' >> $SETUP_RC
  echo 'export SETUP_ENV=$SETUP_D/env.sh' >> $SETUP_RC
  echo '[[ -s $SETUP_ENV ]] && source $SETUP_ENV' >> $SETUP_RC
  [[ -s $SETUP_RC ]] && source $SETUP_RC $@
}

function loads_setup() {
  export HOME_PROFILE=$HOME/.profile
  ENV_SETUP_RC='SETUP_RC=$HOME/.setuprc'
  if [[ $(sed -n "/SETUP_RC=/p" $HOME_PROFILE) != $ENV_SETUP_RC ]] ; then
    echo 'loads setup'
    echo '# include .setuprc if it exists' >> $HOME_PROFILE
    echo $ENV_SETUP_RC >> $HOME_PROFILE
    echo '[[ -s $SETUP_RC ]] && source $SETUP_RC' >> $HOME_PROFILE
  fi;
}

function tip_run_it() {
  echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  echo 'To activate the new version of .setuprc in any new shell just run it: '
  echo ' $ source $HOME/.setuprc'
  echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
}

function main() {
  SETUP_HOME_MAIN=$SETUP_HOME/main.js
  node  --trace-warnings --experimental-wasm-modules --experimental-json-modules $SETUP_HOME_MAIN $*
}

if (( $# != 0 )) || [[ -z $(command -v node | grep setup/.nvm) ]] ; then
  source_setup_rc $@
  loads_setup
fi;

tip_run_it

if [[ -n $(command -v node | grep setup/.nvm) ]] ; then
  main
fi;
