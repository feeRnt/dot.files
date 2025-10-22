#$HOME/.bashrc

# ~/.bashrc: executed by bash(1) for non-login shells. see 
# /usr/share/doc/bash/examples/startup-files (in the package bash-doc) 
# for examples

# # Manual USER variable definition if $USER doesn't resolve as
# expected, for the scripts in this file
# USER=username

# If not running interactively, don't do anything
# If there is "i" in the shell properties,
# then don't return (don't exit this config file before finishing)
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth
HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000
HISTSIZE=-1
HISTFILESIZE=-1

#also check /etc/bash.bashrc


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# Green user@host, white :, blue directory, white $, space
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #PS1="\[\e]0;hello \a\]$PS1" works
    #PS1="\[\e] hello \a\]$PS1" doesn't work
    #PS1="\[\e]0 hello \a\]$PS1" doesn't work
    #PS1="\[\e]0; hello \a\]$PS1"
    #PS1="\[\e]0; "$(date +"%F %H_%M_%S")" \a\]$PS1" 
    
    # When the PS1 sets the title, any attempt to set the title using a command or PROMPT_COMMAND will
    # fail, since the prompt is printed after all of them. For this reason, I prefer to keep a simple prompt
    # while testing titles (PS1=$; unset PROMPT_COMMAND). -- muru , https://askubuntu.com/users/158442/muru

    # Anything inside [] is not printed by the shell.
    ;;
*)
    ;;
esac
#mark
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
## color in diff
    alias diff='diff --color=always'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# # File path variables for easy access
# Added a `source ~/.bashrc_paths` including all the file paths. 
# For privacy, Jul '25
#
source ~/.bashrc_paths

# # Secret temporary variables, saved elsewhere for privacy, Jul '25
source ~/.bashrc_secrets

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# # set console blank to 2 minutes if in terminal 2: July 16, 2025, 04:04:06

if [ "$(tty)" == "/dev/tty2" ] || [ "$(tty)" == "/dev/tty3" ]; then
	echo "Setting console blank timer to 2 minutes."
	setterm --blank 2
fi

# # Write out dmesg on login for testing: Aug 11, 2025
# if [ -z "$(ls $HOME/dmesgs/dmesg_`uname -r`* 2>/dev/null)" ]; then
#	dmesg > "$HOME/dmesgs/dmesg_`uname -r`_`date +%y-%m-%d_%H-%M-%S`"
#fi
#this doesn't work for some reason. With [ or [[, different placements of * as well
# Wait it works with single [, and * outside the ""
# dmesgs/dmesg_5.15.15-obsidianx-2.5.9_BELIZE_ps4_drm_info_25-08-12_18-08-36: binary operator expected
# Because it expands to two items, with [ ! -f "...`uname -r`"* ]


# manually dump the dmesg if desired , Aug 2025
dmesg_dump() {
	dmesg > "$HOME/dmesgs/dmesg_`uname -r`_`date +%y-%m-%d_%H-%M-%S`"
}

#alias settime="$scripts/settime.sh"
#putting only a file path doesn't seem to work with alias.
#need to specify a file path in a VARIABLE.
#or use ls /path/to/file in an alias so it outputs the path to stdout?

# didnt work ^

settime="$scripts/settime.sh"
#this works yay!
#e2fsck next boot

#alias setdns=echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf
#fuck an alias

# # Add default repo to gh-cli, Jul 17, 2025
# Repo is defined in ~/.bashrc_secrets
gh-def() {
	if [ ! -d ./.git ]; then
		gh $@ -R $repo
	else
		gh $@
	fi;
}
	
setdns() {
echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf
}


# Jul 9 ,2024
alias netstatt='netstat -apn | grep -e tcp -e udp'
#alias netstat -a
#Jul 15, 2024
alias netstatts='sudo netstat -nap | grep -e tcp -e udp'
#Mar, 2025
#alias 'git commit --amend'='git commit -S --amend'
#invalid alias name, both double or single quotes


# Alias git to have UTC TimeZone: Jul, 2025
alias git='TZ=UTC /usr/bin/git' 

#ANDROID_HOME="$_android_home"
# This is in /etc/environment already, otherwise it doesn't really work?

