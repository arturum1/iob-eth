//`define VCD

//`define ETH_SIZE 8'd20
`define ETH_ADDR_W 12

`define ETH_MAC_ADDR 48'h01606e11020f
`define ETH_RMAC_ADDR 48'h309c231e624b

//commands
`define ETH_SEND 1
`define ETH_RCV 2

// Memory map
`define ETH_STATUS           `ETH_ADDR_W'd0
`define ETH_CONTROL          `ETH_ADDR_W'd1

`define ETH_RMAC_ADDR_LO      `ETH_ADDR_W'd2
`define ETH_RMAC_ADDR_HI      `ETH_ADDR_W'd3

`define ETH_PHY_RST          `ETH_ADDR_W'd4
`define ETH_DUMMY            `ETH_ADDR_W'd5

`define ETH_TX_NBYTES        `ETH_ADDR_W'd6
`define ETH_RX_NBYTES        `ETH_ADDR_W'd7

`define ETH_DATA          `ETH_ADDR_W'd2048

