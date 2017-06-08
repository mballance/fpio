
class fpio_fifo_in_client_seq_item `fpio_fifo_in_client_plist extends uvm_sequence_item;
	typedef fpio_fifo_in_client_seq_item `fpio_fifo_in_client_params this_t;
	`uvm_object_param_utils(this_t)
	
	const string report_id = "fpio_fifo_in_client_seq_item";

	bit[DATA_WIDTH-1:0]			data;
	
	// TODO: Declare fields here
	
	function new(string name="fpio_fifo_in_client_seq_item");
		super.new(name);
	endfunction

	// TODO: Declare do_print, do_compare, do_copy methods

	function void do_print(uvm_printer printer);
		if (printer.knobs.sprint == 0) begin
			$display(convert2string());
		end else begin
			printer.m_string = convert2string();
		end
	endfunction

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		bit ret = 1;
		fpio_fifo_in_client_seq_item rhs_;
		
		if (!$cast(rhs_, rhs)) begin
			return 0;
		end
		
		ret &= super.do_compare(rhs, comparer);
		
		// TODO: implement comparison logic
	
		return ret;
	endfunction

	function void do_copy(uvm_object rhs);
		fpio_fifo_in_client_seq_item rhs_;
		
		if (!$cast(rhs_, rhs)) begin
			`uvm_error(report_id, "Cast failed in do_copy()");
			return;
		end
		
		super.do_copy(rhs);
		
		// TODO: copy item-specific fields
		
	endfunction
			
endclass



