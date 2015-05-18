INSTALL_DIR=~/.local/bin
FILE_NAME=benbash.sh

all:
	@echo "Please run 'make install'"

install:
	@echo ""
	mkdir -p $(INSTALL_DIR)
	cp $(FILE_NAME) $(INSTALL_DIR)
	echo "# benbash             #" >> ~/.bashrc
	echo "alias bb=\". $(INSTALL_DIR)/benbash.sh\"" >> ~/.bashrc
	echo "# benbash END #" >> ~/.bashrc
	exec bash
	@echo ''
	@echo 'USAGE:'
	@echo '------'

uninstall:
	rm $(INSTALL_DIR)/$(FILE_NAME)
	sed -i '/benbash/ d' ~/.bashrc

.PHONY: all install
