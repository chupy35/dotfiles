# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/chupy35/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#
#ZSH_THEME="imp"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs status root_indicator battery time background_jobs)
POWERLEVEL9K_BATTERY_STAGES=($'\u2581 ' $'\u2582 ' $'\u2583 ' $'\u2584 ' $'\u2585 ' $'\u2586 ' $'\u2587 ' $'\u2588 ')
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰──▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭─"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
# Enable caching of parts of the prompt to make rendering much faster.
POWERLEVEL9K_USE_CACHE=true
# Enable alternative implementation for the vcs prompt. It's much faster but it only supports git.
# Tell it to not scan for dirty files in repos with over 4k files.
# Adjust this path depending on where you normally source powerlevel9k.zsh-theme from.


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

stty -ixon
[[ -e "$HOME/.config/dir_colours" ]] && eval $(dircolors -b "$HOME/.config/dir_colours")

autoload -U compinit && compinit
autoload -U colors && colors
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
#export DRI_PRIME=1
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
##export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
#export VDPAU_DRIVER=va_gl
#export QT_DEVICE_PIXEL_RATIO=0
export MSF_DATABASE_CONFIG='/home/chupy35/.msf4/database.yml' 
export NO_AT_BRIDGE=1
export MOZ_USE_XINPUT2=1

setopt correct
setopt extended_glob
setopt extended_history share_history
setopt hist_find_no_dups hist_ignore_dups hist_verify
setopt prompt_subst
setopt autocd

nplayer () (nc -kluw 1 127.0.0.1 5555 > /tmp/mpd.fifo & trap "kill $!" EXIT; ncmpcpp)
#export WORKON_HOME=~/.virtualenvs

#source /usr/bin/virtualenv
# }}}
# History {{{
# -----------------------------------------------------------------------------

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.logs/zhistory"

# }}}
# Completion {{{
# -----------------------------------------------------------------------------


zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# autocorrect
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*' original only
# increase max-errors based on length of word
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# kill
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) ([0-9a-z-]#)*=$color[green]=0=$color[black]"

# }}}
# Keybindings {{{
# -----------------------------------------------------------------------------

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${terminfo[kich1]}" ]] && bindkey "${terminfo[kich1]}" quoted-insert # Ins
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char # Del
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line # Home
[[ -n "${terminfo[kend]}" ]] && bindkey "${terminfo[kend]}" end-of-line # End
[[ -n "${terminfo[kpp]}" ]] && bindkey "${terminfo[kpp]}" beginning-of-history # PgUp
[[ -n "${terminfo[knp]}" ]] && bindkey "${terminfo[knp]}" end-of-history # PgDn
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down
[[ -n "${terminfo[kcub1]}" ]] && bindkey "${terminfo[kcub1]}" backward-char # Left
[[ -n "${terminfo[kcuf1]}" ]] && bindkey "${terminfo[kcuf1]}" forward-char # Right
[[ -n "${terminfo[kcbt]}" ]] && bindkey "${terminfo[kcbt]}" reverse-menu-complete # S-Tab

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey ' ' magic-space
bindkey '^?' backward-delete-char
bindkey -M viins '^N' down-line-or-beginning-search
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd '^R' redo
bindkey -M vicmd 'u' undo
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd '?' history-incremental-search-backward

# }}}
# Aliases {{{
# -----------------------------------------------------------------------------
alias cower="cower -c -v"
alias njugar="vblank_mode=0 primusrun"
alias scrotc="scrot  ~/foo.png && loliclip -bi image/png < foo.png && rm ~/foo.png"
alias grep="grep --color=auto"
alias ix="curl -n -F 'f:1=<-' http://ix.io"
alias ll="ls++"
alias music="ncmpcpp"
alias telegram="telegram -s /home/chupy35/tg-notify-bash/notify.lua -N"
alias ls="ls -hF --color=auto --group-directories-first"
alias luksmount="sudo cryptsetup luksOpen /dev/sde1 luksusb && sudo mount -o gid=100,fmask=113,dmask=002 /dev/mapper/luksusb /mnt/usb"
alias luksumount="sudo umount /mnt/usb && sudo cryptsetup luksClose /dev/mapper/luksusb"
alias ntfsmount="sudo ntfs-3g -o gid=100,fmask=113,dmask=002 /dev/sde1 /mnt/usb"
alias range="urxvtc -name ranger -e ranger"
alias rra="sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -j REDIRECT"
alias rrd="sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -j REDIRECT"
alias so="scrot -cd 3 ~/pictures/tmp.png && ompload ~/pictures/tmp.png"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias tm="urxvtc -name chatmail -e tmux attach-session -d -t 0"
alias usbmount="sudo mount -o gid=100,fmask=113,dmask=002 /dev/sde1 /mnt/usb"
alias usbumount="sudo umount /mnt/usb"
alias msfconsole="msfconsole --quiet -x \"db_connect root@msf\""
alias lastfiles="/home/chupy35/scripts/recentfiles.sh"
##shortcuts##
alias hh="cd /home/chupy35/"
alias ply="cd /home/chupy35/polymtl/"
alias dw="cd /home/chupy35/Descargas/"
alias img="cd /home/chupy35/imagenes/"
alias mu="cd /home/chupy35/Music/"
alias dbx="cd /home/chupy35/Dropbox/"
alias vid="cd /home/chupy35/Vídeos/"
alias sshr1="ssh 132.207.28.119"
alias sshr2="ssh 132.207.170.60"

# }}}
# Extract {{{
# https://github.com/sorin-ionescu/prezto/blob/master/modules/archive/functions/extract
# -----------------------------------------------------------------------------

function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
cat >&2 <<EOF
usage: $0 [-option] [file ...]

options:
-r, --remove remove archive
EOF
  fi

remove_archive=1
  if [[ "$1" == "-r" || "$1" == "--remove" ]]; then
remove_archive=0
    shift
fi

while (( $# > 0 )); do
if [[ ! -s "$1" ]]; then
print "$0: file not valid: $1" >&2
      shift
continue
fi

success=0
    file_name="${1:t}"
    extract_dir="${file_name:r}"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar e -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*)
        print "$0: cannot extract: $1" >&2
        success=1
      ;;
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
done
}

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi

        export http_proxy="http://$1/"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        echo "Proxy environment variable set."
        return 0
    fi

    echo -n "username: "; read username
    if [[ $username != "" ]]; then
        echo -n "password: "
        read -es password
        local pre="$username:$password@"
    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    export http_proxy="http://$pre$server:$port/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export RSYNC_PROXY=$http_proxy
}

function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset rsync_proxy
    echo -e "Proxy environment variable removed."
}

function sproxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://axtel.finanzas.cdmx.gob.mx/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    echo "Proxy environment variable set."
    return 0
    server="axtel.finanzas.cdmx.gob.mx"
    port="3128"
    echo -n "server: "; read server
    echo -n "port: "; read port
    export http_proxy="http://$server:$port/"
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export FTP_PROXY=$http_proxy
    export RSYNC_PROXY=$http_proxy
}



# }}}



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#
#[[ -s "$HOME/.rvm/rubies/ruby-2.3.1/bin/" ]] && source "$HOME/.rvm/rubies/ruby-2.3.1/bin/"
#export PATH="${PATH}:$(ruby -e "puts Gem.user_dir")/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# WAL and colorscheme
#
# # Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.

wal-tile() {
    wal -n -i "$@"
    feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
}

