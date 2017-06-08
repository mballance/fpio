

class fpio_fifo_out_client_monitor `fpio_fifo_out_client_plist extends uvm_monitor;


	typedef fpio_fifo_out_client_seq_item `fpio_fifo_out_client_params item_t;
	typedef fpio_fifo_out_client_monitor `fpio_fifo_out_client_params this_t;
	typedef fpio_fifo_out_client_config `fpio_fifo_out_client_params  cfg_t;
	
	uvm_analysis_port #(item_t)		ap;
	
	cfg_t							m_cfg;
	
	const string report_id = "fpio_fifo_out_client_monitor";
	
	`uvm_component_param_utils(this_t)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		// Obtain the config object
		m_cfg = cfg_t::get_config(this);
	
		// Create the analysis port
		ap = new("ap", this);

	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		// TODO: implement fpio_fifo_out_client_monitor run_phase
	endtask
	
	
endclass


