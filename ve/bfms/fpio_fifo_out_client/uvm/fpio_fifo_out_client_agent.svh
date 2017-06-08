

/**
 * Class: fpio_fifo_out_client_agent
 */
class fpio_fifo_out_client_agent `fpio_fifo_out_client_plist extends uvm_agent;
	
	typedef fpio_fifo_out_client_agent  `fpio_fifo_out_client_params this_t;
	`uvm_component_param_utils (this_t)


	const string report_id = "fpio_fifo_out_client_agent";
	
	typedef fpio_fifo_out_client_driver `fpio_fifo_out_client_params 	drv_t;
	typedef fpio_fifo_out_client_config `fpio_fifo_out_client_params 	cfg_t;
	typedef fpio_fifo_out_client_monitor `fpio_fifo_out_client_params	mon_t;
	typedef fpio_fifo_out_client_seq_item `fpio_fifo_out_client_params item_t;

	drv_t							m_driver;
	uvm_sequencer #(item_t)			m_seqr;
	mon_t							m_monitor;
	
	uvm_analysis_port #(item_t)		m_mon_out_ap;
	uvm_analysis_port #(item_t)		m_drv_out_ap;
	
	cfg_t							m_cfg;
	
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		// Obtain the config object for this agent
		m_cfg = cfg_t::get_config(this);
		
		if (m_cfg.has_driver) begin
			m_driver = drv_t::type_id::create("m_driver", this);
			
			// Create driver analysis port
			m_drv_out_ap = new("m_drv_out_ap", this);
		end
		
		if (m_cfg.has_sequencer) begin
			m_seqr = new("m_seqr", this);
		end
	
		if (m_cfg.has_monitor) begin
			m_monitor = mon_t::type_id::create("m_monitor", this);
			
			// Create the monitor analysis port
			m_mon_out_ap = new("m_mon_out_ap", this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		// Connect the driver and sequencer
		if (m_cfg.has_driver && m_cfg.has_sequencer) begin
			m_driver.seq_item_port.connect(m_seqr.seq_item_export);
		end
		
		if (m_cfg.has_monitor) begin
			// Connect the monitor to the monitor AP
			m_monitor.ap.connect(m_mon_out_ap);
		end
		
		if (m_cfg.has_driver) begin
			// Connect the driver to the driver AP
			m_driver.ap.connect(m_drv_out_ap);
		end
		
	endfunction
	

endclass



