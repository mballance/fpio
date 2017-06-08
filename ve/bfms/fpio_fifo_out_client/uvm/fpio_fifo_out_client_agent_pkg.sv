
`include "uvm_macros.svh"

`define fpio_fifo_out_client_plist  #(parameter int FIFO_BITS=16, parameter int DATA_WIDTH=8)
`define fpio_fifo_out_client_params #(FIFO_BITS, DATA_WIDTH)
`define fpio_fifo_out_client_vif_t virtual fpio_fifo_out_client_bfm_core `fpio_fifo_out_client_params

package fpio_fifo_out_client_agent_pkg;
	import uvm_pkg::*;

	`include "fpio_fifo_out_client_config.svh"
	`include "fpio_fifo_out_client_seq_item.svh"
	`include "fpio_fifo_out_client_driver.svh"
	`include "fpio_fifo_out_client_monitor.svh"
	`include "fpio_fifo_out_client_seq_base.svh"
	`include "fpio_fifo_out_client_directed_seq.svh"
	`include "fpio_fifo_out_client_agent.svh"
endpackage



