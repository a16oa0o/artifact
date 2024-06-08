#! /bin/bash

FAIL=false

function check() {
    MATCHES=$(find -ipath "$1" | wc -l)
    if [ "${MATCHES}" -eq 2 ]; then
        DIFF=$(find -ipath "$1" | xargs grep -Fxv -f)
        if [ "${DIFF}" != "" ]; then
            FAIL=true
            echo "** [FAIL] $1"
            find -ipath "$1" | sort -d | xargs diff -y
            return 1
        else
            echo "** [PASS] $1"
            return 0                
        fi      
    else
        FAIL=true
        echo "** [ERROR] missing logs!"
        return 2
    fi
}

check "*config.txt"
if [ "${?}" -eq 1 ]; then
    echo "    prose_preprocess.py did not target the expected variables."
fi

check "*searchLog.txt"
if [ "${?}" -eq 1 ]; then
    echo "    prose_search.py did not construct the expected search tree."
fi

check "*001*target_module.f90"
if [ "${?}" -eq 1 ]; then
    echo "    prose_search.py did not apply transformations to the target module as expected."
fi

if [ "${FAIL}" = "false" ]; then
    exit 0
else
    exit 1
fi