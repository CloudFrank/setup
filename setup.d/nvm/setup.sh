function nvm_setup() {
  if [[ -d $NVM_DIR ]] ; then
    echo "To update nvm"
    cd "$NVM_DIR"
    git fetch --tags origin
  else
    echo "To install nvm"
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
  fi;
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  cd - > /dev/null
}

function node_setup() {
  export NVM_NODEJS_ORG_MIRROR=https://nodejs.org/dist
  nvm install node
  nvm alias default node
}

function ln_setup() {
  SETUP_NPM_BIN=$(npm bin --global)
  ln -snf $SETUP_HOME/setup.sh $SETUP_NPM_BIN/setup
}

if [[ $2 == 'update' || $2 == 'nvm' ]] ; then
  nvm_setup
  loads_nvm
  node_setup
  ln_setup
fi;

function nvm_purge() {
  rm -rf $NVM_DIR
  rm -rf $SETUP_RC
}
[[ $2 == 'purge' ]] && nvm_purge
