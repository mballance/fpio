
class fpio_fifo_out_client_directed_seq `fpio_fifo_out_client_plist extends fpio_fifo_out_client_seq_base `fpio_fifo_out_client_params;

	typedef fpio_fifo_out_client_directed_seq `fpio_fifo_out_client_params this_t;
	`uvm_object_param_utils (this_t)
	
	typedef fpio_fifo_out_client_seq_item `fpio_fifo_out_client_params fpio_fifo_out_client_seq_item_t;

	rand fpio_fifo_out_client_seq_item_t		m_item = 
		fpio_fifo_out_client_seq_item_t::type_id::create("m_item");
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name="fpio_fifo_out_client_directed_seq");
		super.new(name);
	endfunction
	
	/****************************************************************
	 * body()
	 ****************************************************************/
	task body();
		start_item(m_item);
		finish_item(m_item);
		$display("m_item.data=%d", m_item.data);
//		get_response(m_item);
//		$display("m_item.data(2)=%d", m_item.data);
	endtask

endclass



