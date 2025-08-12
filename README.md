# Tmux Dotfiles Installer

This repository contains a Bash script (`installer_tmux_dots.sh`) to automate the installation of Tmux, Tmux Plugin Manager (TPM), and custom Tmux configurations. The script supports Debian/Ubuntu (`apt`) and Arch-based (`pacman`) systems.

## Features
- Installs Tmux terminal multiplexer.
- Installs Tmux Plugin Manager (TPM) with plugins like `catppuccin/tmux`.
- Configures Tmux with `~/.tmux.conf` and sources `~/.tmux_custom.conf` for custom settings.
- Handles non-interactive execution for easy deployment (e.g., `curl | bash`).
- Ensures configurations are safely copied, with prompts to avoid overwriting existing files.
- Automatically sources Tmux configuration after installation.

## Prerequisites
- A Debian/Ubuntu or Arch-based Linux system.
- `git` for cloning TPM.
- `sudo` permissions for installing packages.
- A terminal to run the script interactively, or a non-interactive environment for `curl | bash`.

### One-Liner Installation
```bash
sudo apt install curl git -y
```

## Installation

To install the dotfiles, run the script from the repository root:



### Manual Installation
Download and run the script:
```bash
git clone https://github.com/tmux-plugins/tpm.git temp101
cd temp101
chmod +x installer_tmux_dots.sh
./installer_tmux_dots.sh
cd ..
rm -rf temp101
```
### One liner
```bash
git clone https://github.com/tmux-plugins/tpm.git temp101 && cd temp101 && chmod +x installer_tmux_dots.sh && ./installer_tmux_dots.sh && cd .. && rm -rf temp101
```

The script will:
1. Detect the package manager (`apt` or `pacman`).
2. Install Tmux if not present (assumes "yes" in non-interactive mode).
3. Create or update `~/.tmux.conf` and `~/.tmux_custom.conf`.
4. Install TPM and plugins.
5. Source `~/.tmux.conf` to apply settings.

## Tmux Configuration

The included `~/.tmux.conf` and `~/.tmux_custom.conf` provide a modern Tmux setup with:
- **Prefix**: `Ctrl-s` (replaces default `Ctrl-b`).
- **Mouse Support**: Enabled for scrolling, selecting panes, and resizing.
- **256-Color Support**: Uses `screen-256color` for vibrant visuals.
- **Large Scrollback**: 100,000 lines.
- **Status Bar**: Positioned at the top with custom colors (`bg=#333333`, `fg=#ffffff`).
- **TPM Plugins**: Includes `catppuccin/tmux` for a sleek status bar theme.

### Keybindings
All default bindings are unbound (`unbind-key -a`) for a clean setup. Below are the keybindings:

#### General
- `Ctrl-s ;` : Open command prompt.
- `Ctrl-s r` : Reload `~/.tmux.conf` and display "sourced ~/.tmux.conf".

#### Session Management
- `Ctrl-s n` : Create a new session (prompts for name).
- `Ctrl-s Tab` : Switch between sessions.
- `Ctrl-s $` : Rename current session.
- `Ctrl-s t` : Rename current window.
- `Ctrl-s c` : Save session (requires `tmux-resurrect` plugin, commented out).
- `Ctrl-s v` : Restore session (requires `tmux-resurrect` plugin, commented out).

#### Window Management
- `Ctrl-right` : Next window.
- `Ctrl-left` : Previous window.
- `Ctrl-t` : Create new window.
- `Alt-1` to `Alt-9` : Select window 1-9.
- `Alt-0` : Select window 10.
- `Ctrl-Tab, Right` : Next window (in navigation mode).
- `Ctrl-Tab, Left` : Previous window (in navigation mode).
- `Ctrl-Tab, 1-9` : Select window 1-9 (in navigation mode).
- `Ctrl-Tab, 0` : Select window 10 (in navigation mode).
- `Ctrl-s 1-9` : Select window 1-9 (lazy navigation).
- `Ctrl-s 0` : Select window 10 (lazy navigation).

#### Pane Management
- `Ctrl-Alt-Right` : Split window horizontally.
- `Ctrl-Alt-Down` : Split window vertically.
- `Ctrl-Alt-Left` : Split window horizontally (left).
- `Ctrl-Alt-Up` : Split window vertically (above).
- `Ctrl-Shift-Left` or `Ctrl-Shift-h` : Select left pane.
- `Ctrl-Shift-Down` or `Ctrl-Shift-j` : Select down pane.
- `Ctrl-Shift-Up` or `Ctrl-Shift-k` : Select up pane.
- `Ctrl-Shift-Right` or `Ctrl-Shift-l` : Select right pane.
- `Ctrl-Shift-Alt-Left` : Resize pane left by 5 cells.
- `Ctrl-Shift-Alt-Down` : Resize pane down by 5 cells.
- `Ctrl-Shift-Alt-Up` : Resize pane up by 5 cells.
- `Ctrl-Shift-Alt-Right` : Resize pane right by 5 cells.
- `Ctrl-w` : Kill current pane.
- `Ctrl-Shift-z` : Toggle zoom for current pane.

#### TPM Management
- `Ctrl-s Shift-I` : Install TPM plugins (e.g., `catppuccin/tmux`).

## Tmux Plugin Manager (TPM)
The script installs TPM and the `catppuccin/tmux` plugin. To manually install plugins after setup:
1. Start a tmux session: `tmux`.
2. Press `Ctrl-s Shift-I` to install plugins.

## Custom Tmux Configuration
The script installs `~/.tmux_custom.conf` and sources it in `~/.tmux.conf` using:
`code-snippet`
source-file ~/.tmux_custom.conf
`code-snippet`
Add custom settings to `~/.tmux_custom.conf` to extend or override `~/.tmux.conf` without modifying the main file.