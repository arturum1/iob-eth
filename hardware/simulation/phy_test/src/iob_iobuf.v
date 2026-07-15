// SPDX-FileCopyrightText: 2026 IObundle, Lda
//
// SPDX-License-Identifier: CERN-OHL-S-2.0
//
// Py2HWSW Version 0.81.0 has generated this code (https://github.com/IObundle/py2hwsw).

`timescale 1ns / 1ps
`include "iob_iobuf_conf.vh"

module iob_iobuf #(
   parameter FPGA_TOOL = `IOB_IOBUF_FPGA_TOOL
) (
   // i_i: Input port
   input  i_i,
   // t_i: Input port
   input  t_i,
   // n_i: Input port
   input  n_i,
   // o_o: Output port
   output o_o,
   // io_io: In/Output port
   inout  io_io
);

   // o_int wire
   wire o_int;


   generate
      if (FPGA_TOOL == "XILINX") begin : tool_XILINX
         IOBUF IOBUF_inst (
            .I (i_i),
            .T (t_i),
            .O (o_int),
            .IO(io_io)
         );
      end else begin : tool_other
         reg o_var;
         assign io_io = t_i ? 1'bz : i_i;
         always @* o_var = #1 io_io;
         assign o_int = o_var;
      end
   endgenerate

   assign o_o = (n_i ^ o_int);



endmodule
