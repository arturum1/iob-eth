# ----------------------------------------------------------------------------
# IOb-Eth Example Constrain File
#
# This file contains the ethernet core constraints for the AES-KU040-DB-G board.
# ----------------------------------------------------------------------------

#Constraint Clock Transitions
#RX_CLK -> sys_clk
# RX_CLK is 25MHz for 100Mbps operation according to # Texas Instruments DP83867 
# Datasheet
create_clock -period 40 [get_ports {ENET_RX_CLK}]
# Ethernet Core has only RX_CLK -> system clock and TX_CLK -> system clock 
# transitions. RX_CLK and TX_CLK have the same source 
# (see top_system_eth_template.vh)
set_max_delay -from [get_clocks {ENET_RX_CLK}] -to [get_clocks {mmcm_clkout1}] 100

## Ethernet #1 Interface (J1)
set_property PACKAGE_PIN D9 [get_ports ENET_RESETN]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RESETN]

set_property PACKAGE_PIN A10 [get_ports ENET_RX_D0]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_D0]

set_property PACKAGE_PIN B10 [get_ports ENET_RX_D1]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_D1]

set_property PACKAGE_PIN B11 [get_ports ENET_RX_D2]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_D2]

set_property PACKAGE_PIN C11 [get_ports ENET_RX_D3]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_D3]

set_property PACKAGE_PIN D11 [get_ports ENET_RX_DV]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_DV]

set_property PACKAGE_PIN E11 [get_ports ENET_RX_CLK]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_RX_CLK]

set_property PACKAGE_PIN H8 [get_ports ENET_TX_D0]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_TX_D0]

set_property PACKAGE_PIN H9 [get_ports ENET_TX_D1]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_TX_D1]

set_property PACKAGE_PIN J9 [get_ports ENET_TX_D2]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_TX_D2]

set_property PACKAGE_PIN J10 [get_ports ENET_TX_D3]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_TX_D3]

set_property PACKAGE_PIN G9 [get_ports ENET_TX_EN]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_TX_EN]

set_property PACKAGE_PIN G10 [get_ports ENET_GTX_CLK]
set_property IOSTANDARD LVCMOS18 [get_ports ENET_GTX_CLK]

set_property IOB TRUE [get_ports ENET_TX_D0]
set_property IOB TRUE [get_ports ENET_TX_D1]
set_property IOB TRUE [get_ports ENET_TX_D2]
set_property IOB TRUE [get_ports ENET_TX_D3]
set_property IOB TRUE [get_ports ENET_TX_EN]
