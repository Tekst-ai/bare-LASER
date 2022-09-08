#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.
#
# LASER  Language-Agnostic SEntence Representations
# is a toolkit to calculate multilingual sentence embeddings
# and to use them for document classification, bitext filtering
# and mining
#
# --------------------------------------------------------
#
# bash script to calculate sentence embeddings for arbitrary
# text file

#############################
# BEGIN PARAMETERS TO SET
#############################
# location of models (e.g. /path/to/models); no trailing slash
model_dir=/app/LASER/models

# version number for LASER3 models
version=1
#############################
# END PARAMETERS TO SET
#############################

if [ -z ${model_dir} ]; then
    echo "Please set model directory within script"
    exit 1
elif [ ! -d ${model_dir} ]; then
    echo "Can't find model directory: $model_dir"
    exit 1
fi

if [ -z ${LASER} ] ; then
  echo "Please set the environment variable 'LASER'"
  exit 1
fi

if [ $# -lt 2 ] ; then
  echo "usage: embed.sh input-file output-file [language]"
  exit 1
fi

infile=$1
outfile=$2
language=$3

encoder="${model_dir}/bilstm.93langs.2018-12-26.pt"
bpe_codes="${model_dir}/93langs.fcodes"


if [[ ! -s $model_file ]]; then
    echo "couldn't find model file: $model_file"
    exit 1
fi

if [[ ! -s $spm ]]; then
    echo "couldn't find spm: $spm"
    exit 1
fi

cat $ifile \
  | python3 ${LASER}/source/embed.py \
    --encoder ${encoder} \
    --token-lang ${lang} \
    --bpe-codes ${bpe_codes} \
    --output ${ofile} \
    --verbose
