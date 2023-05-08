#!/usr/bin/bash

# This script use Google Shell Style Guide
# https://google.github.io/styleguide/shellguide.html#s1-background

# Log message according log level
# Colors:
# - Black:      \e[30m
# - Red:        \e[31m
# - Green:      \e[32m
# - Yellow:     \e[33m
# - Blue:       \e[34m
# - Magenta:    \e[35m
# - Cyan:       \e[36m
# - White:      \e[37m
#
# ANSI escape code: https://en.wikipedia.org/wiki/ANSI_escape_code
function log {
    level=$1
    msg=$2
    line_pos=$3
    log_prefix="$(date '+%Y-%m-%d %H:%M:%S') --- $0 -> $line_pos\t"

    case "$level" in
    "error")
        echo -e "$log_prefix\e[1m\e[31m[ERROR]\e[0m\t$msg"
        ;;
    "warn")
        echo -e "$log_prefix\e[1m\e[35m[WARN]\e[0m\t$msg"
        ;;
    "info")
        echo -e "$log_prefix\e[1m\e[36m[INFO]\e[0m\t$msg"
        ;;
    "debug")
        echo -e "$log_prefix\e[1m[DEBUG]\e[0m\t$msg"
        ;;
    esac
}

detect() {
    cmd="$(which $1)"
    if test $? -eq 0; then
        log "info" "\e[3m$1\e[0m\tInstalled. OK"
    else
        log "warn" "\e[3m$1\e[0m\tNot Installed."
    fi
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Detect environment
cmd_test=(
    "rustc" "rustup" "cargo"
    "go" "deno" "node"
    "npm" "code" "nvim"
    "git" "alacritty"
)
for element in "${cmd_test[@]}"; do
    detect "$element"
done

# Detect NVM
retcode=$(nvm --version)
if test $? -eq 0; then
    log "info" "NVM installed"
else
    log "error" "NVM not installed"
fi

# setup alacritty config
if [ -d "$HOME/.config/alacritty/" ]; then
    log "warn" "alacritty has config"
    echo "Override exists config (Y/N):"
    read opt
    case $opt in
    "Y")
        mkdir -p ~/.conifg/alacritty/
        cp -r ./alacritty/* ~/.config/alacritty/
        log "info" "alacritty config set success"
        ;;
    "N")
        echo "alacritty keep original config"
        ;;
    *)
        echo "Invalid option, keep original config"
        ;;
    esac
else
    mkdir -p ~/.conifg/alacritty/
    cp -r ./alacritty/* ~/.config/alacritty/
    log "info" "alacritty config set success"
fi

# setup nvim config
if [ -d "$HOME/.config/nvim/" ]; then
    log "warn" "nvim has config"
    echo "Override exists config (Y/N):"
    read opt
    case $opt in
    "Y")
        mkdir -p ~/.conifg/alacritty/
        cp -r ./nvim/* ~/.config/nvim/
        log "info" "nvim config set success"
        ;;
    "N")
        echo "nvim keep original config"
        ;;
    *)
        echo "Invalid option, keep original config"
        ;;
    esac
else
    mkdir -p ~/.conifg/alacritty/
    cp -r ./alacritty/* ~/.config/nvim/
    log "info" "nvim config set success"
fi

# starship
if [ -f "$HOME/.config/starship.toml" ] && [ -s "$HOME/.config/starship.toml" ]; then
    log "warn" "starship config file exists"
    echo "Override exists config (Y/N):"
    read opt
    case $opt in
    "Y")
        rm ~/.config/starship.toml && cp ./starship.toml ~/.config/
        log "info" "starship config success"
        ;;
    "N")
        echo "starship keep original config"
        ;;
    *)
        echo "Invalid option, keep original config"
        ;;
    esac
else
    cp ./starship.toml ~/.config/
    log "info" "starship config success"
fi

# latexmk
if test -f "$HOME/.bashrc" && grep -q "LATEXMKRCSYS" "$HOME/.bashrc"; then
    echo "LATEXMKRCSYS env var exists"
else
    echo "export LATEXMKRCSYS=$HOME/.config/latexmk" >>~/.bashrc
    log "info" "LATEXMKRCSYS write in bashrc"
fi

if [ -f "$HOME/.config/latexmk" ]; then
    log "warn" "latexmk config file exists"
    echo "Override exists config (Y/N):"
    read opt
    case $opt in
    "Y")
        rm ~/.config/latexmk && cp ./latexmk ~/.config/
        log "info" "latexmk config success"
        ;;
    "N")
        echo "latexmk keep original config"
        ;;
    *)
        echo "Invalid option, keep original config"
        ;;
    esac
else
    cp ./latexmk ~/.config/
    log "info" "latexmk config success"
fi

# Git alias
if test -f "$HOME/.bashrc" && grep -q "~/.git-alias" "$HOME/.bashrc"; then
    echo "git-alias is ok"
else
    echo "source ~/.git-alias" >>~/.bashrc
    log "info" "git alias write bashrc ok"
fi

if [ -f "$HOME/.git-alias" ]; then
    log "warn" "git alias file exists"
    echo "Override exists config (Y/N):"
    read opt
    case $opt in
    "Y")
        rm ~/.git-alias && cp ./git/git-alias ~/.git-alias
        chmod +x ~/.git-alias
        log "info" "git alias set success"
        ;;
    "N")
        echo "git aliass keep original config"
        ;;
    *)
        echo "Invalid option, keep original config"
        ;;
    esac
else
    cp ./git/git-alias ~/.git-alias
    chmod +x ~/.git-alias
    log "info" "git alias config success"
fi
