#! /bin/bash

error=$((0))

if [ -z "$1" ]; then
    echo "No platform specified; usage: ./run_tests.sh [docker|cheyenne]"
    exit 1
fi

if [ "$1" == "cheyenne" ]; then
    source ../scripts/cheyenne/activate_ROSE.sh
fi

for filename in *_test; do
    cd "${filename}"
    echo ""
    echo "===== ${filename} ====="
    if [ -f "./not_implemented" ]; then
    echo
        echo "** not implemented"
        cd ".."
        continue 1
    fi
    ./run.sh $1 > /dev/null 2>&1
    ./check.sh
    ((error = error || $? ))
    cd ".."
done

echo ""
if [ "${error}" -eq 0 ]; then
    echo "[ALL TESTS PASSED]"
    exit 0
else
    echo "[ERRORS/FAILURES OBSERVED]"
    exit 1
fi