
class fpio_fifo_smoke_test extends fpio_fifo_test_base;
	
	`uvm_component_utils(fpio_fifo_smoke_test)
	
	localparam FIFO_BITS = fpio_fifo_env::FIFO_BITS;
	localparam DATA_WIDTH = fpio_fifo_env::DATA_WIDTH;
	
	typedef fpio_fifo_in_client_directed_seq #(FIFO_BITS, DATA_WIDTH)
		fpio_fifo_in_client_directed_seq_t;
	typedef fpio_fifo_out_client_directed_seq #(FIFO_BITS, DATA_WIDTH)
		fpio_fifo_out_client_directed_seq_t;
	
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
		fpio_fifo_in_client_directed_seq_t seq = 
			fpio_fifo_in_client_directed_seq_t::type_id::create("seq");
		
		fork
			begin
				fpio_fifo_out_client_directed_seq_t seq_o = 
					fpio_fifo_out_client_directed_seq_t::type_id::create("seq_o");
				
				forever begin
					seq_o.start(m_env.m_out_agent.m_seqr);
					$display("Data Out: %0d", seq_o.m_item.data);
				end
			end
		join_none
		
		phase.raise_objection(this, "Main");
		for (int i=0; i<512; i++) begin
			seq.m_item.data = i+1;
			$display("--> start");
			seq.start(m_env.m_in_agent.m_seqr);
			$display("<-- start");
		end
		phase.drop_objection(this, "Main");
	endtask
	
endclass



