## bashdoc2md.sh

List of all functions in alphabetic order

### getFunctions()

```txt
Find all functions with long and short and create a uniq list
it returns lines [LINE]:[FUNCTION_NAME]

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse

🟩 param  string  scriptname to parse
return string
```

[line: 79](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L79)

### getHeader()

```txt
Get markdown header: header in set level and name of script

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse
🌐 global  string  PREFIX_SCRIPT    prefix string for headline with script

return string
```

[line: 96](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L96)

### getbashdoc()

```txt
Main function: parse given script and show markdown for all functions

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse
🌐 global  string  PARSED_FUNCTION  nane of the function
🌐 global  string  PARSED_LINE      line number
🌐 global  string  PARSED_DOC       doc block of the current function
🌐 global  string  PREFIX_FUNCTION  prefix string for headline with function name
🌐 global  string  REPOURL          Source code URL
```

[line: 178](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L178)

### parseDocBlock()

```txt
Parse the doc block of a given function and show description, params, see
and global

🌐 global  string  PARSED_DOC  doc block of the current function
```

[line: 145](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L145)

### parseFunction()

```txt
Parse a section for a given single function
and set

🌐 global  string  PARSED_FUNCTION  nane of the function
🌐 global  string  PARSED_LINE      line number
🌐 global  string  PARSED_DOC       doc block of the current function

🟩 param  string   file to parse
🟩 param  string   starting line with [LINE]:[FUNCTION_NAME]
```

[line: 110](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L110)

### setScript()

```txt
Set a bash script to parse
It sets the global variable.

🌐 global string  PARSED_SCRIPT  nane of the function

🟩 param  string  filename of bash script to parse
```

[line: 206](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L206)

### showHelp()

```txt
Show help with all cli parameters
```

[line: 221](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L221)

