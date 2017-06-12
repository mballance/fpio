

`include "uvm_macros.svh"
package fpio_uvm_tests_pkg;
	import uvm_pkg::*;
	import fpio_uvm_env_pkg::*;
	import fpio_fifo_in_client_agent_pkg::*;
	import fpio_fifo_out_client_agent_pkg::*;
	
	`include "fpio_uvm_test_base.svh"
	`include "fpio_uvm_smoke_test.svh"
	
endpackage
