#!/bin/bash
# Set the aliases
alias l="ls -alh --color=auto"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias disks="df -lhc"
alias off='sudo shutdown now'

alias go=_goto

alias rg=_rez_graph
alias rb=_rez_build
alias ipy=_rez_and_ipython
alias tosrc=_tosrc
alias topkg=_topkg

alias python='python3'
alias pip='pip3'
alias ipy='ipython3'

alias update=_update_all

alias rmq_start='sudo rabbitmq-server'
alias rmq_status='sudo rabbitmqctl status'
alias rmq_shutdown='sudo rabbitmqctl shutdown'

alias check_temp='/opt/vc/bin/vcgencmd measure_temp'
alias check_space='df -Ht rootfs'
alias check_ram='grep MemTotal /proc/meminfo; grep MemFree /proc/meminfo; grep MemAvailable /proc/meminfo'
alias check_voltage=_get_voltage

alias flip=_flip_a_coin
alias roll=_roll_the_dice
