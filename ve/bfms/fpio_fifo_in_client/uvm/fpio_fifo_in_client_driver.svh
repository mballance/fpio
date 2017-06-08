

class fpio_fifo_in_client_driver `fpio_fifo_in_client_plist extends uvm_driver #(fpio_fifo_in_client_seq_item);
	
	typedef fpio_fifo_in_client_driver `fpio_fifo_in_client_params this_t;
	typedef fpio_fifo_in_client_config `fpio_fifo_in_client_params cfg_t;
	
	`uvm_component_param_utils (this_t);

	const string report_id = "fpio_fifo_in_client_driver";
	
	uvm_analysis_port #(fpio_fifo_in_client_seq_item)		ap;
	
	cfg_t													m_cfg;
	
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		ap = new("ap", this);
		
		m_cfg = cfg_t::get_config(this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction
	
	task run_phase(uvm_phase phase);
		`fpio_fifo_in_client_vif_t			vif = m_cfg.vif;
		fpio_fifo_in_client_seq_item		item;
		
		forever begin
			seq_item_port.get_next_item(item);
			// TODO: execute the sequence item
//			item.print();
			
			vif.write(item.data);
			
			// Send the item to the analysis port
			ap.write(item);
			
			seq_item_port.item_done();
		end
	endtask
endclass



