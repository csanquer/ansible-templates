# set default shell
SHELL := $(shell which bash)
ENV = /usr/bin/env
VAULT_PASSWORD_FILE = .vault_password
ANSIBLE_OPTS =
# default shell options
.SHELLFLAGS = -c
.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
default: dry;   # default target

_vault_password:
	if [ ! -f $(VAULT_PASSWORD_FILE) ]; then \
		read -s -p "Vault Password: " vaultPassword ; \
		echo "\n" ; \
		echo $$vaultPassword > $(VAULT_PASSWORD_FILE) ; \
	fi
.PHONY: _vault_password

decrypt: _vault_password
	echo running -> ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
	ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
.PHONY: decrypt

encrypt: _vault_password
	echo running -> ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
	ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
.PHONY: encrypt

view: _vault_password
	echo running -> ansible-vault view --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
	ansible-vault view --vault-password-file=$(VAULT_PASSWORD_FILE) $(ANSIBLE_OPTS) crypted/*
.PHONY: view

check:
	echo running -> ansible-playbook main.yml $(ANSIBLE_OPTS) --syntax-check
	ansible-playbook main.yml $(ANSIBLE_OPTS) --syntax-check
.PHONY: check

dry: _vault_password
	echo running -> ansible-playbook main.yml $(ANSIBLE_OPTS) --check --diff --vault-password-file=$(VAULT_PASSWORD_FILE)
	ansible-playbook main.yml $(ANSIBLE_OPTS) --check --diff --vault-password-file=$(VAULT_PASSWORD_FILE)
.PHONY: dry

run: _vault_password
	echo running -> ansible-playbook main.yml $(ANSIBLE_OPTS) --vault-password-file=$(VAULT_PASSWORD_FILE)
	ansible-playbook main.yml $(ANSIBLE_OPTS) --vault-password-file=$(VAULT_PASSWORD_FILE)
.PHONY: run
