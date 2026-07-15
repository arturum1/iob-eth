# SPDX-FileCopyrightText: 2026 IObundle
#
# SPDX-License-Identifier: GPL-3.0-only

# Run iob_eth's mii_management module along with a demo PHY model.
run: 
	nix-shell ../../../ --run 'iverilog -W all -g2005-sv -o miim_sim -I src -I ../../modules/iob_eth_mii_management/hardware/src ../../modules/iob_eth_mii_management/hardware/src/iob_eth_mii_management.v src/iob_miim_tb.v src/iob_phy_model.v src/iob_iobuf.v; ./miim_sim'

.PHONY: run
