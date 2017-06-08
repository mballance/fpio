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
	
	localparam VALID_DELAY = 1;
	
	// Push state machine
	reg[1:0]				push_state;
	reg						push_done;
	reg[VALID_DELAY-1:0]	push_valid;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			push_state <= 0;
			push_valid <= 0;
			push_done <= 0;
		end else begin
			push_done <= in.data_en;
//			push_valid <= (push_valid << 1);
//			case (push_state) 
//				0: begin
//					push_done <= 0;
//					if (in.data_en) begin
//						push_state <= 1;
//						push_valid[0] <= 1;
//					end
//				end
//				1: begin
//					if (push_valid[VALID_DELAY-1]) begin
//						push_state <= 0;
//						push_done <= 1;
//					end
//				end
//			endcase
		end
	end
//	assign u_in2ram.write_en = (in.data_en | push_state == 1);
	assign u_in2ram.write_en = in.data_en;
//	assign in.data_ack = push_valid[VALID_DELAY-1];
	assign in.data_ack = push_done;
	
	// Pop state machine
	localparam POP_DELAY = 1;
	reg[1:0]				pop_state;
	reg						pop_done;
	reg[POP_DELAY-1:0]		pop_valid;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			pop_state <= 0;
			pop_valid <= 0;
			pop_done  <= 0;
		end else begin
			pop_done <= out.data_en;
//			pop_valid <= (pop_valid << 1);
//			case (pop_state)
//				0: begin
//					pop_done <= 0;
//					if (out.data_en) begin
//						pop_state <= 1;
//						pop_valid[0] <= 1;
//					end
//				end
//				1: begin
//					if (pop_valid[POP_DELAY-1]) begin
//						pop_state <= 0;
//						pop_done <= 1;
//					end
//				end
//			endcase
		end
	end
//	assign out.data_ack = pop_valid[POP_DELAY-1];
	assign out.data_ack = pop_done;

	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			fifo_top 	<= 0;
			fifo_bottom <= 0;
			fifo_count 	<= 0;
		end else begin
			case ({push_done, pop_done})
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