PATH=$PATH:/home/$USER/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$ANDROID_HOME/cmdline-tools/latest:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# myfunction() {
    #do things with parameters like $1 such as
 #   mv "$1" "$1.bak"
 #   cp "$2" "$1"
# }

commited_nosign() {
	TZ=UTC git -c core.fileMode=false commit -m "$1"
}

commited() {
	TZ=UTC git -c core.fileMode=false commit -S -m "$1"
}
# # Git commit amend, March '25
gitamend() {
	git commit -S --amend
}

## checkstyle fix 2"
#error: pathspec 'fix' did not match any file(s) known to git
#error: pathspec 'for' did not match any file(s) known to git
#error: pathspec 'remote' did not match any file(s) known to git
#error: pathspec 'playlist' did not match any file(s) known to git
#error: pathspec 'sorting.' did not match any file(s) known to git
#error: pathspec 'checkstyle' did not match any file(s) known to git
#error: pathspec 'fix' did not match any file(s) known to git
#error: pathspec '2' did not match any file(s) known to git

# so need quotes around $1 I guess

# Aug 26, 2024

#R_LIBS=/home/$USER/R/x86_64-pc:$R_LIBS
#Putting this here doesn't work. Doesn't show up in env or export. Put in /etc/environment.

# # Generate password in linux terminal, Nov 16, 2024
# param 1  = length of password
passgen() {
	
	LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-.:;<=>?@[]^_`{|}~' </dev/random | head -c $1; echo

}

# # sftp home, Oct ~9

sftphome () {
#_port=sed -n '2
sftp -P "$def_ftp_port" "$def_ftp"
}

# # Markdown to html; for easy viewing, Oct 17
function mdhtml() {
  pandoc $1 > /tmp/$1.html
  xdg-open /tmp/$1.html
}
#huh, apparently firefox opens the links in the md this way... that's so weird.

# # mpv player with profile = noloop 
##function mpvn() {
##  mpv --profile=noloop  
###

function echotesters() {
  echo ""$@" this is the ultimate bob
  separation, but we'll connect one day" "$@"
}

# output: 
#$USER@pop-os:~$ echotesters 1st 2th 3rd ffff
#1st 2th 3rd ffff this is the ultimate bob
#  separation, but we'll connect one day 1st 2th 3rd ffff

function echotesters2() {
  echo ""
}


function mpvyt () {
	if [[ -z "$(echo $1 | grep http)" ]]; then
  		mpv https://youtu.be/$1 --ytdl-format="137+140"
	else
		mpv $1 --ytdl-format="137+140"
	fi;
}

# # easy Math in Bash, Oct 21

#function math() {
 # echo "$(( $@ ))"
#}
#doesn't work with floats, check $help set, $help shopt for noglob. -o enables, +o 
#disables. If you don't disable, then the the terminal will have noglob after math

math() {
  set -o noglob
  #echo -n $* 
 #bc -lw <<< "$(echo "$*")"
  bc -lw <<< "$(echo "$@")"
  set +o noglob
 # bc -l <<< "$(echo "$@")"
# The reason noglob has no effect in this function when invoking it is because when
# you are calling the function from bash, glob is already set. So your *s are
# expanded regardless of what is done inside the function. The expansion comes in
# the invokation not the execution.
} 

glob() {
  set -o noglob
  echo *
  echo this is 1 $1
  echo this is 2 $2
  echo this is at $@
  echo this is star $*
#$USER@pop-os:~/bccccc$ glob *
#*
#this is 1 *
#this is 2
#this is at *
#this is star *

  echo "statting *"
  stat <<< echo *
  
  echo "statting dollar 1"
  stat <<< echo $1

  echo "statting dollar at"
  stat <<< echo $@

  echo "statting dollar star"
  stat <<< echo $*
#stat: cannot statx '*': No such file or directory , times 3

  bc -l <<< echo 3 + 4
  echo -e \n
  bc -l <<< echo 3 * 4
  echo -e \n
  bc -l <<< echo $1
  echo -e \n
  bc -l <<< echo $1 $2 $3
  echo -e \n
  bc -l <<< echo $@
  echo -e \n
  bc -l <<< echo $*
#no work. this is a bc thing.
#$USER@pop-os:~/bccccc$ bc <<< echo 2+2
#File 2+2 is unavailable.

# $USER@pop-os:~/bccccc$ bc <<< "$(echo 2 * 2)"
# 4

#$USER@pop-os:~/bccccc$ bc <<< "$(echo 2 < 2 < 2)"
#bash: 2: No such file or directory
#$USER@pop-os:~/bccccc$ bc <<< "$(echo "2 < 2 < 2")"
#1

#all with no glob


#$USER@pop-os:~/bccccc$ bc <<< "$(echo "2 = 2 = 2")"
#(standard_in) 1: syntax error
#this is bc error.

echo "last line"
bc -l <<< "$(echo "$@")"

# works, but needs noglob
}

glob2() {
  "$(echo "$*")"
  "$(echo "$@")"
}

glob3() {
 #echo "$@"
 #echo "$*"
  echo "$"@" "
  #echo "$*"

#$USER@pop-os:~/bccccc$ glob3 (hello\)
#bash: syntax error near unexpected token `hello\)'

