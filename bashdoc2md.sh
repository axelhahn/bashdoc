#!/bin/bash
# ======================================================================
#
# BASHDOC 2 MARKDOWN
# Bash parser to find functions and their doc blocks
#
# ----------------------------------------------------------------------
# Author: Axel Hahn
# License: GNU GPL 3.0
# Source: <https://github.com/axelhahn/bashdoc/>
# Docs: <https://www.axel-hahn.de/docs/bashdoc/>
# ----------------------------------------------------------------------
# 2022-09-26  v0.1  axel hahn  first lines
# 2022-10-14  v0.2  axel hahn  add param support; show a help
# 2023-08-21  v0.3  axel hahn  finish option "-s"; add option "-p" 
# 2024-03-28  v0.4  axel hahn  add option -r
# 2024-10-09  v0.5  axel hahn  add urls to source and docs
# 2024-10-10  v0.6  axel hahn  handle doc blocks with beginning spaces
# 2024-10-13  v0.7  axel hahn  extend bashdoc detection
# ======================================================================

APPVERSION=0.7

PARSED_SCRIPT=
PARSED_FUNCTION=
PARSED_LINE=
PARSED_DOC=

SHOWPRIVATE=0
REPOURL=

ICO_GLOBAL="🌐 "
ICO_OUTPUT="🗨️ "
ICO_PARAM="🟩 "
ICO_PARAM_OPT="🔹 "
ICO_SEE="👉🏼 "
ICO_TODO="📌 "
ICO_RETURN="🏁 "

# ----------------------------------------------------------------------
# INTERNAL FUNCTIONS
# ----------------------------------------------------------------------

# Set markdown prefix for headlines of script name and function.
# It returns nothing.
#
# global  string  PREFIX_SCRIPT    prefix string for headline with script
# global  string  PREFIX_FUNCTION  prefix string for headline with function name
#
# param  integer  number of hashes; eg. 2
_setH(){
    typeset -i iHStart=$1
    local sTmp; sTmp=$( seq 1 ${iHStart} )
    PREFIX_SCRIPT=$( printf -- '#%.0s' $sTmp ) # do not quote $sTmp
    PREFIX_FUNCTION="${PREFIX_SCRIPT}#"
}

# Find functions with short syntax "<function_name> ()" in given script.
# It returns lines [LINE]:[FUNCTION_NAME]
#
# param  string  scriptname to parse
# return string
_getShortFunctions(){
    grep -in '[a-z0-9\-\._][a-z0-9\-\._]* *()' "$1" | cut -f 1 -d '('| grep -v '[\$\"\;\#]' | sed "s#function ##g" | tr -d ' '
}

# Find functions with long syntax "function <function_name>" in given script.
# it returns lines [LINE]:[FUNCTION_NAME].
#
# param  string  scriptname to parse
# return string
_getLongFunctions(){
       grep -in '^[ /t]*function [a-z0-9\-\._][a-z0-9\-\._]*' "$1" | cut -f 1 -d '('| sed "s#function ##g" | tr -d ' '
}

# ----------------------------------------------------------------------
# PUBLIC FUNCTIONS
# ----------------------------------------------------------------------


# Find all functions with long and short and create a uniq list 
# it returns lines [LINE]:[FUNCTION_NAME]. It is called by
#
# see getbashdoc()
#
# global  string  PARSED_SCRIPT    nane of the bash script to parse
#
# param  string  scriptname to parse
# return string
getFunctions(){
    local _out=$( 
        (
        _getShortFunctions "$PARSED_SCRIPT"
        _getLongFunctions "$PARSED_SCRIPT"
        ) | grep -v '[\$\"\;\#]' 
    )
    test $SHOWPRIVATE -eq 0 && _out=$( grep -v "[:\.]_" <<< "$_out" )
    echo "$_out" | sort -u -t ':' -k 2
}

# Get markdown header: header in set level and name of script
#
# global  string  PARSED_SCRIPT    nane of the bash script to parse
# global  string  PREFIX_SCRIPT    prefix string for headline with script
#
# return string
getHeader(){
    echo "${PREFIX_SCRIPT} $( basename "${PARSED_SCRIPT}" )"
    echo
}

