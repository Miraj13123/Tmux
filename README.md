# Tmux Dotfiles Installer

This repository provides a Bash script (`installer_tmux_dots.sh`) to automate the installation of Tmux, Tmux Plugin Manager (TPM), and custom Tmux configurations. It supports Debian/Ubuntu (`apt`) and Arch-based (`pacman`) systems.

- this is a part of my [dotfiles](https://github.com/corechunk/dotfiles) repository. You can use [dotfiles](https://github.com/corechunk/dotfiles) repo that will automatically download this repo and a lot of other dotfiles-repo like Neovim, Kitty, Bash etc.

<p align="center">
  <img src="https://img.shields.io/badge/Tmux-Dotfiles-181717?style=flat-square&logo=tmux" alt="Tmux Dotfiles Badge" width="300"/>
</p>

---

## ✨ Features

- **Automated Installation**: Installs Tmux and Tmux Plugin Manager (TPM) with plugins like `catppuccin/tmux`.
- **Custom Configuration**: Sets up `~/.tmux.conf` and `~/.tmux_custom.conf` for a modern Tmux environment.
- **Non-Interactive Support**: Suitable for `curl | bash` deployment.
- **Safe File Handling**: Prompts to avoid overwriting existing configuration files.
- **Cross-Distro Compatibility**: Supports Debian/Ubuntu (`apt`) and Arch-based (`pacman`) systems.
- **Auto-Sourcing**: Applies Tmux configuration automatically after installation.

## 📋 Prerequisites

- A Debian/Ubuntu or Arch-based Linux system.
- `git` for cloning TPM.
- `sudo` permissions for package installation.
- A terminal for interactive execution or a non-interactive environment for `curl | bash`.

### Install Prerequisites
```bash
sudo apt install curl git -y
```

---

## 🛠️ Installation

### Manual Installation
Clone the repository, run the script, and clean up:
```bash
git clone https://github.com/corechunk/Tmux.git temp101
cd temp101
chmod +x installer_tmux_dots.sh
./installer_tmux_dots.sh
cd ..
rm -rf temp101
```

### One-Liner Installation
```bash
git clone https://github.com/corechunk/Tmux.git temp101 && cd temp101 && chmod +x installer_tmux_dots.sh && ./installer_tmux_dots.sh && cd .. && rm -rf temp101
```

The script will:
1. Detect the package manager (`apt` or `pacman`).
2. Install Tmux if not already present (assumes "yes" in non-interactive mode).
3. Create or update `~/.tmux.conf` and `~/.tmux_custom.conf`.
4. Install TPM and plugins.
5. Source `~/.tmux.conf` to apply settings.

---

## ⚙️ Tmux Configuration

The `~/.tmux.conf` and `~/.tmux_custom.conf` files provide a modern Tmux setup with:
- **Prefix**: `Ctrl-s` (replaces default `Ctrl-b`).
- **Mouse Support**: Enabled for scrolling, pane selection, and resizing.
- **256-Color Support**: Uses `screen-256color` for vibrant visuals.
- **Large Scrollback**: 100,000 lines.
- **Status Bar**: Top-positioned with custom colors (`bg=#333333`, `fg=#ffffff`) and `catppuccin/tmux` theme.
- **Customizable**: Add settings to `~/.tmux_custom.conf` to extend or override `~/.tmux.conf`.

To source extra custom settings in `~/.tmux.conf`:
```bash
source-file ~/.tmux_yourCustomName.conf
```

---

## ⌨️ Keybindings

Tmux uses a **leader key** (`Ctrl-s` in this setup) to trigger many commands. The leader key is pressed and released, pausing the input buffer, so you can then press additional keys to complete the action. For example, pressing `Ctrl-s`, releasing it, then pressing `;` opens the command prompt. Keybindings with `<leader>` use this mechanism. Non-leader keybindings (e.g., `Ctrl-right`) are pressed simultaneously and don’t require the leader.

All default Tmux bindings are unbound for a clean setup. Below are the custom keybindings, organized by category. Leader-based bindings use `<leader>`, while non-leader bindings are direct key combinations.

| **Category**         | **Keybinding**            | **Action**                              |
|----------------------|---------------------------|-----------------------------------------|
| **General**          | `<leader> ;`             | Open command prompt                     |
|                      | `<leader> r`             | Reload `~/.tmux.conf`                   |
| -                    | -                        | -                                       |
| **Session Management**| `<leader> n`            | Create new session (prompts for name)   |
|                      | `<leader> Tab`           | Switch between sessions                 |
|                      | `<leader> $`             | Rename current session                  |
|                      | `<leader> t`             | Rename current window                   |
|                      | `<leader> c`             | Save session (`tmux-resurrect` plugin)  |
|                      | `<leader> v`             | Restore session (`tmux-resurrect` plugin) |
| -                    | -                        | -                                       |
| **Window Management**| `Ctrl-right`             | Next window                             |
|                      | `Ctrl-left`              | Previous window                         |
|                      | `Ctrl-t`                 | Create new window                       |
|                      | `Alt-1` to `Alt-9`       | Select window 1-9                       |
|                      | `Alt-0`                  | Select window 10                        |
|                      | `Ctrl-Tab, Right`        | Next window (navigation mode)           |
|                      | `Ctrl-Tab, Left`         | Previous window (navigation mode)       |
|                      | `Ctrl-Tab, 1-9`          | Select window 1-9 (navigation mode)     |
|                      | `Ctrl-Tab, 0`            | Select window 10 (navigation mode)      |
|                      | `<leader> 1-9`           | Select window 1-9 (lazy navigation)     |
|                      | `<leader> 0`             | Select window 10 (lazy navigation)      |
| -                    | -                        | -                                       |
| **Pane Management**  | `Ctrl-Alt-Right`         | Split window horizontally               |
|                      | `Ctrl-Alt-Down`          | Split window vertically                 |
|                      | `Ctrl-Alt-Left`          | Split window horizontally (left)        |
|                      | `Ctrl-Alt-Up`            | Split window vertically (above)         |
|                      | `Ctrl-Shift-Left` / `h`  | Select left pane                        |
|                      | `Ctrl-Shift-Down` / `j`  | Select down pane                        |
|                      | `Ctrl-Shift-Up` / `k`    | Select up pane                          |
|                      | `Ctrl-Shift-Right` / `l` | Select right pane                       |
|                      | `Ctrl-Shift-Alt-Left`    | Resize pane left by 5 cells             |
|                      | `Ctrl-Shift-Alt-Down`    | Resize pane down by 5 cells             |
|                      | `Ctrl-Shift-Alt-Up`      | Resize pane up by 5 cells               |
|                      | `Ctrl-Shift-Alt-Right`   | Resize pane right by 5 cells            |
|                      | `Ctrl-w`                 | Kill current pane                       |
|                      | `Ctrl-Shift-z`           | Toggle zoom for current pane            |
| -                    | -                        | -                                       |
| **TPM Management**   | `<leader> Shift-I`       | Install TPM plugins                     |

---

## 🔌 Tmux Plugin Manager (TPM)

The script installs TPM and the `catppuccin/tmux` plugin for a sleek status bar theme. To manually install plugins:
1. Start a Tmux session: `tmux`.
2. Press `Ctrl-s Shift-I` to install plugins.

---

## 📝 Customization

- **Extend Configurations**: Add custom settings to `~/.tmux_custom.conf` to override or extend `~/.tmux.conf` without modifying the main file.
- **Plugin Management**: Add or remove TPM plugins in `~/.tmux.conf` and run `Ctrl-s Shift-I` to update.

---

## 📜 License

This project is licensed under the [Apache 2.0 License](LICENSE).

---

[![Back to Dotfiles](https://img.shields.io/badge/Back_to_Dotfiles-181717?style=flat-square&logo=github)](https://github.com/corechunk/dotfiles)
[![Connect on X](https://img.shields.io/badge/Connect_on_X-1DA1F2?style=flat-square&logo=x)](https://x.com/Mahmudul__Miraj)