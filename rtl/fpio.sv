/****************************************************************************
 * fpio.sv
 ****************************************************************************/

/**
 * Module: fpio
 * 
 * TODO: Add module documentation
 */
module fpio #(
			parameter int FIFO_BITS=8
		) (
			input 							clk,
			input							rstn,
			output							irq,
			generic_sram_line_en_if.sram	host_if,
			fpio_fifo_if.fifo_out			dat_o,
			fpio_fifo_if.fifo_in			dat_i
		);
	
	localparam DATA_WIDTH = 8;
	
	// TODO: register access
	// - O FIFO
	// - O Avail
	// - I FIFO
	// - I Avail
	reg[31:0]			divisor;
	
	reg					irq_r;
	assign irq = irq_r;
	
	reg					fifo_w_en;
	reg					fifo_r_en;
	reg[DATA_WIDTH-1:0]	fifo_w_data;
	
	fpio_fifo_if #(
		.FIFO_BITS   (FIFO_BITS  ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) host2ext_fifo_if ();
	
	fpio_fifo_if #(
		.FIFO_BITS   (FIFO_BITS  ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) ext2host_fifo_if ();
	
	assign host2ext_fifo_if.data    = 
		(fifo_w_en)?fifo_w_data:host_if.write_data[DATA_WIDTH-1:0];
	assign host2ext_fifo_if.data_en = fifo_w_en;

	assign host_if.read_data = 
		(host_if.addr == 1)?host2ext_fifo_if.avail:
		(host_if.addr == 2)?ext2host_fifo_if.data:
		(host_if.addr == 3)?ext2host_fifo_if.avail:0;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			irq_r <= 0;
			divisor <= 0;
			fifo_w_en <= 0;
			fifo_r_en <= 0;
		end else begin
			fifo_w_en <= 0;
			fifo_r_en <= 0;
			if (host_if.read_en == 1) begin
				case (host_if.addr)
					0: begin
						fifo_r_en <= 1;
					end
				endcase
			end
			
			if (host_if.write_en == 1) begin
				case (host_if.addr)
					0: begin
						fifo_w_en <= 1;
						fifo_w_data <= host_if.write_data[DATA_WIDTH-1:0];
					end
				endcase
			end
		end
	end
	
	fpio_fifo #(
		.FIFO_BITS   (FIFO_BITS  ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) u_host2ext (
		.clk         (clk        				), 
		.rstn        (rstn       				), 
		.in          (host2ext_fifo_if.fifo_in	), 
		.out         (dat_o      				));
	
	fpio_fifo #(
		.FIFO_BITS   (FIFO_BITS  ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) u_ext2host (
		.clk         (clk        				), 
		.rstn        (rstn       				), 
		.in          (dat_i      				), 
		.out         (ext2host_fifo_if.fifo_out	));
	
endmodule


