## bashdoc2md.sh

List of all functions in alphabetic order

### getbashdoc()

```txt
show help for a given script
```

[line: 158](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L158)

### getFunctions()

```txt
find all functions with long and short and create a uniq list
it returns lines [LINE]:[FUNCTION_NAME]
🟩 param  string  scriptname to parse
return string
```

[line: 63](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L63)

### getHeader()

```txt
get markdown header for
return string
```

[line: 76](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L76)

### parseDocBlock()

```txt
parse the doc block of a given function
🌐 global vars: $PARSED_DOC  string  doc block of the function
```

[line: 124](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L124)

### parseFunction()

```txt
TODO:
Parse a section for a given single function
and return
PARSED_FUNCTION  nane of the function
PARSED_LINE      line number
PARSED_DOC       doc section

🟩 param  string   file to parse
🟩 param  string   starting line with [LINE]:[FUNCTION_NAME]
```

[line: 90](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L90)

### setScript()

```txt
set a bash script to parse
it sets the global variable
PARSED_SCRIPT  nane of the function
🟩 param  string  filename of bash script to parse
```

[line: 184](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L184)

### showHelp()

```txt
show help with all cli parameters
```

[line: 199](https://github.com/axelhahn/bashdoc/blob/main/bashdoc2md.sh#L199)