#$USER@pop-os:~/bccccc$ glob3 \(hello\)
#(hello)
#(hello)

#but 

#$USER@pop-os:~/bccccc$ echo "(hell)"
#(hell)

###
#$USER@pop-os:~/bccccc$ glob3 
#$@ 
#$USER@pop-os:~/bccccc$ glob3 (hello)
#bash: syntax error near unexpected token `hello'
#$USER@pop-os:~/bccccc$ glob3 hello
#$@ 

#huh.. so it is a bash issue of not quoting the paramters. like if it was `firefox
#--eat-(everything) ` this wouldn't work because bash would interpret the brackets
#for itself. it is not a limitation of the script, but of the environment thru which
#	i invoked the script. arghhhh. why don't i stop to take breaks? :(

#example
#$USER@pop-os:~$ gedit --list-enc()dings
#bash: syntax error near unexpected token `('


}

ppoopple() {
	echo ' $@ '
}


# # Reverse a string using python3

reverse() {
	/bin/python3 -c print\("'$*'"\[::-1\]\)
				# "'"$@"'" is bad
				# "'$@'" is also bad
	}

# # Turn off monitor quick function, Oct 24

function offmons() {
	sleep 1; xset -display $DISPLAY dpms force off; read temp; xset -display $DISPLAY dpms force on;
}

# # Watch what files are open by firefox: quick function; Oct 28

firewatch() {
#	watch "ls -l /proc/"$(pidof firefox)"/fd | grep -e home | grep -v home/$USER/.mozilla"

#	for pid in "$(pidof firefox)"
#		do watch "ls -l /proc/"$pid"/fd | grep -e home | grep -v home/"$USER"/.mozilla"

#	_firewatch_pid_array="$(pidof firefox)"
#	for pid in "${_firewatch_pid_array[@]}" #all of them are not
#internally separated but as put as one string

	read -r -a _firewatch_pid_array <<< "$(pidof firefox)"
#	for pid in "${_firewatch_pid_array[@]}"
#		do watch "ls -l /proc/"$pid"/fd | grep -e home | grep -v home/"$USER"/.mozilla"
	#works but have to hit q to check the next pid's ls
	#_firewatch_pid_array_i="${#_firewatch_pid_array[@]}
	IFS=','
	_firewatch_pid_string="$(echo "${_firewatch_pid_array[*]}")" #note *
	unset IFS
	watch "ls -l /proc/{"$_firewatch_pid_string"}/fd | grep -e home | grep -v -e /home/"$USER"/.mozilla -e /home/"$USER"/.cache" 
}

# # Watch open files of any process; Dec 20

procwatch() {
	watch "ls -l /proc/"$(pidof $1)"/fd | grep -e home "
}

# # Nightlight temperature function; Dec 29:

nightlightset() {
	gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "$*"
}
<<'Explanation'
from 4700 (no nightlight) to 1700 (full nightlight)
use get as in ::
gsettings get org.gnome.settings-daemon.plugins.color night-light-temperature
to find the current value of nightlight
Explanation


# # Refresh Virtual mic interface connected to an app, Dec 30
micrefresh() {
	pw-link "VLC media player (LibVLC 3.0.16):output_FL" my-appaudio-sink:playback_FL
	pw-link "VLC media player (LibVLC 3.0.16):output_FR" my-appaudio-sink:playback_FR
}
# we need to clarify this function, but for now this is okay.

