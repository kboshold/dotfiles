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
require('telescope.builtin').oldfiles
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
require('telescope.builtin').buffers
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

[/] Fuzzily search in current buffer

</td>
<td>

```lua
function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end
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
require('telescope.builtin').git_files
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
require('telescope.builtin').find_files
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
require('telescope.builtin').help_tags
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
require('telescope.builtin').grep_string
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
require('telescope.builtin').live_grep
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
require('telescope.builtin').diagnostics
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
	require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end
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

`<leader>rn`

</td>
<td>

Normal

</td>
<td>

[R]e[n]ame

</td>
<td>

```lua
vim.lsp.buf.rename
```

</td>
</tr>
<tr>
<td>

`<leader>ca`

</td>
<td>

Normal

</td>
<td>

[C]ode [A]ction

</td>
<td>

```lua
vim.lsp.buf.code_action
```

</td>
</tr>
<tr>
<td>

`gd`

</td>
<td>

Normal

</td>
<td>

[G]oto [D]efinition

</td>
<td>

```lua
vim.lsp.buf.definition
```

</td>
</tr>
<tr>
<td>

`gr`

</td>
<td>

Normal

</td>
<td>

[G]oto [R]eferences

</td>
<td>

```lua
require('telescope.builtin').lsp_references
```

</td>
</tr>
<tr>
<td>

`gI`

</td>
<td>

Normal

</td>
<td>

[G]oto [I]mplementation

</td>
<td>

```lua
vim.lsp.buf.implementation
```

</td>
</tr>
<tr>
<td>

`<leader>D`

</td>
<td>

Normal

</td>
<td>

Type [D]efinition

</td>
<td>

```lua
vim.lsp.buf.type_definition
```

</td>
</tr>
<tr>
<td>

`<leader>ds`

</td>
<td>

Normal

</td>
<td>

[D]ocument [S]ymbols

</td>
<td>

```lua
require('telescope.builtin').lsp_document_symbols
```

</td>
</tr>
<tr>
<td>

`<leader>ws`

</td>
<td>

Normal

</td>
<td>

[W]orkspace [S]ymbols

</td>
<td>

```lua
require('telescope.builtin').lsp_dynamic_workspace_symbols
```

</td>
</tr>
<tr>
<td>

`K`

</td>
<td>

Normal

</td>
<td>

Hover Documentation

</td>
<td>

```lua
vim.lsp.buf.hover
```

</td>
</tr>
<tr>
<td>

`<C-k>`

</td>
<td>

Normal

</td>
<td>

Signature Documentation

</td>
<td>

```lua
vim.lsp.buf.signature_help
```

</td>
</tr>
<tr>
<td>

`gD`

</td>
<td>

Normal

</td>
<td>

[G]oto [D]eclaration

</td>
<td>

```lua
vim.lsp.buf.declaration
```

</td>
</tr>
<tr>
<td>

`<leader>wa`

</td>
<td>

Normal

</td>
<td>

[W]orkspace [A]dd Folder

</td>
<td>

```lua
vim.lsp.buf.add_workspace_folder
```

</td>
</tr>
<tr>
<td>

`<leader>wr`

</td>
<td>

Normal

</td>
<td>

[W]orkspace [R]emove Folder

</td>
<td>

```lua
vim.lsp.buf.remove_workspace_folder
```

</td>
</tr>
<tr>
<td>

`<leader>wl`

</td>
<td>

Normal

</td>
<td>

[W]orkspace [L]ist Folders

</td>
<td>

```lua
function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
```

</td>
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
</table>
<!-- @GENERATED_TEMPLATE_END:NVIM -->