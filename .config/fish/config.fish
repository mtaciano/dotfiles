# Start zoxide
zoxide init fish | source

# Setup git prompt
set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_showupstream "git"
set __fish_git_prompt_showstashstate true
set __fish_git_prompt_describe_style "branch"
set __fish_git_prompt_showcolorhints true
set __fish_git_prompt_char_stateseparator "|"
set __fish_git_prompt_char_cleanstate ""
set __fish_git_prompt_char_dirtystate "!"
set __fish_git_prompt_char_invalidstate "x"
set __fish_git_prompt_char_stagedstate "+"
set __fish_git_prompt_char_stashstate "\$"
set __fish_git_prompt_char_untrackedfiles "?"
set __fish_git_prompt_char_upstream_ahead "↑"
set __fish_git_prompt_char_upstream_behind "↓"
set __fish_git_prompt_char_upstream_diverged "<>"
set __fish_git_prompt_char_upstream_equal "="
set __fish_git_prompt_char_upstream_prefix ""

# Global Variables
set -x GPG_TTY $(tty)
set -x FZF_DEFAULT_OPTS --cycle
