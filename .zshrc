# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSnap
# Download Znap, if it's not there yet.
[[ -r ~/repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/repos/znap
source ~/repos/znap/znap.zsh  # Start Znap

# `znap source` starts plugins.
znap source marlonrichert/zsh-autocomplete
znap source marlonrichert/zsh-autosuggestions

# `znap eval` makes evaluating generated command output up to 10 times faster.
# znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# `znap install` adds new commands and completions.
znap install aureliojargas/clitest

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

zv (){
    z "$@"  # Pass all arguments to z
    nvim
}
ports (){
	fuser -k "$1"/tcp
}

export HISTFILE=~/.zsh_history
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
export PATH=${PATH}:~/.guard/bin:~/.local/bin
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=hyprland
export UID GID
export DOCKER_HOST=unix:///run/user/1000/docker.sock

# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

alias config='/usr/bin/git --git-dir=/home/harith/.cfg/ --work-tree=/home/harith'

# Git aliases
alias ga='git add'
alias gc='git commit -v'
alias gd='git diff'
alias gst='git status'

alias gco='git checkout'
alias gcm='git checkout main'
alias gcd='git checkout develop'
alias gpm='git pull origin main --rebase'
alias gpd='git pull origin develop --rebase'
alias gcp='git checkout @{-1}'

alias gb='git branch'
# view remote branches
alias gbr='git branch --remote'

alias gup='git pull'
alias gp='git push'
# push a newly created local branch to origin
alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias ll='ls -la'
alias j='z'
alias v='nvim'
alias g='git'
alias c="printf '\033[2J\033[3J\033[1;1H\'"
alias up="j devops && docker compose up --build"

# User Key Bindings
bindkey -s "^y" "fzf --preview 'bat --style=numbers --color=always {}'^M"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
# key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
# [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
# [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Setup NVM
source /usr/share/nvm/init-nvm.sh

# Start zoxide
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# Auto complete config
bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
# bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char

# Auto suggestions config
# bindkey '^I' autosuggest-accept

eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/p1_gh > /dev/null 2>&1

# NNN config
# U: show file's owner and group in status bar
export NNN_OPTS=deuU
export NNN_PLUG="v:imgview;c:fzcd;d:diffs;h:fzhist;k:pskill;m:nmount;o:fzopen;p:fzplug;t:preview-tui;z:autojump;"
# export NNN_BMS="d:$HOME/Downloads/;c:$HOME/.local/share/chezmoi/;v:$HOME/.config/nvim/"
export NNN_BATSTYLE="changes,numbers"
export NNN_BATTHEME=base16
export NNN_FIFO="/tmp/nnn.fifo"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/harith/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/harith/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/harith/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/harith/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/home/harith/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
