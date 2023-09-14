# Remove the need to type `sudo` before `pacman`
# while invoking `sudo` only for the commands that require it
function pacman -w pacman
    switch $argv[1]
        case -D '-R*' '-U*' -S '-Sc*' '-Sd*' '-Su*' '-Sw*' '-Sy*'
            sudo pacman $argv
        case '*'
            pacman $argv
    end
end
