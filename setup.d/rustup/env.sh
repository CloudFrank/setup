export RUSTUP_HOME="$SETUP_HOME/.rustup"
export CARGO_HOME="$SETUP_HOME/.cargo"
export SETUP_CARGO_ENV="$CARGO_HOME/env"

function loads_rustup() {
  if [[ -s $SETUP_CARGO_ENV && -z $(echo $PATH | grep setup/.cargo) ]] ; then
    source $SETUP_CARGO_ENV
  fi;
}
loads_rustup

if [[ -n $GREP_SETUP ]] ; then
  export RUSTUP_SETUP_SH=$SETUP_RUSTUP/setup.sh
  if [[ $2 == 'update' ]] || [[ $2 == 'rustup' ]] ; then
    source_sh $RUSTUP_SETUP_SH $2
  fi;
  if [[ $2 == 'purge' ]] ; then
    if [[ $3 == 'rustup' ]] || (( $# == 2 )) ; then
      source_sh $RUSTUP_SETUP_SH $2
    fi;
  fi;
fi;
