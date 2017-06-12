
class fpio_uvm_env extends uvm_env;
	`uvm_component_utils(fpio_uvm_env)
	
	localparam NUM_ADDR_BITS = 4;
	localparam NUM_DATA_BITS = 32;
	localparam FIFO_BITS = 8;
	localparam DATA_WIDTH = 8;
	
	typedef fpio_fifo_in_client_agent #(FIFO_BITS, DATA_WIDTH) fpio_fifo_in_client_agent_t;
	typedef fpio_fifo_out_client_agent #(FIFO_BITS, DATA_WIDTH) fpio_fifo_out_client_agent_t;
	typedef generic_sram_line_en_master_agent #(NUM_ADDR_BITS, NUM_DATA_BITS) generic_sram_line_en_master_agent_t;
	
	fpio_fifo_in_client_agent_t				m_ext2fpio_agent;
	fpio_fifo_out_client_agent_t			m_fpio2ext_agent;
	generic_sram_line_en_master_agent_t		m_sram_agent;

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
		
		m_ext2fpio_agent = fpio_fifo_in_client_agent_t::type_id::create("m_ext2fpio_agent", this);
		m_fpio2ext_agent = fpio_fifo_out_client_agent_t::type_id::create("m_fpio2ext_agent", this);
		m_sram_agent = generic_sram_line_en_master_agent_t::type_id::create("m_sram_agent", this);
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
