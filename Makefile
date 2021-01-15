.POSIX:

OS = $(shell uname -s)

ifndef BIN_PREFIX
	BIN_PREFIX = ${HOME}/.local/bin
endif

ifndef DWM_PREFIX
	DWM_PREFIX = dwm_md
endif
ifndef DMENU_PREFIX
	DMENU_PREFIX = dmenu_md
endif
ifndef ST_PREFIX
	ST_PREFIX = st_md
endif

install:
	echo "[ MAKE ] (compile, install and clean dmenu)"
	make -C $(DMENU_PREFIX)
	sudo make -C $(DMENU_PREFIX) install
	sudo make -C $(DMENU_PREFIX) clean
	rm -f $(DMENU_PREFIX)/config.h

	echo "[ MAKE ] (compile, install and clean dwm)"
	make -C $(DWM_PREFIX)
	sudo make -C $(DWM_PREFIX) install
	sudo make -C $(DWM_PREFIX) clean
	rm -f $(DWM_PREFIX)/config.h

	echo "[ MAKE ] (compile, install and clean st)"
	make -C $(ST_PREFIX)
	sudo make -C $(ST_PREFIX) install
	sudo make -C $(ST_PREFIX) clean
	rm -f $(ST_PREFIX)/config.h

	echo "[ CHECK ] exist | mkdir -> $(BIN_PREFIX)"
	if [ ! -d "$(BIN_PREFIX)" ]; then mkdir -p "$(BIN_PREFIX)"; fi
	echo "[ COPY ] files -> $(BIN_PREFIX)"
	for file in bin/*; do \
		cp -f $$file $(BIN_PREFIX); \
		chmod 755 $(BIN_PREFIX)/$$(basename $(notdir $$file)); \
	done

uninstall:
	echo "[ MAKE ] (uninstall dmenu)"
	sudo make -C $(DMENU_PREFIX) uninstall

	echo "[ MAKE ] (uninstall dwm)"
	sudo make -C $(DWM_PREFIX) uninstall

	echo "[ MAKE ] (uninstall st)"
	sudo make -C $(ST_PREFIX) uninstall

	echo "[ REMOVE ] files <- $(BIN_PREFIX)"
	for file in bin/*; do rm -f $(BIN_PREFIX)/$$(basename $(notdir $$file)); done

.PHONY: install uninstall
