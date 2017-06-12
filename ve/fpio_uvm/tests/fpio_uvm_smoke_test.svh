
class fpio_uvm_smoke_test extends fpio_uvm_test_base;
	
	`uvm_component_utils(fpio_uvm_smoke_test)
	
	typedef fpio_fifo_out_client_directed_seq #(
			fpio_uvm_env::FIFO_BITS, 
			fpio_uvm_env::DATA_WIDTH) fpio_fifo_out_client_directed_seq_t;
	typedef fpio_fifo_in_client_directed_seq #(
			fpio_uvm_env::FIFO_BITS, 
			fpio_uvm_env::DATA_WIDTH) fpio_fifo_in_client_directed_seq_t;
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * build_phase()
	 ****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	/****************************************************************
	 * connect_phase()
	 ****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		bit[31:0]	data;
		fpio_fifo_out_client_directed_seq_t out_seq =
			fpio_fifo_out_client_directed_seq_t::type_id::create("out_seq");
		fpio_fifo_in_client_directed_seq_t in_seq =
			fpio_fifo_in_client_directed_seq_t::type_id::create("in_seq");
		
		phase.raise_objection(this, "Main");
		m_env.m_sram_agent.write(0, 1);
		m_env.m_sram_agent.write(0, 2);
		m_env.m_sram_agent.write(0, 3);
		m_env.m_sram_agent.write(0, 4);
		
		m_env.m_sram_agent.read(1, data);
		$display("Space remaining: %0d", data);
		
		m_env.m_sram_agent.read(1, data);
		$display("Space remaining: %0d", data);
		
		m_env.m_sram_agent.read(1, data);
		$display("Space remaining: %0d", data);
	
		out_seq.start(m_env.m_fpio2ext_agent.m_seqr);
		$display("Data: %0d", out_seq.m_item.data);
		
		m_env.m_sram_agent.read(3, data);
		$display("Bytes available: %0d", data);
		
		// Send in some data
		in_seq.m_item.data = 5;
		in_seq.start(m_env.m_ext2fpio_agent.m_seqr);
		
		m_env.m_sram_agent.read(3, data);
		$display("Bytes available: %0d", data);
		m_env.m_sram_agent.read(3, data);
		$display("Bytes available: %0d", data);
		
		phase.drop_objection(this, "Main");
	endtask
	
endclass



