#!/bin/sh

config_path=~/.config/ran_on_boot

_on_boot() {
    # This will run on every boot.
    echo "This will run at every boot."
}

_on_next_boot() {
    # This will run on next boot only.
    echo "This will run on next boot only."
    _set_complete
}

_set_complete() {
    # Write a file called ran_on_boot so that the _on_next_boot function
    # knows that it's been run before.
    touch $config_path
    echo "Delete this to force the _on_next_boot function to run." >> $config_path
}

if [ ! -e $config_path ]; then
    _on_next_boot
fi

# Anything here will print / run on boot, login, or new shell creation
echo "This will print at startup."
# -----

_on_boot
