UNAME := $(shell uname)

switch:
ifeq ($(UNAME), Darwin)
	echo "Don't know how to switch darwin yet"
else
	sudo nixos-rebuild switch --flake .#
endif

