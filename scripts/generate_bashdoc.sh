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
    echo "--- $(basename "$SOURCE")"
    TARGET="$TARGETBASE/$(basename "$SOURCE").md"
    if [ "$TARGET" -nt "$SOURCE" ] && [ "$TARGET" -nt "$BASHDOC" ]; then
        echo "SKIP: $TARGET is up to date."
    else
        rm -f "$TARGET"
        echo "Generating $TARGET ... "
        if $BASHDOC -l 2 -r "$REPO" "$SOURCE" > "$TARGET.tmp"; then
            mv "$TARGET.tmp" "$TARGET"
            echo "OK, generation was successful."
        else
            rm -f "$TARGET.tmp"
            echo "Error: Generation failed."
        fi
    fi
    ls -l "$SOURCE" "$TARGET"
    echo
done
echo "Done."