# # Refresh Virtual mic sink for a specific app, Dec 30
micrefreshapp() {
	pw-link "$1:output_FL" my-appaudio-sink:playback_FL
	pw-link "$1:output_FR" my-appaudio-sink:playback_FR
}

# # Redshift eye saver , February 20th, 2025

red() {
	redshift -O $1
}

# # Turn on monitor , February 21, 2025

monmon() { 
	xrandr --output HDMI-0 --mode 1920x1080
}

# # Restart pipewire, pulse , audio stuffs, February 23, 2025

restart_audio() {
	systemctl --user restart pipewire.socket
	systemctl --user restart pipewire-pulse.socket
	systemctl --user restart pipewire.service
	systemctl --user restart pipewire-pulse.service
}

# # Set up Virtual Mumble Microphone (mic input using Android Mumble),
# Feb 23, 2025

mumblemic() {
	mumblemic1 && mumblemic2
}

mumblemic1() {

	read -t 5 -p "Offscreen mumble? Type 'y' for yes. " _answer
	if [ "$_answer" == "" ] || [ "$_answer" == "y" ] || [ "$_answer" == "Y" ]; 
		then _OFFSCREEN="offscreen"
	elif [ "$_answer" == "n" ] || [  "$_answer" == "N" ];
		then _OFFSCREEN="xcb"
	else
		_OFFSCREEN="xcb" #cf.  https://stackoverflow.com/questions/21488072/what-is-the-use-of-various-qt-platform-plugins 
		#x11 platform
	fi;
	
	if [ "$(systemctl is-active mumble-server.service)" == "inactive" ];
		then echo "Starting mumble-server service.";
		sudo systemctl start mumble-server.service;
	else 
		echo 'mumble-server service already running. Continuing.'
	fi;

	if [ -n "$(pidof mumble-server)" ]; 
		then echo 'mumble-server is running. Continuing.'; 
	else 
#		echo "Starting mumble server..."
		mumble-server -ini $HOME/.config/Mumble/Mumble/mumble-server.ini -fg & echo "Starting mumble-server."
		sleep 1.5;
	fi;

	if [ -n "$(pidof mumble)" ]; then
		if [ -z "$(pactl list sink-inputs | grep "Mumble" -B 16 | sed  -nE 's|Sink Input #([0-9]*)|\1|p')" ]; then {
			sudo pkill mumble;
			sleep 0.5;
			mumble "mumble://127.0.0.1" -platform $_OFFSCREEN -c $HOME/.config/Mumble/Mumble/mumble_settings.json &>$HOME/Desktop/mumblemic_logs & echo 'Just restarted Mumble...'
	#		mumble "mumble://127.0.0.1" -c $HOME/.config/Mumble/Mumble/mumble_settings.json &>$HOME/Desktop/Mumblemic_logs & echo 'Just restarted Mumble...'
		}
		else 
			echo 'pactl has the Mumble sink input... Continuing'; 
		fi;
	else {
#	mumble "mumble://127.0.0.1" -platform offscreen &>$HOME/Desktop/Mumblemic_logs & echo ''
	mumble "mumble://127.0.0.1" -platform "$_OFFSCREEN" -c $HOME/.config/Mumble/Mumble/mumble_settings.json &>$HOME/Desktop/mumblemic_logs & echo 'Starting Mumble'

#	mumble "mumble://127.0.0.1" -c $HOME/.config/Mumble/Mumble/mumble_settings.json &>$HOME/Desktop/mumblemic_logs & echo 'Starting Mumble'
	}
	fi;
	sleep 1.2;

	# Mute the desktop in mumble so you can't hear anything on the phone
	#mumble rpc mute
	read -t 5 -p "Mute this desktop on Mumble? Type 'n' for no. " _answer2
	if [ "$_answer2" == "" ] || [ "$_answer2" == "y" ] || [ "$_answer2" == "Y" ]; 
		then mumble rpc mute;
	elif [ "$_answer2" == "n" ] || [  "$_answer2" == "N" ];
		then mumble rpc unmute;
	else
		echo -n ""
	fi;

	echo "Done. Call mumblemic2() next."
}



