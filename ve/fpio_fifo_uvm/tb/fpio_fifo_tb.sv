/****************************************************************************
 * fpio_fifo_tb.sv
 ****************************************************************************/

/**
 * Module: fpio_fifo_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module fpio_fifo_tb;
	import uvm_pkg::*;
	import fpio_fifo_tests_pkg::*;
	import fpio_fifo_in_client_agent_pkg::*;
	
	reg[15:0]                       rst_cnt = 0;
	reg                             rstn = 0;

	reg clk_r = 0;
	assign clk = clk_r;

	initial begin
		forever begin
			#10ns;
			clk_r <= 1;
			#10ns;
			clk_r <= 0;
		end
	end

	always @(posedge clk) begin
		if (rst_cnt == 100) begin
			rstn <= 1;
		end else begin
			rst_cnt <= rst_cnt + 1;
		end
	end	
	
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
			.FIFO_DEPTH  (FIFO_BITS ), 
			.DATA_WIDTH  (DATA_WIDTH )
		) u_in_bfm (
			.clk         (clk        				), 
			.rstn        (rstn       				), 
			.client      (u_fifo2bfm.fifo_in_client	));
	
	typedef fpio_fifo_in_client_config #(FIFO_BITS, DATA_WIDTH) fpio_fifo_in_client_config_t;
	
	initial begin
		automatic fpio_fifo_in_client_config_t in_cfg =
			fpio_fifo_in_client_config_t::type_id::create("in_cfg");
		
		in_cfg.vif = u_in_bfm.u_core;
		
		uvm_config_db #(fpio_fifo_in_client_config_t)::set(uvm_top, "*m_in_agent*",
				fpio_fifo_in_client_config_t::report_id, in_cfg);
		
		run_test();
	end

endmodule

