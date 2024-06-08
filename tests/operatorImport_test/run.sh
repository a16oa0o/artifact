#! /bin/bash

# run precimonious search
make clean \
&& prose_dependencies.py -s setup.ini \
&& prose_preprocess.py -s setup.ini \
&& prose_search.py -s setup.ini 