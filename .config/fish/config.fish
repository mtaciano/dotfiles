# Start zoxide
zoxide init fish | source

# Fish git prompt
set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_hide_untrackedfiles 1
set __fish_git_prompt_showstashstate 1
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_describe_style branch
set __fish_git_prompt_showupstream informative
set __fish_git_prompt_char_upstream_ahead ↑
set __fish_git_prompt_char_upstream_behind ↓
set __fish_git_prompt_char_upstream_prefix ""
set __fish_git_prompt_char_stagedstate +
set __fish_git_prompt_char_dirtystate !
set __fish_git_prompt_char_untrackedfiles ?
set __fish_git_prompt_char_conflictedstate x

# Global Variables
set -x GPG_TTY $(tty)
set -x FZF_DEFAULT_OPTS --cycle

# Path
fish_add_path "$HOME/.cargo/bin"

# SSH sock location
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/keyring/ssh"
