#!/bin/bash


PYTHON_ENVIRONMENT=contentvec-env

cwd=$(pwd)
FAIRSEQ=${cwd}/fairseq/fairseq
CODE=${cwd}

python -m venv .${PYTHON_ENVIRONMENT}

source .${PYTHON_ENVIRONMENT}/bin/activate
    
git clone https://github.com/pytorch/fairseq.git --branch main --single-branch
cd ${cwd}/fairseq
    # checkout the fairseq version to use
git reset --hard 0b21875e45f332bedbcc0617dcf9379d3c03855f

python -m pip install --editable ./

python -m pip install scipy
python -m pip install soundfile
python -m pip install praat-parselmouth
python -m pip install tensorboardX
pip install numpy==1.23.3
    
cd ${cwd}

rsync -a contentvec/ fairseq/fairseq/
