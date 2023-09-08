# Bunch of things that I usually want to do on a new machine
# as well, but that does not yet have a "repeat-protection".

echo "Using more up-to-date Git..."
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt install -y git

echo "To enable Wayland-support for Firefox, add this to /etc/environment:"
echo "    MOZ_ENABLE_WAYLAND=1"
