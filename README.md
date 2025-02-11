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
      <h3>⚠️🚧 This configuration is still under development 🚧⚠️<h3>
      <h3>✨ Want to be a terminal wizard? ✨</h3>
      <div>My personal dotfile configurations.</div>
   </p>
</div>

> [!IMPORTANT]  
> I already use this configuration. But it is not yet ready for you to test it. 


## ✨ Get Started

### ⚡️ Requirements


### 🦄 Quick Install

```sh
sh <(curl -L https://raw.githubusercontent.com/kboshold/dotfiles/refs/heads/main/install.sh)
```

### 🛠️ Manual Installation


```sh
sh <(curl -L https://nixos.org/nix/install) --no-daemon
source $HOME/.nix-profile/etc/profile.d/nix.sh
```

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
``` 

```sh
git clone https://github.com/kboshold/website ~/.local/dotfiles
``` 


```
home-manager switch --flake ./.local/dotfiles/modules/home.nix
```

## Overview