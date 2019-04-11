`timescale 1ns/1ps
`include "iob_eth_defs.vh"

/*

 Ethernet Core

*/

module iob_eth (
		// CPU side
		input                   clk,
		input                   rst,
		input                   sel,
		input                   we,
		input [`ETH_ADDR_W-1:0] addr,
		output reg [31:0]       data_out,
		input [31:0]            data_in,

		// MII side
		output reg              ETH_RESETN,

		// RX
		input                   RX_CLK,
		input [3:0]             RX_DATA,
		input                   RX_DV,

		//TX
		input                   TX_CLK,
		output                  TX_EN,
		output [3:0]            TX_DATA

		);

   //registers
   //dummy
   reg [31:0]                           dummy_reg;
   reg                                  dummy_reg_en;
   //tx_nbytes
   reg [10:0]                           tx_nbytes_reg;
   reg                                  tx_nbytes_reg_en;
   //rx_nbytes
   reg [10:0]                           rx_nbytes_reg;
   reg                                  rx_nbytes_reg_en;
   //control
   reg [31:0]                           control_reg;
   reg                                  control_reg_en;
   
   // mac addresses
   reg [47:0]                           mac_addr;
   reg                                  mac_addr_lo_en;
   reg                                  mac_addr_hi_en;
 
   //tx signals
   wire [10:0]                          tx_rd_addr;
   wire [7:0]                           tx_rd_data;
   reg                                  tx_wr;
   wire                                 tx_ready;
   
   //rx signals
   wire [10:0]                          rx_wr_addr;
   wire [7:0]                           rx_wr_data;
   wire                                 rx_wr;
   wire                                 rx_ready;
   wire [7:0]                           rx_rd_data;

   // phy reset timer
   reg [3:0]                            phy_rst_cnt;

   //
   // ASSIGNMENTS
   //

   //assign GTX_CLK = 1'b0; //this will force 10/100 negotiation

   //
   // ADDRESS DECODER
   //
   always @* begin

      //defaults
      control_reg_en = 0;
      dummy_reg_en = 0;
      tx_nbytes_reg_en = 0;
      rx_nbytes_reg_en = 0;
      
                     
      // core outputs
      data_out = 8'd0;

      // mac addresses
      mac_addr_lo_en = 1'b0;
      mac_addr_hi_en = 1'b0;

      tx_wr = 1'b0;

      case (addr)
	`ETH_STATUS: data_out = {30'b0, rx_ready, tx_ready};
	`ETH_CONTROL: control_reg_en = sel&we&data_in[0];
	`ETH_MAC_ADDR_LO: mac_addr_lo_en = sel&we;
	`ETH_MAC_ADDR_HI: mac_addr_hi_en = sel&we;
        `ETH_DUMMY: begin
            data_out = dummy_reg;
            dummy_reg_en = sel&we;
        end
        `ETH_TX_NBYTES: tx_nbytes_reg_en = sel&we;
        `ETH_RX_NBYTES: rx_nbytes_reg_en = sel&we;
        default: begin //ETH_DATA
           if(addr[11] && sel) begin
              if(we)
                tx_wr = 1;
              else
	        data_out = {24'd0, rx_rd_data};
           end
        end
      endcase
   end

   //
   // REGISTERS
   //

   always @ (posedge clk, posedge rst) begin
      if(rst) begin
         control_reg <= 0;
	 mac_addr <= `ETH_MAC_ADDR;
      end else if(mac_addr_lo_en)
        mac_addr[23:0]<= data_in[23:0];
      else if(mac_addr_hi_en)
        mac_addr[47:24]<= data_in[23:0];
      else if(dummy_reg_en)
        dummy_reg <= data_in;
      else if(control_reg_en)
        control_reg <= data_in;
      else if(tx_nbytes_reg_en)
        tx_nbytes_reg <= data_in[10:0];
      else if(rx_nbytes_reg_en)
        rx_nbytes_reg <= data_in[10:0];

      //self clearing control bits
      if(control_reg[1:0])
        control_reg[1:0] <= 0;
   end
   
   //
   // TX and RX BUFFERS
   //

   iob_eth_alt_s2p_mem  #(
			  .DATA_W(8),
			  .ADDR_W(11)
                          )
   tx_buffer
     (
      // Back-End (written by host)
      .clk_a(clk),
      .addr_a(addr[10:0]),
      .data_a(data_in[7:0]),
      .we_a(tx_wr),

      // Front-End (read by core)
      .clk_b(TX_CLK),
      .addr_b(tx_rd_addr),
      .data_b(tx_rd_data)
      );

   iob_eth_alt_s2p_mem  #(
			  .DATA_W(8),
			  .ADDR_W(11)
                          )
   rx_buffer
     (
      // Front-End (written by core)
      .clk_a(RX_CLK),
      .addr_a(rx_wr_addr),
      .data_a(rx_wr_data),
      .we_a(rx_wr),

      // Back-End (read by host)
      .clk_b(clk),
      .addr_b(addr[10:0]),
      .data_b(rx_rd_data)
      );


   //
   //TRANSMITTER
   //

   iob_eth_tx tx (
		  .rst			(rst),
                  .nbytes               (tx_nbytes_reg),
                  .send                 (control_reg[0]),
		  .ready                (tx_ready),

		  .addr	       	        (tx_rd_addr),
		  .data	       	        (tx_rd_data),
		  .TX_CLK		(TX_CLK),
		  .TX_EN		(TX_EN),
		  .TX_DATA		(TX_DATA)
		  );


   //
   //RECEIVER
   //

   iob_eth_rx rx (
		  .rst			(rst),
                  .nbytes               (rx_nbytes_reg),
		  .ready	        (rx_ready),
                  .receive              (control_reg[1]),
		  .mac_addr             (mac_addr),

		  .wr                   (rx_wr),
		  .addr		        (rx_wr_addr),
		  .data		        (rx_wr_data),
                  .RX_CLK		(RX_CLK),
		  .RX_DATA		(RX_DATA),
		  .RX_DV		(RX_DV)
		  );


   //
   //  PHY RESET
   //

   always @ (posedge RX_CLK)
     if(rst) begin
        phy_rst_cnt <= 4'd0;
	ETH_RESETN <= 1'b0;
     end else begin
	if((phy_rst_cnt != 4'd15))
	  phy_rst_cnt <= phy_rst_cnt+1'b1;
	ETH_RESETN <= (phy_rst_cnt == 4'd15);
     end

endmodule
