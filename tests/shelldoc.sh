#!/bin/bash
# ------------------------------------------------------------
# I am a test function
# In front of a dummy function I use a comment like shell
# style guide
# ------------------------------------------------------------

PREFIX="Hello"

#### FUNCTION BEGIN
# Prints a greeting
#
# GLOBALS: 
# 	PREFIX
#
# ARGUMENTS: 
# 	Name as a String to use for greeting
#
# OUTPUTS: 
# 	Writes String to STDOUT
#
# RETURN: 
# 	0 if success, non-zero otherwise.
### FUNCTION END
function hello(){
    echo "$PREFIX $1"
}