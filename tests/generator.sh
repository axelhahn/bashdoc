#!/bin/bash

cd "$( dirname "$0" )" || exit

REPO="https://github.com/axelhahn/bashdoc/blob/main/tests/"

../bashdoc2md.sh -l 1 -r "$REPO" "shelldoc.sh"   > "shelldoc.sh.md"
../bashdoc2md.sh -l 1 -r "$REPO" "phpdoclike.sh" > "phpdoclike.sh.md"

