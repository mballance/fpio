

`include "uvm_macros.svh"
package fpio_fifo_tests_pkg;
	import uvm_pkg::*;
	import fpio_fifo_env_pkg::*;
	import fpio_fifo_in_client_agent_pkg::*;
	import fpio_fifo_out_client_agent_pkg::*;
	
	`include "fpio_fifo_test_base.svh"
	`include "fpio_fifo_smoke_test.svh"
	
endpackage