# Parse a section for a given single function
# and set global variables. It is called by
#
# see getbashdoc()
#
# global  string  PARSED_FUNCTION  nane of the function
# global  string  PARSED_LINE      line number
# global  string  PARSED_DOC       doc block of the current function
#
# param  string   file to parse
# param  string   starting line with [LINE]:[FUNCTION_NAME]
parseFunction(){
    local _script="${1}"
    local fktline="${2}"
    local _linestart; typeset -i _linestart
    local _iLine;     typeset -i _iLine
    local _doc

        _linestart=$( echo "$fktline" | cut -f 1 -d ':' )
        fktname=$( echo "$fktline" | cut -f 2 -d ':' )

        _iLine=$_linestart-1
        
        _doc=$(
            while [ $_iLine -gt 0 ]; do
                line="$( sed -n ${_iLine},${_iLine}p $_script )"
                if echo "$line" | grep '^[ /t]*#' >/dev/null
                then
                    echo "$line"
                    _iLine=$_iLine-1
                else
                    _iLine=0
                fi
            done | tac
        )

        # set global vars/ return data
        PARSED_FUNCTION="$fktname"
        PARSED_LINE="$_linestart"
        PARSED_DOC="$_doc"       
}

# Parse the doc block of a given function and show description, params, see 
# and global. It is called by
#
# global  ICO_GLOBAL     icon
# global  ICO_OUTPUT     icon
# global  ICO_PARAM      icon
# global  ICO_PARAM_OPT  icon
# global  ICO_SEE        icon
# global  ICO_TODO       icon
# global  ICO_RETURN     icon
#
# see getbashdoc()
#
# global  string  PARSED_DOC  doc block of the current function
parseDocBlock(){
    local _icon;
    test -n "$PARSED_DOC" && (
        # echo -n "<html><pre><code class=\"language-txt bashdoc\">"      
        echo '```txt'
        IFS=
        echo "$PARSED_DOC" \
            | sed "s#^[[:space:]]*\###g" \
            | sed "s#^[[:space:]]##g" \
            | grep -vE -- "[\-\.\=\_\#\*]{5}" \
            | grep -viE "FUNCTION (BEGIN|END)" \
            | while read -r line
        do
            _icon=""

            # --- Shell DOC blocks for a function
            grep -qi "^globals:"          <<< "$line" && _icon="${ICO_GLOBAL}"
            grep -qi "^arguments:"        <<< "$line" && _icon="${ICO_PARAM}"
            grep -qi "^outputs:"          <<< "$line" && _icon="${ICO_OUTPUT}"
            grep -qi "^return:"           <<< "$line" && _icon="${ICO_RETURN}"
            grep -qi "^returns:"          <<< "$line" && _icon="${ICO_RETURN}"

            # --- PHP DOC like syntax
            grep -qi "^global[[:space:]]" <<< "$line" && _icon="${ICO_GLOBAL}"
            grep -qi "^return[[:space:]]" <<< "$line" && _icon="${ICO_RETURN}"

            # params: detect optional parameters
            if grep -qi "^param[[:space:]]" <<< "$line"; then
                _icon="${ICO_PARAM}"
                local _descr;
                _descr=$( awk '{$1=$2=""; print $0 }' <<< "$line" | sed "s#^[[:space:]]*##" )
                grep -qi "optional:" <<< "$_descr" && _icon="${ICO_PARAM_OPT}"
            fi

            # --- PHP DOC like syntax
            grep -qi "^see[\ :]"              <<< "$line" && _icon="${ICO_SEE}"
            grep -qi "^todo[\ :]"             <<< "$line" && _icon="${ICO_TODO}"
            
            echo "${_icon}${line}"
        done
        echo '```'
        echo
    )
}

