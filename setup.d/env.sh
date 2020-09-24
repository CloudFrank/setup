function source_sh() {
  [[ -s $1 ]] && source $1 $@
}

export -f source_sh

export GREP_SETUP=$(echo $0 | grep setup)

export SETUP_NVM=$SETUP_D/nvm
export NVM_ENV_SH=$SETUP_NVM/env.sh

export SETUP_RUSTUP=$SETUP_D/rustup
export RUSTUP_ENV_SH=$SETUP_RUSTUP/env.sh

if [[ $1 == 'purge' ]] ; then
  source_sh $RUSTUP_ENV_SH $@
  source_sh $NVM_ENV_SH $@
else
  source_sh $NVM_ENV_SH $@
  source_sh $RUSTUP_ENV_SH $@
fi;
