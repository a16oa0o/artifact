#!/bin/bash
for dir in $(find . -maxdepth 1 -mindepth 1 -type d)
do
    make -C "${dir}" clean
done