function rustup_setup() {
  if [[ -d $RUSTUP_HOME && -d $CARGO_HOME ]] ; then
    echo "To update rustup"
    rustup update
  else
    echo "To install rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable
    source $SETUP_CARGO_ENV
    rustup target add wasm32-unknown-unknown
    rustup show
  fi;
}
[[ $2 == 'update' || $2 == 'rustup' ]] && rustup_setup

function rustup_purge() {
  [[ -n $(command -v rustup | grep setup/.cargo) ]] && rustup self uninstall
}
[[ $2 == 'purge' ]] && rustup_purge
