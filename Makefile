UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	nix run nix-darwin -- switch --flake ".#"
else
	sudo nixos-rebuild switch --flake .#
endif

switch-user:
	pushd ~/.dotfiles
	nix build .#homeManagerConfigurations.jasonprado.activationPackage
	popd
