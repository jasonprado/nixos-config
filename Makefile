UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	nix run nix-darwin -- switch --flake ".#"
else
	sudo nixos-rebuild switch --show-trace --flake ".#"
endif

switch-user:
	pushd ~/.dotfiles
	nix build .#homeManagerConfigurations.jasonprado.activationPackage
	popd

update:
	nix flake update
ifeq ($(UNAME), Linux)
		sudo nix-channel --update
endif