## bashdoc2md.sh

List of all functions in alphabetic order

### getbashdoc()

```txt
Main function: parse given script and show markdown for all functions
It calls functions for atomar actions

👉🏼 see getFunctions()
👉🏼 see parseFunction()
👉🏼 see parseDocblock()

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse
🌐 global  string  PARSED_FUNCTION  nane of the function
🌐 global  string  PARSED_LINE      line number
🌐 global  string  PARSED_DOC       doc block of the current function
🌐 global  string  PREFIX_FUNCTION  prefix string for headline with function name
🌐 global  string  REPOURL          Source code URL
```

[line: 189](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L189)

### getFunctions()

```txt
Find all functions with long and short and create a uniq list
it returns lines [LINE]:[FUNCTION_NAME]. It is called by

👉🏼 see getbashdoc()

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse

🟩 param  string  scriptname to parse
return string
```

[line: 81](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L81)

### getHeader()

```txt
Get markdown header: header in set level and name of script

🌐 global  string  PARSED_SCRIPT    nane of the bash script to parse
🌐 global  string  PREFIX_SCRIPT    prefix string for headline with script

return string
```

[line: 98](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L98)

### parseDocBlock()

```txt
Parse the doc block of a given function and show description, params, see
and global. It is called by

👉🏼 see getbashdoc()

🌐 global  string  PARSED_DOC  doc block of the current function
```

[line: 151](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L151)

### parseFunction()

```txt
Parse a section for a given single function
and set global variables. It is called by

👉🏼 see getbashdoc()

🌐 global  string  PARSED_FUNCTION  nane of the function
🌐 global  string  PARSED_LINE      line number
🌐 global  string  PARSED_DOC       doc block of the current function

🟩 param  string   file to parse
🟩 param  string   starting line with [LINE]:[FUNCTION_NAME]
```

[line: 114](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L114)

### setScript()

```txt
Set a bash script to parse
It sets the global variable.

🌐 global string  PARSED_SCRIPT  nane of the function

🟩 param  string  filename of bash script to parse
```

[line: 219](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L219)

### showHelp()

```txt
Show help with all cli parameters
```

[line: 234](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L234)

- - -
Generated with [Bashdoc](https://github.com/axelhahn/bashdoc) v0.6
