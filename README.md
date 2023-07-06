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

|Keybinding|Mode             |Command                                                                             |Description                      |
|---       |---              |---                                                                                 |---                              |
|n         |`<leader>gp`     |`require('gitsigns').prev_hunk`                                                     |                                 |
|n         |`<leader>gn`     |`require('gitsigns').next_hunk`                                                     |                                 |
|n         |`<leader>ph`     |`require('gitsigns').preview_hunk`                                                  |                                 |
|n         |`<leader>pv`     |`vim.cmd.Ex`                                                                        |                                 |
|n         |`[d`             |`vim.diagnostic.goto_prev`                                                          |Go to previous diagnostic message|
|n         |`]d`             |`vim.diagnostic.goto_next`                                                          |Go to next diagnostic message    |
|n         |`<leader>e`      |`vim.diagnostic.open_float`                                                         |Open floating diagnostic message |
|n         |`<leader>q`      |`vim.diagnostic.setloclist`                                                         |Open diagnostics list            |
|n         |`keys`           |`func`                                                                              |                                 |
|n         |`<leader>?`      |`builtin.oldfiles`                                                                  |[?] Find recently opened files   |
|n         |`<leader><space>`|`builtin.buffers`                                                                   |[ ] Find existing buffers        |
|n         |`<leader>/`      |`function()   -- You can pass additional configuration to telescope to change theme`|                                 |
|n         |`<leader>gf`     |`builtin.git_files`                                                                 |Search [G]it [F]iles             |
|n         |`<leader>sf`     |`builtin.find_files`                                                                |[S]earch [F]iles                 |
|n         |`<leader>sh`     |`builtin.help_tags`                                                                 |[S]earch [H]elp                  |
|n         |`<leader>sw`     |`builtin.grep_string`                                                               |[S]earch current [W]ord          |
|n         |`<leader>sg`     |`builtin.live_grep`                                                                 |[S]earch by [G]rep               |
|n         |`<leader>sd`     |`builtin.diagnostics`                                                               |[S]earch [D]iagnostics           |
|n         |`<leader>ps`     |`function()  builtin.grep_string({ search = vim.fn.input("Grep > ") }) end`         |                                 |

<!-- @GENERATED_TEMPLATE_END:NVIM -->