mumblemic2() {
	
	
	if [ -n "$(pactl list sinks short | grep MumbleSelfSink)" ]; then
		echo 'MumbleSelfSink already exists. Continuing.';
	else {
		pw-loopback --capture-props='media.class=Audio/Sink node.name=MumbleSelfSink node.description="MumbleSelfSink"' & echo 'Just set up MumbleSelfSink'
		#node.description is the node name in qpwgraph. Using pactl instead of pw-loopback causes audio detection issues
	
		sleep 2;
		pactl set-sink-volume MumbleSelfSink 0 && echo "success" || echo "failure. need higher timeout."
		sleep 1;
	}
	fi;

	echo " "$(pactl list sink-inputs short)" ";
	ID="$(pactl list sink-inputs | grep "Mumble" -B 16 | sed  -nE 's|Sink Input #([0-9]*)|\1|p')"
	echo "pactl input is = $ID"
#	ID2="$(pactl list sink-inputs | grep "Mumble" -B 16)"
#	echo "$ID2"
	
	i=0;
	while  [ $i -lt 5 ]; 
		
		do 	
			if [ -z "$ID" ]; then {
				#sudo pkill mumble;
				#mumble "mumble://127.0.0.1" -platform offscreen &>$HOME/Desktop/Mumblemic_logs & echo 'restarting mumble'
				ID="$(pactl list sink-inputs | grep "Mumble" -B 16 | sed  -nE 's|Sink Input #([0-9]*)|\1|p')"
			(( i++ ))
			sleep 3.5;
			echo -e "Mumble doesn't have its app sink. Waiting and trying again.\n\
				This'll probably never work, attempt $i, just do mumblemic1..."
				}
			else {
				echo 'Mumble app sink app detected. Success! Link Mumble audio to MumbleSelfSink.'
				pactl move-sink-input $ID MumbleSelfSink
				pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=MumbleSelfSource
				break;
			}
			fi;
		done;
	# If you restart the audio stack (restart_audio() ), then Mumble needs
	# to be restarted otherwise ID will remain null
	 
	
	sleep 0.5;
	echo "Linking MumbleSelfSink with MumbleSelfSource (the microphone output source)."
	pw-link MumbleSelfSink:monitor_FL MumbleSelfSource:input_FL
	pw-link MumbleSelfSink:monitor_FR MumbleSelfSource:input_FR

	echo "End of function."
}
 
# # Redshift with preset configuration file, quick function,February 28, 2025

redshaft() {
	if [[ -n "$XDG_CONFIG_HOME" ]]; then
		echo "Using $XDG_CONFIG_HOME"
		redshift -vc "$XDG_CONFIG_HOME"/redshift.conf
	else
		echo "\$XDG_CONFIG_HOME is an empty string."
		echo "Using directory /home/$USER/.config ."
		redshift -vc "/home/$USER/.config/redshift.conf"
	fi
}

# # Shifting, March 3, 2025

to_binary() {
    printf "%b\n" "$(echo "obase=2; $1" | bc)"
}

# Left shift function:
left_shift() {
	value=$1
	shift_amount=$2
	result=$((value << shift_amount))
	echo "Left shift: $value << $shift_amount = $(to_binary $result)"
	}

# Right shift function:
right_shift() {
	value=$1
	shift_amount=$2
	result=$((value >> shift_amount))
	echo "Right shift: $value >> $shift_amount = $(to_binary $result)"
	}	

# # Find compressed kernel version string, March 4, 2025

kernstring() {
	strings $1 | grep -E "^[1-5]\.[0-9][0-9]*\.[0-9][0-9]*"
	}

# # Turn signed short to unsigned short, March 16, 2025
unsigshort_to_sigshort() {
input=$1
if [[ $input -lt "0" ]]; then
    output=$((65536+$input))
else
    output=$input
fi
echo $output
}

# # Copy UTF emoji to clipboard on xfce/gnome/X11/x server. Rofi, April 28 , 2025:: - spice.
emo() {
	emoji
}

emoji() {
	URL='https://www.unicode.org/Public/emoji/latest/emoji-test.txt'
	FILE="$HOME/.cache/emojis"
	
	if [ ! -f "$FILE" ]; then
	    curl -L "$URL" -o "$FILE"
	fi
	
	readarray -t DATA < <(grep "^[^#].*fully-qualified" "$FILE" | cut -d '#' -f2 | cut -d ' ' -f 2,4-10)
	SELECTED=$(printf '%s\n' "${DATA[@]}" | rofi -dmenu -i -p emoji)
	
	echo -en $SELECTED | awk 'BEGIN {ORS=""}; END {split($0,a); print a[1]}' | xclip -selection clipboard
}


