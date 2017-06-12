/****************************************************************************
 * fpio_uvm_tb.sv
 ****************************************************************************/

/**
 * Module: fpio_uvm_tb
 * 
 * TODO: Add module documentation
 */
`include "uvm_macros.svh"
module fpio_uvm_tb;
	import uvm_pkg::*;
	import fpio_uvm_tests_pkg::*;
	import fpio_fifo_in_client_agent_pkg::*;
	import fpio_fifo_out_client_agent_pkg::*;
	import generic_sram_line_en_master_agent_pkg::*;

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
	localparam int NUM_ADDR_BITS = 4;
	localparam int NUM_DATA_BITS = 32;
	
	wire irq;
	generic_sram_line_en_if #(
		.NUM_ADDR_BITS  (NUM_ADDR_BITS ), 
		.NUM_DATA_BITS  (NUM_DATA_BITS )
		) host_if ();
	
	fpio_fifo_if #(
			.FIFO_BITS   (FIFO_BITS		), 
			.DATA_WIDTH  (DATA_WIDTH	)
		) fpio2ext (
		);
	
	fpio_fifo_if #(
			.FIFO_BITS   (FIFO_BITS		), 
			.DATA_WIDTH  (DATA_WIDTH	)
		) ext2fpio (
		);	
	
	fpio #(
		.FIFO_BITS  (FIFO_BITS )
		) u_fpio (
		.clk        (clk       			), 
		.rstn       (rstn      			), 
		.irq        (irq       			), 
		.host_if    (host_if.sram 		), 
		.dat_o      (fpio2ext.fifo_out	), 
		.dat_i      (ext2fpio.fifo_in	));

	fpio_fifo_in_client_bfm #(
			.FIFO_BITS   (FIFO_BITS ), 
			.DATA_WIDTH  (DATA_WIDTH )
		) u_ext2fpio (
			.clk         (clk        				), 
			.rstn        (rstn       				), 
			.client      (ext2fpio.fifo_in_client	));
	
	fpio_fifo_out_client_bfm #(
			.FIFO_BITS   (FIFO_BITS ), 
			.DATA_WIDTH  (DATA_WIDTH )
		) u_fpio2ext (
			.clk         (clk        				), 
			.rstn        (rstn       				), 
			.client      (fpio2ext.fifo_out_client));
	
	generic_sram_line_en_master_bfm #(
		.NUM_ADDR_BITS  (NUM_ADDR_BITS ), 
		.NUM_DATA_BITS  (NUM_DATA_BITS )
		) u_sram_bfm (
		.clk            (clk           			), 
		.rstn           (rstn          			), 
		.client         (host_if.sram_client	));
	
	typedef fpio_fifo_in_client_config #(FIFO_BITS, DATA_WIDTH) fpio_fifo_in_client_config_t;
	typedef fpio_fifo_out_client_config #(FIFO_BITS, DATA_WIDTH) fpio_fifo_out_client_config_t;
	typedef generic_sram_line_en_master_config #(NUM_ADDR_BITS, NUM_DATA_BITS) generic_sram_line_en_master_config_t;
	
	initial begin
		automatic fpio_fifo_in_client_config_t in_cfg =
			fpio_fifo_in_client_config_t::type_id::create("in_cfg");
		automatic fpio_fifo_out_client_config_t out_cfg =
			fpio_fifo_out_client_config_t::type_id::create("out_cfg");
		automatic generic_sram_line_en_master_config_t sram_cfg =
			generic_sram_line_en_master_config_t::type_id::create("sram_cfg");
		
		in_cfg.vif = u_ext2fpio.u_core;
		out_cfg.vif = u_fpio2ext.u_core;
		sram_cfg.vif = u_sram_bfm.u_core;
		
		uvm_config_db #(fpio_fifo_in_client_config_t)::set(uvm_top, "*m_ext2fpio_agent*",
				fpio_fifo_in_client_config_t::report_id, in_cfg);
		uvm_config_db #(fpio_fifo_out_client_config_t)::set(uvm_top, "*m_fpio2ext_agent*",
				fpio_fifo_out_client_config_t::report_id, out_cfg);
		uvm_config_db #(generic_sram_line_en_master_config_t)::set(uvm_top, 
				"*m_sram_agent*", generic_sram_line_en_master_config_t::report_id, sram_cfg);
		
		run_test();
	end

endmodule

