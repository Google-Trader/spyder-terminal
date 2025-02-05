#!/bin/bash -ex

# -- Install Miniconda
MINICONDA=Miniconda3-latest-Linux-x86_64.sh
wget https://repo.continuum.io/miniconda/$MINICONDA -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source $HOME/miniconda/etc/profile.d/conda.sh

# -- Make new conda environment with required Python version
conda create -y -n test python=$PYTHON_VERSION
conda activate test

# Install dependencies
conda install -q -y -c conda-forge --file requirements/conda.txt

# Install test dependencies
conda install -q -y -c conda-forge --file requirements/tests.txt

# Update to latest version of nodejs using nvm
export NVM_DIR="/opt/circleci/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install v13.10.1

# -- Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
export PATH="$PATH:/opt/yarn-1.17.3/bin"

pip install -q codecov