# # HTML URL decode from encode-ing. eg. %2f to / , May 19, 2025
# https://stackoverflow.com/questions/6250698/how-to-decode-url-encoded-string-in-shell

html_decode_url() {
#	echo -n "$1" | python -c "import sys, urllib as ul; print ul.unquote(sys.stdin.read());"
	echo -n "$1" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
}

# # xdg - open shortcut function, May 24, 2025
open() {
	xdg-open "$@"
}

# # Random yes - no generator function, Jun 16, 2025
yesnogen() {
	#(cat /dev/random | base64 | grep -o -e Yes -e Noo > ~/.tempyesno & sleep 5) > /dev/null 2>&1; #this works but pid is not retrieved
	cat /dev/random | base64 | grep -o -e Yes -e Noo > ~/.tempyesno & sleep 5; 
	yesnopid="$!";
	echo "killing $yesnopid"; 
	kill -SIGKILL $yesnopid; 
	grep -i yes ~/.tempyesno | wc -l | xargs echo "Yes's ="; 
	grep -i no ~/.tempyesno | wc -l | xargs echo "No's = " 
	#"Noo" because then it is equal likelihood for both yes and no (same number of letters. = (1/x)^3 [x = number of characters possible through base64)
	#SIGKILL because SIGTERM will hog up /dev/random and base64
	rm ~/.tempyesno
}

# # Random yes - no generator function, Python version. Based on: ChatGPTJun 25, 2025
yesnogenpy() {
	python $scripts/yesnogen3.py
}


# # Add all ssh keys using ssh-add. Not a systemd service because that is risky. 
# # Only want through user invocation:  Jul 3 '25

ssh_add_all_keys() {
	
	_shoptcheck="$(shopt extglob | grep off)"
	if [ -n "$_shoptcheck" ]; then
		shopt -s extglob
	fi;
	ssh-add ~/.ssh/!(*.pub|.config|known_hosts*)
	
	if [ -n "$_shoptcheck" ]; then
		shopt -u extglob
	fi;

	_shoptcheck=''
}

# # Quick function for `git diff --cached`: Jul '24, 2025
gdfc() {
	git diff --cached
}

# # Quickly set the bash terminal title: Oct, 2025

# bind -x '"\C-t": echo -ne "\033]0;32m$(read -p "Title: " t < /dev/tty; echo $t)\007"'
#press ctrl+t to be propmpted

titlech() {
	#echo -ne "\e\033]0;32m$(read -p "Title: " t < /dev/tty; echo $t)\007"
	#$echo -ne "\e sdjlkfjlk \007"
	PS1_old='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]\$ '
    	unset PS1
	#PS1="\[\e]0; "$(date +"%F %H_%M_%S")" \a\]$PS1_old" (doesn't work)
	read -p "Title: " _title;
	PROMPT_COMMAND='echo -en "\033]0;$_title\a"'
	PS1="$PS1_old"
}

###############--------------- End of custom functions ----------------###############

# # !() : negative matching, exclude in wild card Oct 17

# shopt extglob (extended glob match. allows you to use !(name) in bash / wildcards ;
# check if it is set. If unset , do 
# shopt -s extglob
## example `ls !(dotfiles)` wiil list all files and dirs except "dotfiles"

# # Using tab for directory path variable autocompletion, Oct 17
shopt -s direxpand


# # Match hidden files in wildcard expansion (*)
shopt -s dotglob

testfunction33 () {
		nohup pw-loopback --capture-props='media.class=Audio/Sink node.name=Pooptest node.description="Pooptest"' & echo ''
	}

# =================

# # Do math in bash echo , ;;;;;
# echo "$(( 2 + 2 ))" can do left shifts

# # Do left shifting in binary in bash, March, 2025
#there is a better function up above

# printf "%x\n" $(( 1 << 15 )) $(( 1 < 2 ))
# the \n separates the two different inputs by a new line 
#%b or %B is supposed to be in C23, but it's not in printf here it seems.
# otherwise %x prints in hex, %d in decimal. %B (byte with leading 0s)
# seems to print it in decimal somehow.

