# SPDX-FileCopyrightText: 2025 IObundle
#
# SPDX-License-Identifier: MIT

# ----------------------------------------------------------------------------
# IOb_Eth Example Constrain File
# This file contains the ethernet core constraints for the Smart-Zynq-SL board.
# ----------------------------------------------------------------------------

# RGMII PHY
create_clock -period 8 -name mii_rx_clk_i [get_ports mii_rx_clk_i]
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports mii_mdc_o]
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports mii_mdio_io]
set_property -dict {PACKAGE_PIN A22 IOSTANDARD LVCMOS33} [get_ports {mii_rxd_i[0]}]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {mii_rxd_i[1]}]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports {mii_rxd_i[2]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports {mii_rxd_i[3]}]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports mii_rx_dv_i]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33} [get_ports mii_rx_clk_i]
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {mii_txd_o[0]}]
set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS33} [get_ports {mii_txd_o[1]}]
set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports {mii_txd_o[2]}]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports {mii_txd_o[3]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports mii_tx_en_o]
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports mii_tx_clk_i]
set_property SLEW FAST [get_ports {mii_txd_o[0]}]
set_property SLEW FAST [get_ports {mii_txd_o[1]}]
set_property SLEW FAST [get_ports {mii_txd_o[2]}]
set_property SLEW FAST [get_ports {mii_txd_o[3]}]
set_property SLEW FAST [get_ports mii_tx_en_o]
set_property SLEW FAST [get_ports mii_tx_clk_i]
