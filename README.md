<div align="center">
   <p>
      <a href="https://github.com/kpalatzky/dotfiles#is=awesome">
        <img src="assets/dotfile_logo.svg" alt="DOTFILE Logo" width="80%"/>
      </a>
   </p>
   <p>
      <a href="https://github.com/kpalatzky/dotfiles/blob/master/LICENSE">
        <img src="https://img.shields.io/github/license/kpalatzky/dotfiles.svg" alt="MIT License">
      </a>
   </p>
   <hr>
   <p>
      <span style="font-size:24px;">My awesome .dotfiles</span>
      <br>
      <strong>THIS FILES ARE STILL UNDER DEVELOPMENT - DO NOT USE IT FOR PRODUCTION USE</strong>
   </p>
</div>

## Get started

### Installation

The dotfiles are managed via [chezmoi](https://www.chezmoi.io/), so this must be installed first. 
Install the correct binary for your operating system and architecture in `~/.local/bin` with a single command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:kpalatzky/dotfiles.git
```

## Overview

### Programs

### Keybindings


#### NVIM


<!-- Mark start/end of keybindings to automatically update them -->
<!-- @GENERATED_TEMPLATE_START:NVIM -->

<table>
<tr>
<th>

Keybinding&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</th>
<th>

Mode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</th>
<th>

Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</th>
<th>

Action&nbsp;(Lua)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</th>
</tr>
<tr>
<td>

`<leader>gp`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
require('gitsigns').prev_hunk
```

</td>
</tr>
<tr>
<td>

`<leader>gn`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
require('gitsigns').next_hunk
```

</td>
</tr>
<tr>
<td>

`<leader>ph`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
require('gitsigns').preview_hunk
```

</td>
</tr>
<tr>
<td>

`<leader>pv`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
vim.cmd.Ex
```

</td>
</tr>
<tr>
<td>

`[d`

</td>
<td>

Normal

</td>
<td>

Go to previous diagnostic message

</td>
<td>

```lua
vim.diagnostic.goto_prev
```

</td>
</tr>
<tr>
<td>

`]d`

</td>
<td>

Normal

</td>
<td>

Go to next diagnostic message

</td>
<td>

```lua
vim.diagnostic.goto_next
```

</td>
</tr>
<tr>
<td>

`<leader>e`

</td>
<td>

Normal

</td>
<td>

Open floating diagnostic message

</td>
<td>

```lua
vim.diagnostic.open_float
```

</td>
</tr>
<tr>
<td>

`<leader>q`

</td>
<td>

Normal

</td>
<td>

Open diagnostics list

</td>
<td>

```lua
vim.diagnostic.setloclist
```

</td>
</tr>
<tr>
<td>

`keys`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
func
```

</td>
</tr>
<tr>
<td>

`<leader>?`

</td>
<td>

Normal

</td>
<td>

[?] Find recently opened files

</td>
<td>

```lua
builtin.oldfiles
```

</td>
</tr>
<tr>
<td>

`<leader><space>`

</td>
<td>

Normal

</td>
<td>

[ ] Find existing buffers

</td>
<td>

```lua
builtin.buffers
```

</td>
</tr>
<tr>
<td>

`<leader>/`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
function()
  -- You can pass additional configuration to telescope to change theme
```

</td>
</tr>
<tr>
<td>

`<leader>gf`

</td>
<td>

Normal

</td>
<td>

Search [G]it [F]iles

</td>
<td>

```lua
builtin.git_files
```

</td>
</tr>
<tr>
<td>

`<leader>sf`

</td>
<td>

Normal

</td>
<td>

[S]earch [F]iles

</td>
<td>

```lua
builtin.find_files
```

</td>
</tr>
<tr>
<td>

`<leader>sh`

</td>
<td>

Normal

</td>
<td>

[S]earch [H]elp

</td>
<td>

```lua
builtin.help_tags
```

</td>
</tr>
<tr>
<td>

`<leader>sw`

</td>
<td>

Normal

</td>
<td>

[S]earch current [W]ord

</td>
<td>

```lua
builtin.grep_string
```

</td>
</tr>
<tr>
<td>

`<leader>sg`

</td>
<td>

Normal

</td>
<td>

[S]earch by [G]rep

</td>
<td>

```lua
builtin.live_grep
```

</td>
</tr>
<tr>
<td>

`<leader>sd`

</td>
<td>

Normal

</td>
<td>

[S]earch [D]iagnostics

</td>
<td>

```lua
builtin.diagnostics
```

</td>
</tr>
<tr>
<td>

`<leader>ps`

</td>
<td>

Normal

</td>
<td>



</td>
<td>

```lua
function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end
```

</td>
</tr>
</table>
<!-- @GENERATED_TEMPLATE_END:NVIM -->