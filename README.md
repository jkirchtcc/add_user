# Create Ansible User Script

This script automates the process of creating a new user named `ansible_user` on an Ubuntu 24.04 machine, adding the user to the `sudo` group, and configuring SSH access using the `root` user's existing SSH public key.

## Prerequisites

- The script should be run with `sudo` or as the `root` user to ensure it has the necessary permissions.
- Ensure that the `root` user has a valid public key in `/root/.ssh/authorized_keys`.

## What This Script Does

1. **Create a new user** named `ansible_user` with a home directory and sets the default shell to Bash.
2. **Prompts for a password** for the new user and sets it interactively.
3. **Adds `ansible_user` to the `sudo` group**, granting it administrative privileges.
4. **Sets up SSH key-based authentication** by copying the `root` user's public key to the `ansible_user`'s `authorized_keys` file, enabling key-based login.
5. **Configures appropriate permissions** on the `.ssh` directory and the `authorized_keys` file for secure access.

## Usage

1. **Download or create the script** on your server and save it as `create_ansible_user.sh`.
2. **Make the script executable**:
   ```bash
   chmod +x create_ansible_user.sh
   ```
3. **Run the script** with superuser privileges:
   ```bash
   sudo ./create_ansible_user.sh
   ```

## Script Breakdown

- `useradd -m -s /bin/bash ansible_user`: Creates `ansible_user` with a home directory and sets their default shell to Bash.
- `passwd ansible_user`: Prompts you to set a password for `ansible_user`.
- `usermod -aG sudo ansible_user`: Adds `ansible_user` to the `sudo` group.
- `mkdir -p /home/ansible_user/.ssh` and `chmod 700`: Creates the `.ssh` directory for secure storage of SSH keys.
- Copies `root`'s SSH public key from `/root/.ssh/authorized_keys` to `ansible_user`'s `authorized_keys` to enable key-based login.
- Sets ownership and permissions of the `.ssh` directory and `authorized_keys` file to `ansible_user`.

## Important Notes

- **Make sure that the `root` user's public key exists** in `/root/.ssh/authorized_keys` before running the script, or the script will skip the key copy step.
- After running this script, `ansible_user` will have `sudo` privileges and be able to log in using the same SSH key as `root`.
- For additional security, consider disabling `root` login and requiring public key authentication only in your SSH server configuration.

## License

This script is licensed under the GNU General Public License v3.0.

```
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
```

For more information about the GPL v3 license, visit [https://www.gnu.org/licenses/gpl-3.0.en.html](https://www.gnu.org/licenses/gpl-3.0.en.html).
