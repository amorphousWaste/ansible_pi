#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set the PS1 via a function
# This will run after every command
PROMPT_COMMAND=_set_ps1

_init() {
    # Initialize bash shell

    # Source external scripts
    _source_scripts

    # Set up environment variables
    _set_environment

    # Set completions
    _set_completions

    # Set aliases
    if [ -f ~/.bash_aliases ]; then . /home/pi/.bash_aliases; fi
    # Expand aliases so they can be used in the script
    shopt -s expand_aliases

    _create_motd

    # Get the current shell level
    # local shell_level=$SHLVL
}

_source_scripts() {
    # Source external scripts
    source /home/pi/.bash_colors
    source /home/pi/.bash_motd
    source /home/pi/.bash_utilities
    source /home/pi/.bash_scripts
}

_set_environment() {
    # Set environment variables

    # Default editor
    export EDITOR="micro"
    export VISUAL="micro"

    # Bash history settings
    export HISTSIZE=10000
    export HISTFILESIZE=10000
    # Don't put duplicate lines or lines starting with space in the history
    export HISTCONTROL=ignoreboth
    shopt -s histappend

    # Check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # Colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
}

_set_completions() {
    # Set completions
    complete -F _complete_tosrc tosrc
    complete -F _complete_topkg topkg
}

_set_ps1() {
    # Set the custom prompt for a standard shell

    # For reference, this is for showing the history number: $NONE"["$D_YELLOW"\\!"$NONE"]"
    local exit="$?"

    local prompt
    prompt=""

    local packages
    packages=$(_get_packages)

    # Add rez packages
    if [[ $packages ]]; then
        prompt+="[$packages]\n"
    fi

    # local git_status
    # git_status=$(_get_git_status)
    # if [[ $git_status ]]; then
    #     prompt+="$git_status"
    # fi

    # Add the current directory
    prompt+="\[$DH_GREEN$D_GREY\]\w\[$NONE$D_GREEN\]$ARROW_BLOCK_R\[$NONE\]\n"

    local current_date
    current_date=`_get_date`
    local current_time
    current_time=`_get_time`

    local user_color=$DH_BLUE
    local user_arrow=$D_BLUE
    local machine_color=$LH_BLUE
    local machine_arrow=$L_BLUE

    # Add the date
    prompt+="\[$DH_GREY\]$current_date\[$NONE$LH_GREY$D_GREY\]$ARROW_BLOCK_R"
    # Add the time
    prompt+="\[$NONE$LH_GREY\]$current_time\[$NONE$L_GREY$user_color\]$ARROW_BLOCK_R"
    # Add the user
    prompt+="\[$NONE$user_color\]\u"
    # Add the machine if in an ssh session
    if [ "`_is_ssh`" == 1 ]; then
        prompt+="\[$NONE$machine_color$user_arrow\]$ARROW_BLOCK_R\[$NONE$machine_color\]\h"
    fi

    if [[ "`_is_ssh`" == 1 ]]; then
        prompt+="\[$NONE$machine_arrow\]$ARROW_BLOCK_R\[$NONE\]"

    else
        prompt+="\[$NONE$user_arrow\]$ARROW_BLOCK_R\[$NONE\]"
    fi

    # Use the exit status of the previous command to color the username and
    # machine. Blue for success, red for failure.
    if [[ $exit == 0 ]]; then
        local exit_color=$D_GREEN
    else
        local exit_color=$D_RED
    fi

    # Set the prompt
    export PS1="$prompt\[$BOLD$exit_color\]$ARROW_CHAR_R\[$NONE\] "
}

_tosw() {
    # Function to go to the directory for the user if it exists
    _goto "/home/${USER}/github"
}

_tosrc() {
    # Function to go the sw/src directory for the user if it exists
    # Uses complete to fill in directories with <TAB> key via _complete_tosrc()
    _goto "/home/${USER}/github/${1}"
}

_complete_tosrc() {
    # Completes directories within the src directory with <TAB> key
    local dirs=("/home/${USER}/github/$2"*)
    COMPREPLY=( "${dirs[@]##*/}" )
}

_topkg() {
    # Function to go the sw/packages directory for the user if it exists
    # Uses complete to fill in directories with <TAB> key via _complete_tosrc()
    _goto "/home/${USER}/packages/$1"
}

_complete_topkg() {
    # Completes directories within the packages directory with <TAB> key
    local dirs=("/home/${USER}/packages/$2"*)
    COMPREPLY=( "${dirs[@]##*/}" )
}

_rez_env() {
    \rez-env "$@"
}

_rez_and_ipython() {
    # Function to add ipython to any environment and launch ipython
    _rez_env ipython "$*" -- ipython
}

_goto() {
    # Go to a location based on the given path and whether or not it exists
    local path
    path=$1
    local dest
    dest=""
    local exit_code
    exit_code=0

    # If nothing is given, go to the home folder
    if [[ -z $path ]]; then
        dest=""

    # Use the same convention as cd for dash
    elif [[ $path == "-" ]]; then
        dest="-"

    # If path is a directory that exists, go to it
    elif [[ -d $path ]]; then
        dest=$path

    # If path is a file that exists, go to its parent folder
    elif [[ -f $path ]]; then
        dest=$(dirname $path)

    # If the path is to an image sequence and its parent folder exists,
    # go to the parent folder
    elif [[ $path == *"%"* && -d $(dirname $path) ]]; then
        dest=$(dirname $path)

    else
        # If nothing else works
        local current
        current=$(dirname $path)
        while [[ ! -d $current ]]; do
            current=$(dirname $current)
        done

        # Use substitution to get the invalid part of the path
        local invalid
        invalid=${path//$current/}
        # Use substitution to get the valid part of the path
        local valid
        valid=${path//$invalid/}

        printf $L_RED"Path Not Found:${NONE} ${valid}${D_RED}${invalid}${NONE}\n"
        dest=$current
        # Set a non-zero exit code
        exit_code=1
    fi

    # Try to cd into the directory
    # If that fails (eg. Permission Denied) get the non-zero exit code
    cd $dest || exit_code=$?

    # Don't list directory contents if the directory could not be changed
    if [[ $exit_code == 0 ]]; then
        ls -a
    fi
    return $exit_code
}

_set_title() {
    # Set the window title to the given string
    local title="\[\e]2;$*\a\]"
    local original=$PS1

    PS1=${original}${title}
}

_rez_graph() {
    # Graph out a REZ request
    rez-env "$@" -o - | rez-context -g -;
}

_rez_build() {
    # Perform a Rez Build and then print out the last time it was built.
    rez-build -ic "$@"

    local date_formatted
    date_formatted=`date +'%Y/%m/%d'`
    local time_formatted
    time_formatted=`date +'%I:%M%p'`
    local date_time
    date_time=`echo "$date_formatted - $time_formatted"`
    printf "Last built at: ${D_BLUE}${date_time}${NONE}\n\n"
}

# Run the init function
_init
