Source: https://github.com/xremap/xremap

Copy xremap.desktop to ~/.config/autostart/xremap.desktop
Copy xremap.service to ~/.config/systemd/user/xremap.service

On Arch, to run as non sudo:
Check if uinput is loaded
lsmod | grep uinput

Then:
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
