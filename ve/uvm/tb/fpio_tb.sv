/****************************************************************************
 * fpio_tb.sv
 ****************************************************************************/

/**
 * Module: fpio_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module fpio_tb;
	import uvm_pkg::*;
	import fpio_tests_pkg::*;
	import fpio_fifo_in_client_agent_pkg::*;
	
	localparam int FIFO_BITS = 8;
	localparam int DATA_WIDTH = 8;
	
	fpio_fifo_if #(
		.FIFO_BITS   (FIFO_BITS		), 
		.DATA_WIDTH  (DATA_WIDTH	)
		) u_fifo2bfm (
		);
	
	fpio_fifo_if #(
		.FIFO_BITS   (FIFO_BITS		), 
		.DATA_WIDTH  (DATA_WIDTH	)
		) u_bfm2fifo (
		);
	
	fpio_fifo #(
		.FIFO_BITS   (FIFO_BITS		), 
		.DATA_WIDTH  (DATA_WIDTH	)
		) u_fifo (
		.clk         (clk        			), 
		.rstn        (rstn       			), 
		.in          (u_fifo2bfm.fifo_in	), 
		.out         (u_bfm2fifo.fifo_out	));
	
	fpio_fifo_in_client_bfm #(
		.FIFO_DEPTH  (FIFO_DEPTH ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) u_in_bfm (
		.clk         (clk        				), 
		.rstn        (rstn       				), 
		.client      (u_fifo2bfm.fifo_in_client	));
	
	initial begin
		automatic fpio_fifo_in_client_config #(FIFO_DEPTH, DATA_WIDTH) in_cfg =
			fpio_fifo_in_client_config #(FIFO_DEPTH, DATA_WIDTH)::type_id::create("in_cfg");
		
		in_cfg.vif = u_in_bfm.u_core;
		
		run_test();
	end

endmodule

