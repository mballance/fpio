
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

-f ${FPIO}/rtl/rtl.f

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f

// Simulation memories
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f
//-f ${MEMORY_PRIMITIVES}/rtl/fpga/altsyncram/rtl.f
//${QUARTUS_ROOTDIR}/eda/sim_lib/cyclonev_atoms.v
//${QUARTUS_ROOTDIR}/eda/sim_lib/altera_primitives.v
//${QUARTUS_ROOTDIR}/eda/sim_lib/altera_lnsim.sv
//${QUARTUS_ROOTDIR}/eda/sim_lib/altera_mf.v
//${QUARTUS_ROOTDIR}/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v



-f ${STD_PROTOCOL_IF}/rtl/rtl.f

-F ${FPIO}/ve/bfms/fpio_fifo_in_client/uvm/sve.F
${FPIO}/ve/bfms/fpio_fifo_in_client/fpio_fifo_in_client_bfm.sv

-F ${FPIO}/ve/bfms/fpio_fifo_out_client/uvm/sve.F
${FPIO}/ve/bfms/fpio_fifo_out_client/fpio_fifo_out_client_bfm.sv

-F ${SV_BFMS}/generic_sram_line_en_master/uvm/sve.F
${SV_BFMS}/generic_sram_line_en_master/generic_sram_line_en_master_bfm.sv

${SIM_DIR_A}/../tb/fpio_uvm_env_pkg.sv

${SIM_DIR_A}/../tests/fpio_uvm_tests_pkg.sv

${SIM_DIR_A}/../tb/fpio_uvm_tb.sv


