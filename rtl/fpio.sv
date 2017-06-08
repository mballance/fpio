/****************************************************************************
 * fpio.sv
 ****************************************************************************/

/**
 * Module: fpio
 * 
 * TODO: Add module documentation
 */
module fpio #(
		parameter int DATA_WIDTH=4
		) (
		input 							clk,
		input							rstn,
		output							irq,
		generic_sram_line_en_if.sram	host_if,
		fpio_if.xmit					dat_o,
		fpio_if.recv					dat_i
		);
	
	// TODO: register access
	// - divisor
	// - FIFO status level
	// - 
	reg[31:0]			divisor;
	
	reg					irq_r;
	assign irq = irq_r;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			irq_r <= 0;
			divisor <= 0;
		end else begin
			if (host_if.read_en == 1) begin
//				case (host_if.addr)
//				endcase
			end
			
			if (host_if.write_en == 1) begin
//				case (host_if.addr)
//				endcase
			end
		end
	end
	
	fpio_tx	#(
			.DATA_WIDTH(DATA_WIDTH)
			) u_tx (
			.clk(clk),
			.rstn(rstn),
			.divisor(divisor),
			.dat_o(dat_o)
		);

endmodule


