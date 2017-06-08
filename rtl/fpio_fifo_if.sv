/****************************************************************************
 * fpio_fifo_if.sv
 ****************************************************************************/

/**
 * Interface: fpio_fifo_if
 * 
 * TODO: Add interface documentation
 */
interface fpio_fifo_if #(
		parameter int			FIFO_BITS,
		parameter int			DATA_WIDTH
		);
	bit[FIFO_BITS:0]			avail;
	bit[DATA_WIDTH-1:0]			data;
	bit							data_en;
	bit							data_ack;
	
	
	modport fifo_in(
			output		avail,
			input		data,
			input		data_en,
			output		data_ack
		);
	
	modport fifo_in_client(
			input		avail,
			output		data,
			output		data_en,
			input		data_ack
		);
	
	modport fifo_out(
			output		avail,
			output		data,
			input		data_en,
			output		data_ack
		);
	
	modport fifo_out_client(
			input		avail,
			input		data,
			output		data_en,
			input		data_ack
		);
	

endinterface


