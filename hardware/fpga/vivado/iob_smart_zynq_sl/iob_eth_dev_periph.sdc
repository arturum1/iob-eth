# SPDX-FileCopyrightText: 2025 IObundle
#
# SPDX-License-Identifier: MIT

# ----------------------------------------------------------------------------
# IOb_Eth Example Constrain File
# This file contains the ethernet core constraints for the Smart-Zynq-SL board.
# ----------------------------------------------------------------------------

# RGMII PHY
create_clock -period 8 -name RGMII_rxc [get_ports RGMII_rxc]
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports MDIO_PHY_mdc]
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports MDIO_PHY_mdio_io]
set_property -dict {PACKAGE_PIN A22 IOSTANDARD LVCMOS33} [get_ports {RGMII_rd[0]}]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {RGMII_rd[1]}]
set_property -dict {PACKAGE_PIN A19 IOSTANDARD LVCMOS33} [get_ports {RGMII_rd[2]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports {RGMII_rd[3]}]
set_property -dict {PACKAGE_PIN A21 IOSTANDARD LVCMOS33} [get_ports RGMII_rx_ctl]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33} [get_ports RGMII_rxc]
set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {RGMII_td[0]}]
set_property -dict {PACKAGE_PIN F21 IOSTANDARD LVCMOS33} [get_ports {RGMII_td[1]}]
set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports {RGMII_td[2]}]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports {RGMII_td[3]}]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports RGMII_tx_ctl]
set_property -dict {PACKAGE_PIN D21 IOSTANDARD LVCMOS33} [get_ports RGMII_txc]
set_property SLEW FAST [get_ports {RGMII_td[0]}]
set_property SLEW FAST [get_ports {RGMII_td[1]}]
set_property SLEW FAST [get_ports {RGMII_td[2]}]
set_property SLEW FAST [get_ports {RGMII_td[3]}]
set_property SLEW FAST [get_ports RGMII_tx_ctl]
set_property SLEW FAST [get_ports RGMII_txc]
