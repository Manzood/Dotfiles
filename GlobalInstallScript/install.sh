# the goal of this script is to eventually set everything up so that I have a flexible setup that copies my dotfiles wherever I need them
# So far, everything has been from https://www.youtube.com/watch?v=70YMTHAZyy4

# installing nix
curl -L https://nixos.org/nix/install | sh

# setting up nix
. ~/.nix-profile/etc/profile.d/nix.sh
