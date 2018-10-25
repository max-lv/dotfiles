

function echo_run
    echo "Running alias for :: `$argv`"
    echo ""
    eval $argv
end


# Aliases
alias aur="trizen"
alias supac="sudo pacman"
alias pacfd="pacman -Ss"
alias aur_remove_orphans="trizen -Rns (trizen -Qtdq)"
alias pf="echo_run pacman -Ss"
alias pr="echo_run sudo pacman -Rs"
alias pi="echo_run sudo pacman -S"
alias pu="echo_run sudo pacman -Syu"

setxkbmap us,ru -option 'grp:alt_shift_toggle'

export PATH="~/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

# if command -v pyenv 1>/dev/null 2>&1
#     eval (pyenv init -)
#     eval (pyenv virtualenv-init -)
# end


# pyenv init - output

# set -gx PATH '/home/terra/.pyenv/shims' $PATH
# set -gx PYENV_SHELL fish
# source '/home/terra/.pyenv/libexec/../completions/pyenv.fish'
# command pyenv rehash 2>/dev/null
# function pyenv
#   set command $argv[1]
#   set -e argv[1]

#   switch "$command"
#   case rehash shell
#     source (pyenv "sh-$command" $argv|psub)
#   case '*'
#     command pyenv "$command" $argv
#   end
# end