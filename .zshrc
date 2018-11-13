#
# ~/.zshrc
#

# Options {{{
# -----------------------------------------------------------------------------
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
zstyle ':completion:*:*:kill:*' force-list always

# }}}
# Prompt {{{
# -----------------------------------------------------------------------------

# -----------------------
# Colors in TTY (Zenburn)
# -----------------------
if [[ $TERM == "linux" ]]; then
echo -en "\e]P01e2320" # zen-black (norm. black)
echo -en "\e]P8709080" # zen-bright-black (norm. darkgrey)
echo -en "\e]P1705050" # zen-red (norm. darkred)
echo -en "\e]P9dca3a3" # zen-bright-red (norm. red)
echo -en "\e]P260b48a" # zen-green (norm. darkgreen)
echo -en "\e]PAc3bf9f" # zen-bright-green (norm. green)
echo -en "\e]P3dfaf8f" # zen-yellow (norm. brown)
echo -en "\e]PBf0dfaf" # zen-bright-yellow (norm. yellow)
echo -en "\e]P4506070" # zen-blue (norm. darkblue)
echo -en "\e]PC94bff3" # zen-bright-blue (norm. blue)
echo -en "\e]P5dc8cc3" # zen-purple (norm. darkmagenta)
echo -en "\e]PDec93d3" # zen-bright-purple (norm. magenta)
echo -en "\e]P68cd0d3" # zen-cyan (norm. darkcyan)
echo -en "\e]PE93e0e3" # zen-bright-cyan (norm. cyan)
echo -en "\e]P7dcdccc" # zen-white (norm. lightgrey)
echo -en "\e]PFffffff" # zen-bright-white (norm. white)
fi

# ------
# Prompt 
# ------
function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
        ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    if which ibam > /dev/null; then
    PR_APM_RESULT=`ibam --percentbattery`
    elif which apm > /dev/null; then
    PR_APM_RESULT=`apm`
    fi
}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    
    ###
    # Decide if we need to set titlebar text.
    
    case $TERM in
    xterm*)
        PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
        ;;
    screen)
        PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
        ;;
    *)
        PR_TITLEBAR=''
        ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
    PR_STITLE=$'%{\ekzsh\e\\%}'
    else
    PR_STITLE=''
    fi
    
    
    ###
    # APM detection
    
    if which ibam > /dev/null; then
    PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
    elif which apm > /dev/null; then
    PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
    else
    PR_APM=''
    fi
    
    
    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(\
$PR_BLUE%(!.%SROOT%s.%n)$PR_BLUE@%m:%l\
$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%$PR_PWDLEN<...<%~%<<\
$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT\

$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_CYAN:)\
${(e)PR_APM}$PR_BLUE%D{%H:%M}\
$PR_LIGHT_CYAN:%(!.$PR_RED.$PR_WHITE)%#$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN> '

    RPROMPT=' $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR$PR_SHIFT_OUT\
($PR_BLUE%D{%a,%b%d}$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

    PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt


# }}}
# Title {{{
# -----------------------------------------------------------------------------

case "$TERM" in
  (x|a|ml|dt|E)term*|(u|)rxvt*)
    precmd () { print -Pn "\e]0;%n@%M:%~\a" }
    preexec () { print -Pn "\e]0;%n@%M:%~ ($1)\a" }
    ;;
  screen*)
    precmd () {
      print -Pn "\e]83;title - \"$1\"\a"
      print -Pn "\e]0;%n@%M:%~\a"
    }
    preexec () {
      print -Pn "\e]83;title - \"$1\"\a"
      print -Pn "\e]0;%n@%M:%~ ($1)\a"
    }
    ;;
esac

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
