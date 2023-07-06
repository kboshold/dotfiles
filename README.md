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

|Keybinding       |Mode  |Command                                                                             |Description                      |
|---              |---   |---                                                                                 |---                              |
|`<leader>gp`     |Normal|`require('gitsigns').prev_hunk`                                                     |                                 |
|`<leader>gn`     |Normal|`require('gitsigns').next_hunk`                                                     |                                 |
|`<leader>ph`     |Normal|`require('gitsigns').preview_hunk`                                                  |                                 |
|`<leader>pv`     |Normal|`vim.cmd.Ex`                                                                        |                                 |
|`[d`             |Normal|`vim.diagnostic.goto_prev`                                                          |Go to previous diagnostic message|
|`]d`             |Normal|`vim.diagnostic.goto_next`                                                          |Go to next diagnostic message    |
|`<leader>e`      |Normal|`vim.diagnostic.open_float`                                                         |Open floating diagnostic message |
|`<leader>q`      |Normal|`vim.diagnostic.setloclist`                                                         |Open diagnostics list            |
|`keys`           |Normal|`func`                                                                              |                                 |
|`<leader>?`      |Normal|`builtin.oldfiles`                                                                  |[?] Find recently opened files   |
|`<leader><space>`|Normal|`builtin.buffers`                                                                   |[ ] Find existing buffers        |
|`<leader>/`      |Normal|`function()   -- You can pass additional configuration to telescope to change theme`|                                 |
|`<leader>gf`     |Normal|`builtin.git_files`                                                                 |Search [G]it [F]iles             |
|`<leader>sf`     |Normal|`builtin.find_files`                                                                |[S]earch [F]iles                 |
|`<leader>sh`     |Normal|`builtin.help_tags`                                                                 |[S]earch [H]elp                  |
|`<leader>sw`     |Normal|`builtin.grep_string`                                                               |[S]earch current [W]ord          |
|`<leader>sg`     |Normal|`builtin.live_grep`                                                                 |[S]earch by [G]rep               |
|`<leader>sd`     |Normal|`builtin.diagnostics`                                                               |[S]earch [D]iagnostics           |
|`<leader>ps`     |Normal|`function()  builtin.grep_string({ search = vim.fn.input("Grep > ") }) end`         |                                 |

<!-- @GENERATED_TEMPLATE_END:NVIM -->