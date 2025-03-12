# Add sane warnings to GCC and Clang
abbr --add --global --command={clang,gcc} warn -- "-Wall -Wextra"

# Make usage of `emerge` easier
abbr --add emerge "sudo emerge"
abbr --add update "sudo emerge --update --changed-use @world"

# Use different commands but write the same commands
abbr --add ls "eza"
abbr --add lss "eza -hgoal --git --icons --time-style long-iso --no-user"
abbr --add cd "z"

# Use neovim as vim (easier to write)
abbr --add vim "nvim"
