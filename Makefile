.POSIX:

OS = $(shell uname -s)

install:
	@echo "[make] (compile, install and clean dmenu)"
	make -C dmenu_md
	sudo make -C dmenu_md install
	sudo make -C dmenu_md clean
	rm -f dmenu_md/config.h

	@echo "[make] (compile, install and clean dwm)"
	make -C dwm_md
	sudo make -C dwm_md install
	sudo make -C dwm_md clean
	rm -f dwm_md/config.h

	@echo "[make] (compile, install and clean st)"
	make -C st_md
	sudo make -C st_md install
	sudo make -C st_md clean
	rm -f st_md/config.h

uninstall:
	@echo "[make] (uninstall dmenu)"
	sudo make -C dmenu_md uninstall

	@echo "[make] (uninstall dwm)"
	sudo make -C dwm_md uninstall

	@echo "[make] (uninstall st)"
	sudo make -C st_md uninstall

.PHONY: install uninstall
