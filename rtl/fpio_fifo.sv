/****************************************************************************
 * fpio_fifo.sv
 ****************************************************************************/

/**
 * Module: fpio_fifo
 * 
 * TODO: Add module documentation
 */
module fpio_fifo #(
		parameter int		FIFO_BITS,
		parameter int		DATA_WIDTH
		) (
			input					clk,
			input					rstn,
			// Provides data to the FIFO
			fpio_fifo_if.fifo_in	in,
			// Consumes data from the FIFO
			fpio_fifo_if.fifo_out	out
		);

	wire [FIFO_BITS:0]		fifo_sz = (1 << FIFO_BITS);
	reg[FIFO_BITS-1:0]		fifo_top;
	reg[FIFO_BITS-1:0]		fifo_bottom;
	reg[FIFO_BITS:0]		fifo_count;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			fifo_top 	<= 0;
			fifo_bottom <= 0;
			fifo_count 	<= 0;
		end else begin
			case ({in.data_en, out.data_en})
				2'b10: begin
					fifo_top <= fifo_top + 1;
					fifo_count <= fifo_count + 1;
				end
				2'b01: begin
					fifo_bottom <= fifo_bottom + 1;
					if (fifo_count != 0) begin
						fifo_count <= fifo_count - 1;
					end
				end
				2'b11: begin
					fifo_bottom <= fifo_bottom + 1;
					fifo_top 	<= fifo_top + 1;
				end
			endcase
		end
	end
	
	assign in.avail = (fifo_sz - fifo_count);
	assign out.avail = fifo_count;
	
	generic_sram_line_en_if #(
		.NUM_ADDR_BITS  (FIFO_BITS ), 
		.NUM_DATA_BITS  (DATA_WIDTH )
		) u_in2ram ();
	
	generic_sram_line_en_if #(
		.NUM_ADDR_BITS  (FIFO_BITS ), 
		.NUM_DATA_BITS  (DATA_WIDTH )
		) u_ram2out ();

	// What to assume about SRAM timing?

	assign u_in2ram.addr = fifo_top;
	assign u_in2ram.write_en = in.data_en;
	assign u_in2ram.read_en = 0;
	assign u_in2ram.write_data = in.data;
	
	generic_sram_line_en_dualport_w #(
		.MEM_ADDR_BITS  (FIFO_BITS ), 
		.MEM_DATA_BITS  (DATA_WIDTH )
		) u_ram (
		.i_clk          (clk			), 
		.s_a            (u_in2ram.sram  ), 
		.s_b            (u_ram2out.sram ));

	assign u_ram2out.addr = fifo_bottom;
	assign u_ram2out.write_en = 0;
	assign u_ram2out.read_en = 1;
	assign out.data = u_ram2out.read_data;
	assign u_ram2out.write_data = 0;
	

endmodule


