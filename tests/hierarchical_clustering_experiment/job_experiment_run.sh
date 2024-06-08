#!/bin/bash
#PBS -N hc_test_subjob
#PBS -A UCDV0023
#PBS -l walltime=00:01:00
#PBS -q regular
#PBS -j oe
#PBS -k eod
#PBS -l select=1:ncpus=4:mpiprocs=4
#PBS -l inception=login

export PROSE_REPO_PATH=/glade/u/home/dmiao/prose/precimonious-w-rose
export TMPDIR=/glade/scratch/$USER/temp/hc
mkdir -p $TMPDIR

source ${PROSE_REPO_PATH}/scripts/cheyenne/activate_ROSE.sh

./main 1> stdout.txt 2> stderr.txt
touch ./job_done