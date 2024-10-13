#!/bin/bash

# ------------------------------------------------------------
# I am a test function
# In front of a dummy function I use a comment closer to
# php doc like
# ------------------------------------------------------------

PREFIX="Hello"

# Prints a greeting.
# It uses a global var for a prefix.
#
# TODO: add optional param
# see   https://github.com/axelhahn/bashdoc/issues/3 maybe somewhere else
#
# global  PREFIX  string  prefix before name
#
# param  string  Name to use for greeting
#
# return  0 if success, non-zero otherwise.
### FUNCTION END
function hello(){
    echo "$PREFIX $1"
}