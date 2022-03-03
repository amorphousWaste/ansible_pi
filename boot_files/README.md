# Boot Files #
These files should be put into the `boot` partition of a Raspbian image so that they take effect during installation. To do so
1.  Download one of the official Raspbian images from the [Operating System Images](https://www.raspberrypi.org/software/operating-systems/) page.
2.  Unzip the image.
3.  Copy these boot files into the mounted `boot` drive.
4.  Unmount the image.
5.  Burn the image to an appropriate SD card. You can download an [official tool](https://www.raspberrypi.org/software/) or [balena Etcher](https://www.balena.io/etcher/) to make this task easier.
6.  Insert the memory card into your Raspberry Pi and plug it in.
7.  Wait until the Pi boots to the CLI (Command Line Interface) or desktop.
9.  From the host machine, create an ssh key if one does not already exist.
10. Copy the ssh key to the target machine(s) using the builtin `ssh-copy-id` command.
    ```bash
    ssh-copy-id -i key pi@host
    ```
    ```bash
    ssh-copy-id -i ./id_rsa pi@192.168.1.1
    ```

At this point, it should be ready for a playbook to be run.

## config.txt ##
Raspbian configuration file with modified defaults.

## ssh ##
The existence of this file enables ssh by default.

**Note**: The contents of this file are meaningless.

## wpa_supplicant ##
This file defines the wifi connection(s).

**Pi0** -> **Pi3 B** Require a 2.4GHz wifi connection.
**Pi3 B+** -> **Pi4** Can use a 5GHz wifi connection.
