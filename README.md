# ansible_pi #
Ansible files for setting up various Raspberry Pis.

Additional instructions for initially setting up a Raspberry Pi can be found in the **boot_files** folder.

## Setup ##
Ansible can be installed through pip:
```bash
pip install ansible
```
Once installed, create a file called `.ansible.cfg` in your home directory. You can get an example file from the [ansible repo on GitHub](https://github.com/ansible/ansible/blob/devel/examples/ansible.cfg). In the config file, uncomment the line under `[defaults]` that starts with "inventory" and change the path to `~/.ansible_hosts`:
```
inventory        = ~/.ansible_hosts
```
and uncomment `remote_user` and set it equal to `pi`:
```
remote_user = pi
```
Create a file in your home directory called `.ansible_hosts`. In this file, add your hosts and ip addresses using the [ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) as an example.

To use the password encrypting feature, you will need to install `passlib`:
```bash
pip install passlib
```

## .ansible_hosts ##
Custom hosts file. Symlinked to `~/.ansible_hosts`

## .ansible.cfg ##
Modified config file. Symlinked to `~/.ansible.cfg`

## ssh ##
Ansible requires password-less ssh access. If this is a new Raspberry Pi installation you will need to create the appropriate ssh keys and copy them over to the Pi.
If you already have keys on the host machine, simply use:
```bash
ssh-copy-id pi@server_ip_address
```
and replace `server_ip_address` with the actual ip address.

## pi_playbook.yaml ##
The playbook to run for deployment. To run this playbook, use:
```bash
ansible-playbook pi_playbook.yaml
```

## private_vars.yaml ##
Private playbook variables. You will need to create this file yourself based on the `private_vars_example.yaml` file provided.

## vars.yaml ##
Playbook variables.

```
{\__/}
(• .•)
/ > ♥️
```
