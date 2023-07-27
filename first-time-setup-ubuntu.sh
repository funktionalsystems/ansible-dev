echo "Setting up passwordless sudo for user $USER. (You may be asked for your password.)"
sudo grep $USER /etc/sudoers || echo "$USER    ALL=(ALL) NOPASSWD:ALL" | (sudo su -c 'EDITOR="tee -a" visudo')
echo "Disable automatic updates."
echo 'APT::Periodic::Update-Package-Lists "0";' | sudo tee /etc/apt/apt.conf.d/20auto-upgrades # Overwrite (no -a) is intentional.
echo 'APT::Periodic::Unattended-Upgrade "0";' | sudo tee -a /etc/apt/apt.conf.d/20auto-upgrades
sudo killall unattended-upgr &> /dev/null # System upgrade may be auto-running, and locks apt.
# These packages break VM boot if they upgrade:
sudo apt-mark hold linux-firmware linux-generic-hwe-20.04 linux-headers-generic-hwe-20.04 linux-image-generic-hwe-20.04
echo "Installing ansible."
sudo apt install -y ansible
echo "Running ansible playbook."
ansible-playbook ubuntu.yml
echo "Done."
