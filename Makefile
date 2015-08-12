INSTALL_DIR=~/.local/bin/benbash
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

install-accessories:
	@echo ""
	mkdir -p $(INSTALL_DIR)
	cp accessories/*.sh $(INSTALL_DIR)
	echo "# benbash accessories #" >> ~/.bashrc
	echo "alias delegate=\". $(INSTALL_DIR)/delegate.sh\"" >> ~/.bashrc
	echo "# benbash END #" >> ~/.bashrc
	@echo ''
	@echo 'USAGE:'
	@echo '------'

install-full:
	make install-accessories
	make install

reinstall:
	make uninstall
	make install

reinstall-full:
	make uninstall
	make install-full

uninstall:
	rm -rf $(INSTALL_DIR)
	sed -i '/benbash/ d' ~/.bashrc

.PHONY: all install