#===
# # PS4 Linux kernel make functions. March 14, 2025

ps4make() {
	ps4make1 && ps4make2 && ps4make3
}

ps4make1() {
	_buildPath="$ps4_build/ps4-linux-linux-5.15.y"
	cd "$_buildPath"
	#use git remote set-url /path/to/git/directory to initialize it first
	#or git remote add /path/to/git/directory
	#git pull origin --update-shallow --no-rebase --allow-unrelated-histories -X theirs --no-edit && mv config .config
	git fetch origin
	_DEFAULT_BRANCH=$(git remote show origin 2>/dev/null | awk '/HEAD branch/ {print $NF}')
	git reset --hard origin/"$_DEFAULT_BRANCH"
}


ps4make2() {
	_buildPath="$ps4_build/ps4-linux-linux-5.15.y"
	#_buildPath="$ps4_build"/ps4-linux-linux-5.15.y_sdhci_module_branch #15
	read -t 10 -p "Build path is $_buildPath?" _bpath;
	if [ "$_bpath" == "y" ] || [ "$_bpath" == "" ] ; then echo 'Continuing'; else echo "Alt+F4 or Ctrl+C this terminal"; return 1; sleep 100000; fi; #pkill "$(echo $$)" is useless. When you run as a function / script(?), the next commands are not read yet, so you can ctrl+c to end the whole function.
	dir="$(date +"%F %H_%M_%S")";
	cd $_buildPath &&
	mkdir "../Logs/$dir" -p &&
	echo $dir > ../Logs/curDir && 
	make olddefconfig -j8 HOSTCC=gcc-11 CC=gcc-11  1>> "../Logs/$dir/configureLog" 2>> "../Logs/$dir/configureErr" &&
	echo -e "Started compiling: "$(date)"" 1>> "../Logs/$dir/dateLog" &&
	#if failed compilation, start from here, #6
	make -j8 HOSTCC=gcc-11 CC=gcc-11 1>> "../Logs/$dir/gnumakeLog" 2>> "../Logs/$dir/gnumakeErr" &&
	echo -e "Finished compiling: "$(date)"" 1>> "../Logs/$dir/dateLog" &&
	make modules -j8 HOSTCC=gcc-11 CC=gcc-11 1>> "../Logs/$dir/modulesmakeLog" 2>> "../Logs/$dir/modulesmakeErr" &&
	echo -e "Finished making modules: "$(date)"" 1>> "../Logs/$dir/dateLog" &&
	touch ../danzo
}

ps4make2_5() {
	#if $_buildPath

	#if failed compilation, start from here, #6
	make -j8 HOSTCC=gcc-11 CC=gcc-11 1>> "../Logs/$dir/gnumakeLog" 2>> "../Logs/$dir/gnumakeErr" &&
	echo -e "Finished compiling: "$(date)"" 1>> "../Logs/$dir/dateLog" &&
	make modules -j8 HOSTCC=gcc-11 CC=gcc-11 1>> "../Logs/$dir/modulesmakeLog" 2>> "../Logs/$dir/modulesmakeErr" &&
	echo -e "Finished making modules: "$(date)"" 1>> "../Logs/$dir/dateLog" &&
	touch ../danzo
}

