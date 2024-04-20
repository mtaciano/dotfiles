# Add sane warnings to GCC and Clang
abbr -a -g clang 'clang -Wall -Wextra'
abbr -a -g gcc 'gcc -Wall -Wextra'

# Make usage of `emerge` easier
abbr -a -g emerge 'sudo emerge --ask'
abbr -a -g emerge-update 'sudo emerge --ask --verbose --update --deep --changed-use @world'

# Use different commands but write the same commands
abbr -a -g ls 'eza'
abbr -a -g lss 'eza -hgoal --git --icons --time-style long-iso --no-user'
abbr -a -g cd 'z'

# Use neovim as vim (easier to write)
abbr -a -g vim 'nvim'
