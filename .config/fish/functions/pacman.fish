# Remove the need to type `sudo` before `pacman`
# while needing to use `sudo` only for the commands that require it
function pacman -w pacman
    switch $argv[1]
        case -D '-R*' '-U*' -S '-Sc*' '-Sd*' '-Su*' '-Sw*' '-Sy*'
            /usr/bin/sudo /usr/bin/pacman $argv
        case '*'
            /usr/bin/pacman $argv
    end
end
