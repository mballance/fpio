
class fpio_env extends uvm_env;
	`uvm_component_utils(fpio_env)

	localparam FIFO_DEPTH = 8;
	localparam DATA_WIDTH = 8;
	
	typedef fpio_fifo_in_client_agent #(FIFO_DEPTH, DATA_WIDTH) fpio_fifo_in_client_agent_t;
	
	fpio_fifo_in_client_agent_t				m_in_agent;
	
	

	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	/**
	 * Function: build_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void build_phase(input uvm_phase phase);
		super.build_phase(phase);
		
		m_in_agent = fpio_fifo_in_client_agent_t::type_id::create("m_in_agent", this);
	endfunction

	/**
	 * Function: connect_phase
	 *
	 * Override from class uvm_component
	 */
	virtual function void connect_phase(input uvm_phase phase);
		super.connect_phase(phase);
	endfunction
	
	
endclass
