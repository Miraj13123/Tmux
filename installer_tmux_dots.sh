#!/bin/bash

# Determine the source directory based on execution context
if [ -d "tmux" ]; then
    # Called from root of repo
    SCRIPT_DIR="tmux"
else
    # Called from within tmux folder
    SCRIPT_DIR="."
fi

# User configuration directory
CONFIG_DIR="$HOME"

script_custom="$SCRIPT_DIR/.tmux_custom.conf"
target_custom="$CONFIG_DIR/.tmux_custom.conf"
target_conf="$CONFIG_DIR/.tmux.conf"

# Function to prompt user for y/n input
prompt_user() {
    local message=$1
    local response

    for(( i=0;i<2;i++ ));do
        read -p "$message [y/n]: " response
        if [[ "$response" == "y" || "$response" == "Y" ]];then
            return 0
        elif [[ "$response" == "n" || "$response" == "N" ]];then
            return 1
        fi
    done
    return 1
}


# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
    #echo $?
    return $?
}

# Function to detect package manager
package_manager() {
    if command_exists apt; then
        echo "apt"
    elif command_exists pacman; then
        echo "pacman"
    else
        echo "none"
    fi
}

str_finder(){              #           (( 1.2 ))
    if grep -q "$2" "$1";then
        return 0
    else
        return 1
    fi
}
recopy(){
    if [[ -f "$2" ]];then
        cp "$1" "$2"
        if [ $? -eq 0 ];then echo "successfully re-copied"; fi
        return 0
    fi
    echo "file doesn't exist"
    return 1
}

ensure_tmux_conf() {
    
    if [ ! -f "$target_conf" ]; then
        if prompt_user ".tmux.conf not found in $CONFIG_DIR. Create an empty kitty.conf?"; then
            touch "$target_conf"
            echo "Created empty file $target_conf."
        else
            echo "Cannot proceed without tmux.conf."
            return 1
        fi
    fi
    return 0
}

#                  ################################## ################################## ##################################
#                  ################################## ========+ MAIN functions +======== ################################## kitty
#                  ################################## ################################## ##################################

# Function to install Kitty
install_tmux() {  ##################
    echo "Checking if tmux is installed..."
    if command_exists tmux; then
        echo "tmux is already installed."
        return 0
    fi
    
    if prompt_user "tmux is not installed. Would you like to install it?"; then
        if [ "$(package_manager)" = "apt" ]; then
            echo "Installing tmux using apt..."
            sudo apt update
            sudo apt install -y tmux
        elif [ "$(package_manager)" = "pacman" ]; then
            echo "Installing tmux using pacman..."
            sudo pacman -Syu --noconfirm tmux
        else
            echo "Error: No supported package manager (apt or pacman) found."
            return 1
        fi
        
        if command_exists tmux; then
            echo "tmux installed successfully."
            return 0
        else
            echo "Error: tmux installation failed."
            return 1
        fi
        return 0
    else
        echo "Skipping tmux installation."
        return 1
    fi
}

# Function to install kitty_custom.conf and update kitty.conf
install_tmux_custom() {
    local script_custom="$SCRIPT_DIR/.tmux_custom.conf"
    local target_custom="$CONFIG_DIR/.tmux_custom.conf"
    
    if prompt_user "Install tmux_custom.conf and source it in tmux.conf?"; then

        if [ ! -f "$script_custom" ]; then
            echo "Error: kitty_custom.conf not found in $SCRIPT_DIR."
            return 1
        fi

        if [ ! -f "$target_custom" ]; then   ##  !!
            cp "$script_custom" "$target_custom"
            echo "kitty_custom.conf pasted"
        else
            echo "custom conf script already installed in $CONFIG_DIR."
            if prompt_user "wanna re-install?";then
                if cp "$script_custom" "$target_custom";then
                    echo re-pasted
                else
                    return 1
                fi
            else
                echo "skipping without re-pasting '.tmux_custom.conf'"
            fi
        fi
        
        # Check if kitty_custom.conf is already included
        if ! grep -q "source-file ~/.tmux_custom.conf" "$target_custom"; then
            echo "Adding source directive for .tmux_custom.conf to .tmux.conf..."
            echo "source-file ~/.tmux_custom.conf" >> "$target_conf"
            echo "sourceed tmux_custom.conf in tmux.conf."
        else
            echo ".tmux_custom.conf is already sourceed in .tmux.conf."
        fi
        return 0
    else
        echo "Skipping .tmux_custom.conf installation."
        return 1
    fi
}

    
install_tpm(){
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    if [ "$?" -eq 0 ];then
        echo installed
    else
        echo error_installing
    fi
}


# ==========  ========== Main execution ==========  ========== 
# ==========  ========== Main execution ==========  ========== 

echo "Starting TMUX custom dotfiles installation..."


# Function to install tmux
if ! install_tmux;then
    echo "somehow installation of tmux from '$(package_manager)' has failed"
fi

if ! ensure_tmux_conf;then
    echo "'.tmux.conf' file couldn't be created !! sorry, i tried :( "
fi

if ! install_tmux_custom;then
    echo "somehow installation of '.tmux_custom.conf' has failed"
fi

if ! install_tpm;then
    echo "somehow installation of 'tpm' has failed"
fi


echo "TMUX dotfiles installation complete."
exit 0
