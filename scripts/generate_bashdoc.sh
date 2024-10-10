#!/bin/bash

cd "$( dirname "$0" )" || exit

BASHDOC=./../bashdoc2md.sh

SOURCES=./../bashdoc2md.sh
TARGETBASE=./../docs/99_Functions/
REPO=https://github.com/axelhahn/bashdoc/blob/main/


echo
echo "GENERATE MARKDOWN DOCS"
echo

for SOURCE in $SOURCES
do
    TARGET="$TARGETBASE/$(basename "$SOURCE").md"
    if [ "$TARGET" -nt "$SOURCE" ] && [ "$TARGET" -nt "$BASHDOC" ]; then
        echo "SKIP: $TARGET is up to date."
    else
        rm -f "$TARGET"
        echo "Generating $TARGET ... "
        $BASHDOC -l 2 -r "$REPO" "$SOURCE" > "$TARGET"
    fi
    ls -l "$SOURCE" "$TARGET"
    echo
done
echo "Done."
