# Command that makes git suitable to manage dotconfigs
function dotconf -w git --description "Manage dotconfigs with git"
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
