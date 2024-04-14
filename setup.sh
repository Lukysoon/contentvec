#!/bin/bash


PYTHON_ENVIRONMENT=contentvec
CONDA_ROOT=/root/anaconda3

source ${CONDA_ROOT}/etc/profile.d/conda.sh

cwd=$(pwd)
FAIRSEQ=${cwd}/fairseq/fairseq
CODE=${cwd}

echo "Stage 0: Install conda environment..."
    
conda create --name ${PYTHON_ENVIRONMENT} python=3.7 -y


conda activate ${PYTHON_ENVIRONMENT}

echo "Stage 1: Install fairseq and other dependencies..."
    
git clone https://github.com/pytorch/fairseq.git --branch main --single-branch
cd ${cwd}/fairseq
    # checkout the fairseq version to use
git reset --hard 0b21875e45f332bedbcc0617dcf9379d3c03855f

echo "Install fairseq..."
python -m pip install --editable ./

apt update
apt install rsync -y
python -m pip install scipy
python -m pip install soundfile
python -m pip install praat-parselmouth
python -m pip install tensorboardX
    
cd ${cwd}

echo "Stage 2: Copy model files to fairseq..."
rsync -a contentvec/ fairseq/fairseq/
