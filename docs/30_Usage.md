## Show help

Call the script `bashdoc2md.sh` with the parameter `-h` to see the help.

```txt
       ________________________________________________________________________
______/
         GENERATE BASH HELP AS MARKDOWN                                  ______
________________________________________________________________________/ v0.5

    Author: Axel Hahn
    License: GNU GPL 3.0
    Source: <https://github.com/axelhahn/bashdoc/>
    Docs: <https://www.axel-hahn.de/docs/bashdoc/>


    Parse a bash file, detect its functions and generate a markdown output 
    from its doc blocks.


SYNTAX:

    bashdoc2md.sh [OPTIONS] [BASH SCRIPT]

OPTIONS:

    -h  show this help
    -f  list functions only
    -p  show functions starting with underscore ('private' functions) too

    -l [LEVEL]
        level of starting headline; default: 2; valid numbers: 1..5
    -r [REPOURL]
        url to the git repository without basename of the file to read; 
        default: none
    -s [FUNCTION]
        Show help of a single function only; maybe you wanna call -f first

EXAMPLES:

    bashdoc2md.sh myscript.bash
        show full markdown help for the given script

    bashdoc2md.sh -l 3 -f myscript.bash
        list functions in alphabetic order starting with headline level 3

    bashdoc2md.sh -s myfunction myscript.bash
        show bash doc of the function 'myfunction' of script 'myscript.bash'

________________________________________________________________________
                                                                        \______
```

## Generate a md file

You can have look to the file `scripts/generate_bashdoc.sh`.
This generates the file for all functions.

Copy it to your project and adapt it.
