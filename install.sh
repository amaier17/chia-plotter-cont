#!/bin/bash

NODE_USER=${NODE_USER:-$USER}
NODE_GROUP=${NODE_GROUP:-$NODE_USER}
PLOTTER_PATH=${CHIA_PATH:-/opt/chia/chia-plotter}
INSTALL_LOC=${INSTALL_LOC:-/etc/systemd/system}

SCRIPT_DIR=$(readlink -f $(dirname "$0"))
install_plotter() {
	echo "Installing $INSTALL_LOC/chia-plotter.service with user $NODE_USER, group $NODE_GROUP, and using the blockchain installed at $PLOTTER_PATH"
	sed "s|PLOTTER_PATH|$PLOTTER_PATH|g;s|NODE_USER|$NODE_USER|g;s|NODE_GROUP|$NODE_GROUP|g" "$SCRIPT_DIR/chia-plotter.service.init" > "$SCRIPT_DIR/chia-plotter.service"
	sudo ln -s $SCRIPT_DIR/chia-plotter.service $INSTALL_LOC/ -f
}

if [ ! -f "$PLOTTER_PATH/build/chia_plot" ]; then
	echo "Could not find $PLOTTER_PATH/build/chia_plot executable. Cloning the repo now..."
	rm -rf $PLOTTER_PATH
	git clone https://github.com/madMAx43v3r/chia-plotter.git $PLOTTER_PATH --recursive
	pushd $PLOTTER_PATH
	./make_devel.sh
	popd
fi

sudo chown -R $NODE_USER:$NODE_GROUP $PLOTTER_PATH
install_plotter

sudo systemctl daemon-reload
sudo systemctl enable chia-plotter.service
sudo systemctl start chia-plotter.service

