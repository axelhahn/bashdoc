## Description

I want to create a documentation for all my projects.

Some functionality can be automated. So I started a bash script to parse a given bash script and read all its functions and their doc blocks.

The output is in markdown format to create a documentation for a single file below the docs folder.

### Example

If I use a doc block for each function lik this:

```shell
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
    ...
}
```

Then it renders a markdown file ... that is rendered in a webpage like this:

![Screenshot](images/screenshot_generated_markdown.png)
