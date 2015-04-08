INSTALL_DIR=~/.local/bin

all:
	@echo "Please run 'make install'"

install:
	@echo ""
	mkdir -p $(INSTALL_DIR)
	cp benbash.sh $(INSTALL_DIR)
	@echo ""
	@echo "Please add 'alias bb=". benbash"' to your .bashrc file"
	@echo ''
	@echo 'USAGE:'
	@echo '------'

.PHONY: all install
