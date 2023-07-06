# Script for extracting keybindings of config files
# Better to invest 4h in a script than 15 minutes to do something manually 
from pathlib import Path
import os
import re

# get project folder as base path
basePath = Path(os.getcwd()) / '..'

readme_content = ''
with open(basePath / 'README.md', 'r') as f:
    readme_content = f.read()


####################################################################
##### Helper Methods
####################################################################
def get_arguments(content, startIndex):
    subContent = content[startIndex:]
    args = [""]
    pstack = []
    
    is_line_start = False
    is_comment = False
    for index, character in enumerate(subContent):
        if (is_comment and character == '\n'):
            is_comment = False

        if character == '(' and not is_comment:
            if (len(pstack) != 0):
                args[-1] += character
            pstack.append(index)
        elif character == ')' and not is_comment:
            if len(pstack) == 0:
                raise IndexError("No matching closing parens at: " + str(index))
            elif len(pstack) == 1:
                return args
            pstack.pop()
            args[-1] += character;
        elif character == ',' and len(pstack) == 1 and not is_comment:
            args.append("");
        else:
            args[-1] += character;
            if character == '\n':
                is_line_start = True;

        next_character = subContent[index + 1] if subContent[index+1:] else ''
        if (character == '-' and next_character == '-'):
            is_comment = True

        if (re.match("\S", character)): 
            is_line_start = False
        


    if len(pstack) > 0:
        raise IndexError("No matching opening parens at: " + str(pstack.pop()))

    return args

def to_table(rows, widths = None):
    if (widths == None):
        widths = [0] * len(rows)
    
    output = "<table>\n"
    for row_index, row in enumerate(rows):
        type = 'th' if row_index == 0 else 'td'
        output += "<tr>\n"
        for index, col in enumerate(row):
            output += "<%s>\n\n" % type
            output += col
            if (row_index == 0):
                width = widths[index]
                output += "&nbsp;" * max(width - len(col), 0)
            output += "\n\n</%s>\n" % type
        output += "</tr>\n"

    output += "</table>"

    return output

def replace_template(marker, content, readme_content):
    return re.sub("(<!-- @GENERATED_TEMPLATE_START:%s -->)[\s\S]*(<!-- @GENERATED_TEMPLATE_END:%s -->)" % (marker, marker), r"\1\n\n%s\n\2" % content, readme_content)


####################################################################
##### NeoVim<span style='width:200px'>
####################################################################
luaFiles = list((basePath / 'dot_config/nvim').glob('**/*.lua'))

vimTable = [
    ["Keybinding", "Mode", "Description", "Action&nbsp;(Lua)"],
]
for luaFile in luaFiles:
    with open(luaFile, 'r') as f:
        lines = f.read()
    
    for match in re.finditer("vim\\.keymap\\.set", lines):
        end_position = match.span()[1];
        args = get_arguments(lines, end_position)

        mode = (re.sub("(^[\"']|[\"']$)", "", args[0])).strip()
        keybinding = (re.sub("(^\s*[\"']|[\"']\s*$)", "", args[1])).strip()
        fnBinding = (args[2] if args[2:] else "").strip()
        options = (args[3] if args[3:] else "{}").strip()

        modes = {
            'i': 'Insert',
            'n': 'Normal',
            'v': 'Visual',
            'c': 'Command',
            'r': 'Replace',
        }
        modeName = modes.get(mode, 'None')

        desc = m[1] if (m:=re.search("desc\\s*=\\s*['\"](.*?)['\"]", options)) else ''
        vimTable.append([
            "`%s`" % keybinding, 
            modeName, 
            desc,
            "```lua\n%s\n```" % fnBinding, 
        ])

vim_table_html = to_table(vimTable, [30, 20, 70, 140])
readme_content = replace_template("NVIM", vim_table_html, readme_content)

# Update file
with open(basePath / 'README.md', 'w') as f:
    f.write(readme_content)