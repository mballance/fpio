/****************************************************************************
 * fpio_fifo_client_bfm.sv
 ****************************************************************************/
 
interface fpio_fifo_out_client_bfm_core #(
		parameter int	FIFO_BITS=16,
		parameter int	DATA_WIDTH=8
		) (
		input							clk,
		input							rstn
		);
	bit						rst_received = 0;
	bit						rst_enter = 0;
	bit[DATA_WIDTH-1:0]		data_val;
	wire[DATA_WIDTH-1:0]	data;
	bit						data_wait = 0;
	bit						data_wait_ack = 0;
	bit[3:0]				state = 0;
	wire[FIFO_BITS:0]		avail;
	bit						data_en;
	wire					data_ack;	
	
	always @(posedge clk or rstn) begin
		if (rstn == 0) begin
			state <= 0;
			rst_enter <= 1;
			rst_received <= 0;
		end else begin
			if (rst_enter) begin
				rst_received <= 1;
				rst_enter <= 0;
			end
			
			case (state)
				0: begin
					if (data_wait && avail != 0) begin
						data_en <= 1;
						state <= 1;
						data_wait = 0;
					end
				end
				
				1: begin
					data_en <= 0;
					if (data_ack) begin
						state <= 0;
						data_val = data;
						data_wait_ack = 1;
					end
				end
			endcase
		end
	end

	task automatic read(output[DATA_WIDTH-1:0] d);
		while (rst_received == 0) begin
			@(posedge clk);
		end

		data_wait = 1;
		
		while (data_wait_ack == 0) begin
			@(posedge clk);
		end
		data_wait_ack = 0;
		d = data_val;
		$display("Sending back data %0d %0d", data_val, d);
	endtask	

endinterface

/**
 * Interface: fpio_fifo_client_bfm
 * 
 * TODO: Add interface documentation
 */
interface fpio_fifo_out_client_bfm #(
		parameter int FIFO_BITS=16, 
		parameter int DATA_WIDTH=8
		) (
		input							clk,
		input							rstn,
		fpio_fifo_if.fifo_out_client		client
		);

	fpio_fifo_out_client_bfm_core #(
		.FIFO_BITS  (FIFO_BITS ), 
		.DATA_WIDTH  (DATA_WIDTH )
		) u_core (
		.clk         (clk        ), 
		.rstn        (rstn       ));

	assign u_core.avail = client.avail;
	assign u_core.data = client.data;
	assign client.data_en = u_core.data_en;
	assign u_core.data_ack = client.data_ack;

endinterface


