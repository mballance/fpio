/****************************************************************************
 * fpio_if.sv
 ****************************************************************************/

/**
 * Interface: fpio_if
 * 
 * TODO: Add interface documentation
 */
interface fpio_if #(parameter int DATA_WIDTH=4);
	bit[DATA_WIDTH-1:0]		DAT;
	bit						DAT_v;
	bit						DAT_r;
	
	
	modport xmit(
			output	DAT, 
			output	DAT_v,
			input	DAT_r);
	
	modport recv(
			input 	DAT, 
			input 	DAT_v,
			output	DAT_r);


endinterface


