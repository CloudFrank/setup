export NVM_DIR=$SETUP_HOME/.nvm

function loads_nvm() {
  # This loads nvm
  export NVM_SH=$NVM_DIR/nvm.sh
  [[ -s $NVM_SH ]] && source $NVM_SH

  # This loads nvm bash_completion
  export NVM_BASH_COMPLETION=$NVM_DIR/bash_completion
  [[ -s $NVM_BASH_COMPLETION ]] && source $NVM_BASH_COMPLETION
}

if [[ -z $GREP_SETUP ]] ; then
  loads_nvm
fi;

if [[ -n $GREP_SETUP ]] ; then
  export NVM_SETUP_SH=$SETUP_NVM/setup.sh
  if [[ $2 == 'update' ]] || [[ $2 == 'nvm' ]] ; then
    export -f loads_nvm
    source_sh $NVM_SETUP_SH $2
  fi;
  if [[ $2 == 'purge' ]] ; then
    if [[ $3 == 'nvm' ]] || (( $# == 2 )) ; then
      source_sh $NVM_SETUP_SH $2
    fi;
  fi;
fi;