# Main function: parse given script and show markdown for all functions
# It calls functions for atomar actions
#
# see getFunctions()
# see parseFunction()
# see parseDocblock()
#
# global  string  PARSED_SCRIPT    nane of the bash script to parse
# global  string  PARSED_FUNCTION  nane of the function
# global  string  PARSED_LINE      line number
# global  string  PARSED_DOC       doc block of the current function
# global  string  PREFIX_FUNCTION  prefix string for headline with function name
# global  string  REPOURL          Source code URL
getbashdoc() {

    local _script=
    if [ -n "${REPOURL}" ]; then
        _script="$( basename ${PARSED_SCRIPT} )"
    fi
    getFunctions "$PARSED_SCRIPT" | while read -r fktline
    do 

        parseFunction "$PARSED_SCRIPT" "$fktline"
        echo "${PREFIX_FUNCTION} ${PARSED_FUNCTION}()"
        echo
        parseDocBlock
        if [ -n "${REPOURL}" ]; then
            echo "[line: $PARSED_LINE](${REPOURL}${_script}#L$PARSED_LINE)"
        else
            echo "line: $PARSED_LINE"
        fi
        echo
    done
    echo "- - -"
    echo "Generated with [Bashdoc](https://github.com/axelhahn/bashdoc) v$APPVERSION"
}

# Set a bash script to parse
# It sets the global variable.
#
# global string  PARSED_SCRIPT  nane of the function
#
# param  string  filename of bash script to parse
setScript(){
    PARSED_SCRIPT=$1
    if [ ! -r "$PARSED_SCRIPT" ]; then
        echo "ERROR: file $PARSED_SCRIPT cannot be read."
        exit 1
    fi
    if ! head -1 "$PARSED_SCRIPT" | grep "^#!" | grep "sh" >/dev/null; then
        echo "ERROR: the 1st line of file [$PARSED_SCRIPT] does not contain a shebang with bash"
        echo -n "FOUND: "
        head -1 "$PARSED_SCRIPT"
        exit 1
    fi
}

# Show help with all cli parameters
showHelp(){
    _self=$( basename $0 )
    echo "       ________________________________________________________________________
______/
         GENERATE BASH HELP AS MARKDOWN                                  ______
________________________________________________________________________/ v$APPVERSION

    Author: Axel Hahn
    License: GNU GPL 3.0
    Source: <https://github.com/axelhahn/bashdoc/>
    Docs: <https://www.axel-hahn.de/docs/bashdoc/>


    Parse a bash file, detect its functions and generate a markdown output 
    from its doc blocks.


SYNTAX:

    $_self [OPTIONS] [BASH SCRIPT]

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

    $_self myscript.bash
        show full markdown help for the given script

    $_self -l 3 -f myscript.bash
        list functions in alphabetic order starting with headline level 3

    $_self -s myfunction myscript.bash
        show bash doc of the function 'myfunction' of script 'myscript.bash'

________________________________________________________________________
                                                                        \______
"
}
# ----------------------------------------------------------------------
# MAIN
# ----------------------------------------------------------------------

ACTION=showmarkdown
typeset -i HLEVEL=2
FUNCTION=

# ----- parse cli params

while getopts ":h :f :p :l: :r: :s:" OPT; do
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`

  fi

  case "$OPT" in
    # ----- HELP
    h) showHelp; exit 0; ;;

    # ----- REAL ACTIONS
    f) ACTION="listfunctions";;
    p) SHOWPRIVATE=1 ;;
    l) HLEVEL="${OPTARG}";;
    r) REPOURL="${OPTARG}";;

    s) FUNCTION="${OPTARG}"; ACTION="showfunction";;
  esac
done
shift $((OPTIND - 1))

if [ -z "$1" ]; then
    echo "ERROR: missing param with bash script to parse"
    showHelp
    exit 1  
fi

# ----- Init

setScript "$1"
_setH $HLEVEL

# ----- Start

case $ACTION in
    listfunctions)
        getHeader
        echo "${PREFIX_FUNCTION} functions"; echo
        getFunctions | cut -f 2- -d ":" | sed "s#^#* #g" 
        echo
        ;;
    showfunction)
        getHeader
        echo "${PREFIX_FUNCTION} function $FUNCTION"; echo

        parseFunction "$PARSED_SCRIPT" "$( getFunctions | grep $FUNCTION )"
        echo "\`\`\`txt"
        echo "$PARSED_DOC"
        echo "\`\`\`"
        echo
        ;;
    showmarkdown)
        getHeader
        echo "List of all functions in alphabetic order"
        echo
        getbashdoc
        ;;
    *)
        echo "Ooops ... action $ACTION is unknown"
        exit 1;
esac
# ----------------------------------------------------------------------
