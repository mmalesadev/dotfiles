#!/bin/zsh

# find socket file
find_socket() {
    if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
        socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
        [[ -S "$socket" ]] && print -- "$socket" && return 0
    fi

    # fallback: pick the first socket2.sock under $XDG_RUNTIME_DIR/hypr/*
    for d in "$XDG_RUNTIME_DIR"/hypr/*(.N); do
        candidate="$d/.socket2.sock"
        [[ -S "$candidate" ]] && print -- "$candidate" && return 0
    done

    return 1
}

socket_file="$(find_socket)" || {
    echo "Could not find Hyprland socket2.sock under $XDG_RUNTIME_DIR/hypr" >&2
    exit 3
}

# Function with keybindings for a web browser
bind_browser_keys() {
    hyprctl keyword bind 'ALT, H, sendshortcut, CTRL, page_up,'
    hyprctl keyword bind 'ALT, L, sendshortcut, CTRL, page_down,'
    hyprctl keyword bind 'ALT, Q, sendshortcut, CTRL, W,'
    hyprctl keyword bind 'ALT, T, sendshortcut, CTRL, T,'
}

# Function with keybindings for OTS
bind_ots_keys() {
    hyprctl keyword bind ', mouse:276, sendshortcut, , F2,'
    hyprctl keyword bind ', mouse:275, sendshortcut, , F1,'
    hyprctl keyword bind ', mouse:274, sendshortcut, , F3,'
}

# This function should unbind all custom binds that were set per-window
unbind_all_keys() {
    hyprctl keyword unbind 'ALT, H'
    hyprctl keyword unbind 'ALT, L'
    hyprctl keyword unbind 'ALT, Q'
    hyprctl keyword unbind 'ALT, T'
    hyprctl keyword unbind ', mouse:276'
    hyprctl keyword unbind ', mouse:275'
    hyprctl keyword unbind ', mouse:274'
}

handle() {
    echo "$1"
    case $1 in
    'activewindow>>firefox'*)
        unbind_all_keys
        bind_browser_keys
        ;;
    'activewindow>>miracle'*)
        unbind_all_keys
        bind_ots_keys
        ;;
    'activewindow>>'*)
        unbind_all_keys
        ;;
    esac
}

socat -U - UNIX-CONNECT:$socket_file | while read -r line; do handle "$line"; done
