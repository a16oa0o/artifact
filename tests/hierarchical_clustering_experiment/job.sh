#!/bin/bash
#PBS -N hc_test
#PBS -A UCDV0023
#PBS -l walltime=00:30:00
#PBS -q regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=4:mpiprocs=4
#PBS -l inception=login

export TMPDIR=/glade/scratch/$USER/$PWD
rm -rf $TMPDIR/*
mkdir -p $TMPDIR

source ${PROSE_REPO_PATH}/scripts/cheyenne/activate_ROSE.sh

make clean && prose_full.py -s ${PROSE_REPO_PATH}/tests/hierarchical_clustering_experiment/cheyenne/setup_parallel.ini