# dotfiles

Config pribadi (Arch + i3), dikelola dengan [GNU Stow](https://www.gnu.org/software/stow/).
Satu folder = satu package; isi folder meniru path relatif terhadap `$HOME`.

| Package    | Target                     |
|------------|----------------------------|
| `nvim`     | `~/.config/nvim`           |
| `i3`       | `~/.config/i3`             |
| `i3status` | `~/.config/i3status`       |
| `kitty`    | `~/.config/kitty`          |
| `lazygit`  | `~/.config/lazygit`        |
| `zsh`      | `~/.zshrc`                 |
| `git`      | `~/.gitconfig`             |
| `x11`      | `~/.xinitrc`               |

## Install

```sh
sudo pacman -S stow
git clone https://github.com/songhekyo/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim i3 i3status kitty lazygit zsh git x11   # atau pilih sebagian
```

Stow menolak menimpa file asli yang sudah ada — pindahkan/backup dulu file lama jika muncul konflik.
Lepas satu package: `stow -D nvim`.

## Sengaja tidak disertakan

Config yang bisa berisi token/kredensial: `gh`, `opencode`, `beekeeper-studio`, `google-chrome`.
