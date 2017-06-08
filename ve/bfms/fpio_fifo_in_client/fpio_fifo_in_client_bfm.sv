/****************************************************************************
 * fpio_fifo_client_bfm.sv
 ****************************************************************************/
 
interface fpio_fifo_in_client_bfm_core #(
		parameter int	FIFO_DEPTH=16,
		parameter int	DATA_WIDTH=8
		) (
		input							clk,
		input							rstn
		);
	bit					rst_received = 0;
	bit					rst_enter = 0;
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
		end else begin
		end
	end
	
	task write(bit[DATA_WIDTH-1:0] data);
		$display("write: %0d", data);
	endtask
	

endinterface

/**
 * Interface: fpio_fifo_client_bfm
 * 
 * TODO: Add interface documentation
 */
interface fpio_fifo_in_client_bfm #(
		parameter int FIFO_DEPTH=16, 
		parameter int DATA_WIDTH=8
		) (
		input							clk,
		input							rstn,
		fpio_fifo_if.fifo_in_client		client
		);

	fpio_fifo_in_client_bfm_core #(
		.FIFO_DEPTH  (FIFO_DEPTH ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) u_core (
		.clk         (clk        ), 
		.rstn        (rstn       ));


endinterface


