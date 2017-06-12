/****************************************************************************
 * wb_fpio.sv
 ****************************************************************************/

/**
 * Module: wb_fpio
 * 
 * TODO: Add module documentation
 */
module wb_fpio #(
			parameter int FIFO_BITS=8
		) (
			input					clk,
			input					rstn,
			output					irq,
			wb_if.slave				s,
			fpio_fifo_if.fifo_out	dat_o,
			fpio_fifo_if.fifo_in	dat_i
		);
	
	localparam ADDRESS_WIDTH = 4;
	localparam DATA_WIDTH = 32;
	
	generic_sram_line_en_if #(
		.NUM_ADDR_BITS  (ADDRESS_WIDTH	), 
		.NUM_DATA_BITS  (DATA_WIDTH		)
		) sram_if ();
	
	wb_generic_line_en_sram_bridge #(
		.ADDRESS_WIDTH  (ADDRESS_WIDTH ), 
		.DATA_WIDTH     (DATA_WIDTH    )
		) u_bridge (
		.clk            (clk           			), 
		.rstn           (rstn          			), 
		.wb_s           (s          			),
		.sram_m         (sram_if.sram_client	));
	
	fpio #(
		.FIFO_BITS  (FIFO_BITS )
		) u_fpio (
		.clk        (clk       		), 
		.rstn       (rstn      		), 
		.irq        (irq       		), 
		.host_if    (sram_if.sram   ), 
		.dat_o      (dat_o     		), 
		.dat_i      (dat_i     		));


endmodule