ps4make3() {
	#needs SU
	sudo echo ''
	_buildPath="$ps4_build/ps4-linux-linux-5.15.y"
	#_buildPath="$ps4_build"/ps4-linux-linux-5.15.y_sdhci_module_branch" #41
	read -t 10 -p "Build path is $_buildPath?" _bpath;	
	if [ $_bpath == "y" ]  || [ $_bpath == "" ]; then echo 'Continuing'; else echo "Alt+F4 or Ctrl+C this terminal"; return 1; sleep 100000; fi; #pkill "$(echo $$)" is useless. When you run as a function / script(?), the next commands are not read yet, so you can ctrl+c to end the whole function.
	_outputBackupPath="$ps4_build/bzImages" &&
	#majorVer=0.21; #change the ../version file to 0 when you change this
	localName="obsidianx";
	cd "$_buildPath"; 
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	if [ -f ../danzo ]; then cd .; else sleep 300; fi &&
	mkdir "$_outputBackupPath" -p &&
#	versionString="$localName-"$(strings "$_buildPath/arch/x86/boot/bzImage" | grep -E "^[1-5]\.[0-9][0-9]*\.[0-9][0-9]*" | sed -En 's|.*'"$localName"'-([0-9]*.[0-9]*.[0-9]*)_.*|\1|p')"" && #variables might be expanded and declared first before the cd takes place, so use abs path
	versionString="$localName-"$(strings "$_buildPath/arch/x86/boot/bzImage" | grep -E "^[1-5]\.[0-9][0-9]*\.[0-9][0-9]*" | sed -En 's|.*'"$localName"'-(.*) \(.*|\1|p')"" &&
	
	read -t 15 -p "Is the version of kernel still $versionString?  " answer ;
	if [ $answer == "y" ] || [ $_bpath == "" ]; then echo ''; else exit; fi ;
	answer=''
	
	su_dir="$(cat ../Logs/curDir)" ;
	echo "HELLO, su_dir = $su_dir" &&
	sudo make modules_install -j8 HOSTCC=gcc-11 CC=gcc-11 1>> "../Logs/$su_dir/modulesinstallLog" 2>> "../Logs/$su_dir/modulesinstallErr" & echo '' && #can use INSTALL_MOD_PATH= to change instlpath
	cd "$_buildPath/arch/x86/boot" && #using && this is 
	mkdir "$_outputBackupPath/$versionString" -p &&
	cp bzImage "$_outputBackupPath/$versionString/bzImage" &&
	
	if [ -f "$ps4bz/bzImage" ] ; then
	#oldVersionString="latestLocalbZ-$localName"$(strings "$ps4bz/bzImage" | grep -E "^[1-5]\.[0-9][0-9]*\.[0-9][0-9]*" | sed -En 's|^(.*)\(.*|\1|p')"" ;
	oldVersionString="$localName-"$(strings "$ps4bz/bzImage" | grep -E "^[1-5]\.[0-9][0-9]*\.[0-9][0-9]*" | sed -En 's|^(.*)\(.*|\1|p')"" ;
	sudo mv "$ps4bz/bzImage" "$ps4bz/$oldVersionString" ;
	fi;
	sudo cp bzImage "$ps4bz/bzImage" &&
	sudo cp "../../../../Logs/$su_dir/gnumakeErr" "$ps4bz/gnumakeErr-$versionString";
	echo $versionString > ../../../../version &&
	rm ../../../../danzo &&
	rm ../../../../Logs/curDir &&
	cd "$_buildPath" &&
	sleep 1 ;
	read -t 120 -p "Shutdown?  " answer2 ;
	if [[ $answer2 == "y" ]] || [[ $answer2 == "" ]] ;  then shutdown -time +3; else echo ''; fi
	answer2=''
}

# Handle Github actions created bzImages automatically. July 10, 2025, 12:23:55 AM

ps4makegh() {
	
	_outputBackupPath="$ps4_build/bzImages" &&
	mkdir "$_outputBackupPath/tmp"
	for kernel in $*; do
		ark --batch $kernel | tar -xf -C "$_outputBackupPath/tmp";
		_dir="$($_outputBackupPath/"$(kernstring "$_outputBackupPath/tmp/boot/bzImage")")"
		cp $_outputBackupPath/tmp/* -r $_dir;
	done;
}
		

# Extract github actions kernel , July 13, 2025, 06:44:50 PM
ps4githubkern() {
	_zip_dir="$(echo $@ | sed -s)"
        unzip ./"$@" -d ./"$@"
	tar -xvf ./kernel_"$@" -C ./"$@"
}

# Quickly test the current kernel make config, Aug 9, 2025
kern_config_update() {
	cp config .config
	make olddefconfig -j8 HOSTCC=gcc-11 CC=gcc-11
}


# Unsigned to signed integer in bash code, March 16 , 2025
## [better function up above]
#unsigned_to_signed()
#{
#    local hex=$(printf "0x%x" $(( $* )))
#    local unsigned=$(printf "%u" $hex )
#    echo $unsigned
#}
#
#unsigned_to_signed32()
#{
#    local hex=$(printf "0x%x" $(( $* & 0xFFFFFFFF )))
#    local unsigned=$(printf "%u" $hex )
#    echo $unsigned
#}
#
