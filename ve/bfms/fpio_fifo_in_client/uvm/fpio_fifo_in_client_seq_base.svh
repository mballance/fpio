

class fpio_fifo_in_client_seq_base `fpio_fifo_in_client_plist extends uvm_sequence #(fpio_fifo_in_client_seq_item);
	typedef fpio_fifo_in_client_seq_base `fpio_fifo_in_client_params this_t;
	`uvm_object_param_utils(this_t)
	
	static const string report_id = "fpio_fifo_in_client_seq_base";
	
	function new(string name="fpio_fifo_in_client_seq_base");
		super.new(name);
	endfunction
	
	task body();
		`uvm_error(report_id, "base-class body task not overridden");
	endtask
	
endclass



