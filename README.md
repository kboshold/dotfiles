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

<details> 
<summary><h3>Showcase <i>(Click to expand)</i></h3></summary>
A1: JavaScript 
</details>
