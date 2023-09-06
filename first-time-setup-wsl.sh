echo "Setting up passwordless sudo for user $USER. (You may be asked for your password.)"
sudo grep $USER /etc/sudoers || echo "$USER    ALL=(ALL) NOPASSWD:ALL" | (sudo su -c 'EDITOR="tee -a" visudo')
echo "Installing ansible."
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install -y ansible
echo "Running ansible playbook."
ansible-playbook wsl.yml
echo "Done."
