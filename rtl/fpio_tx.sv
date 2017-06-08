/****************************************************************************
 * fpio_tx.sv
 ****************************************************************************/

/**
 * Module: fpio_tx
 * 
 * TODO: Add module documentation
 */
module fpio_tx #(
		parameter int DATA_WIDTH=4
		) (
		input				clk,
		input				rstn,
		input [31:0]		divisor,
		fpio_if.xmit		dat_o
		);
	
	reg[3:0]			state;
	wire[29:0]			divisor_d4 = divisor[31:2];
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			state <= 0;
		end else begin
			case (state)
				0: begin
				end
				
				1: begin
				end
			endcase
		end
	end


endmodule


