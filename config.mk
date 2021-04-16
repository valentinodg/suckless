OS = $(shell uname -s)
ID = $(shell grep -w 'ID=' /etc/os-release | sed 's/ID=//' | tr -d '"')

ifeq ($(ID), void)
INSTALL_CMD = sudo xbps-install -y
INSTALL_PKG = base-devel \
			  bc \
			  setxkbmap \
			  xset \
			  xsetroot \
			  libX11 \
			  libX11-devel \
			  libXinerama \
			  libXinerama-devel \
			  libXft \
			  libXft-devel \
			  freetype \
			  freetype-devel \
			  fontconfig \
			  fontconfig-devel \
			  font-firacode

endif
ifeq ($(ID), arch)
INSTALL_CMD = sudo pacman -S --noconfirm
INSTALL_PKG = base-devel \
			  bc \
			  xorg-server \
			  xorg-xinit \
			  xorg-setxkbmap \
			  xorg-xset \
			  xorg-xsetroot \
			  libx11 \
			  libxinerama \
			  libxft \
			  freetype2 \
			  fontconfig \
			  ttf-fira-code
endif

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
