.POSIX:

include config.mk

.SILENT: help
.PHONY: help # print this help text
help:
	@grep '^.PHONY: .* #' $(firstword $(MAKEFILE_LIST)) |\
		sed 's/\.PHONY: \(.*\) # \(.*\)/\1 # \2/' |\
		awk 'BEGIN {FS = "#"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' 


.PHONY: build # ----- (combo) build all

build: install compile

.SILENT: install
.PHONY: install # install dependencies
install:
	$(INSTALL_CMD) $(INSTALL_PKG)

.PHONY: compile # compile all
compile:
	echo "[ MAKE ] (compile, install and clean dmenu)"
	rm -f $(DMENU_PREFIX)/config.h
	make -C $(DMENU_PREFIX)
	sudo make -C $(DMENU_PREFIX) install
	sudo make -C $(DMENU_PREFIX) clean
	rm -f $(DMENU_PREFIX)/config.h

	echo "[ MAKE ] (compile, install and clean dwm)"
	rm -f $(DWM_PREFIX)/config.h
	make -C $(DWM_PREFIX)
	sudo make -C $(DWM_PREFIX) install
	sudo make -C $(DWM_PREFIX) clean
	rm -f $(DWM_PREFIX)/config.h

	echo "[ MAKE ] (compile, install and clean st)"
	rm -f $(ST_PREFIX)/config.h
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

.PHONY: uninstall # uninstall all
uninstall:
	echo "[ MAKE ] (uninstall dmenu)"
	sudo make -C $(DMENU_PREFIX) uninstall

	echo "[ MAKE ] (uninstall dwm)"
	sudo make -C $(DWM_PREFIX) uninstall

	echo "[ MAKE ] (uninstall st)"
	sudo make -C $(ST_PREFIX) uninstall

	echo "[ REMOVE ] files <- $(BIN_PREFIX)"
	for file in bin/*; do rm -f $(BIN_PREFIX)/$$(basename $(notdir $$file)); done
