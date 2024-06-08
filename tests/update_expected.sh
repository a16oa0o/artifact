#! /bin/bash

for filename in *_test; do
    cd "${filename}"

    if [ -f "./not_implemented" ]; then
        cd ".."
        continue 1
    fi

    rm -rf expected/*
    cp -r prose_workspace/ expected/
    cp -r prose_logs/ expected/
    cd ".."
done

echo "[UPDATED EXPECTED FILES]"