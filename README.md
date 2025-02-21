<div align="center">
   <p>
      <a href="https://github.com/kboshold/dotfiles#is=awesome">
         <picture>
            <source media="(prefers-color-scheme: dark)" type="image/svg+xml" srcset="./docs/assets/logo_dark.svg">
            <img alt="Logo with the text 'Dotfiles & the magic of the terminal' and a wizard on the left" src="./docs/assets/logo_light.svg">
         </picture>
      </a>
   </p>
   <p>
      <a href="https://github.com/kpalatzky/dotfiles/blob/master/flake.nix">
         <picture>
            <source media="(prefers-color-scheme: dark)" type="image/svg+xml" srcset="https://img.shields.io/badge/nix-flake-b4befe?logo=nixos&labelColor=1e1e2e">
            <img src="https://img.shields.io/badge/nix-flake-7287fd?logo=nixos&labelColor=eff1f5" alt="Nix Flake"/>
         </picture>
      </a>
      <a href="https://github.com/kpalatzky/dotfiles/blob/master/config/tmux">
         <picture>
            <source media="(prefers-color-scheme: dark)" type="image/svg+xml" srcset="https://img.shields.io/badge/%3E%3D3.5a-313244?logo=tmux&label=tmux&labelColor=a6e3a1&logoColor=313244">
            <img alt="Tmux configuration" src="https://img.shields.io/badge/%3E%3D3.5a-ccd0da?logo=tmux&label=tmux&labelColor=40a02b&logoColor=ccd0da">
         </picture>
      </a>
      <a href="https://github.com/kpalatzky/nvim.dotfiles">
         <picture>
            <source media="(prefers-color-scheme: dark)" type="image/svg+xml" srcset="https://img.shields.io/badge/%3E%3D0.10.0-a6e3a1?logo=neovim&label=neovim&labelColor=74c7ec&logoColor=313244">
            <img alt="Neovim configuration" src="https://img.shields.io/badge/%3E%3D0.10.0-40a02b?logo=neovim&label=neovim&labelColor=1e66f5">
         </picture>
      </a>
      <a href="https://github.com/kpalatzky/dotfiles/blob/master/LICENSE">
         <picture>
            <source media="(prefers-color-scheme: dark)" type="image/svg+xml" srcset="https://img.shields.io/github/license/kpalatzky/dotfiles.svg?color=cba6f7&labelColor=b4befe">
            <img src="https://img.shields.io/github/license/kpalatzky/dotfiles.svg?color=8839ef" alt="MIT License"/>
         </picture>
      </a>
   </p>
   <hr>
   <p>
      <h3>✨ Want to be a terminal wizard? ✨</h3>
      <div>My personal dotfile configurations.</div>
   </p>
</div>

## ✨ Get Started

### 🦄 Quick Install

```sh
bash <(curl -L https://raw.githubusercontent.com/kboshold/dotfiles/refs/heads/main/install.sh)
```

### 🛠️ Manual Installation (Using Nix)

**⚡️ Requirements**

- `nix`
- `home-manager`

**🌱 Installation**

Clone the respository to have the dotfile locally:

```sh
git clone https://github.com/kboshold/website ~/.local/share/dotfiles
git -C "~/.local/share/dotfiles" submodule update --init --recursive
```

Now enable the flake using the following command
```sh
home-manager switch --flake "~/.local/share/dotfiles?submodules=1#home" --impure -b bckp
```

## 🕺 Overview
The configuration includes some cool features: a stunning Nvim configuration, as well as Tmux, Fish and more!
See it in action:
<details> 
<summary><b>📸 Showcase <i>(Click to expand)</i></b></summary>
A1: JavaScript 
</details>
