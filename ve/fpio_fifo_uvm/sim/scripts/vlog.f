
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

-f ${FPIO}/rtl/rtl.f

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f

// Simulation memories
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f

-f ${STD_PROTOCOL_IF}/rtl/rtl.f

-F ${FPIO}/ve/bfms/fpio_fifo_in_client/uvm/sve.F
${FPIO}/ve/bfms/fpio_fifo_in_client/fpio_fifo_in_client_bfm.sv


${SIM_DIR_A}/../tb/fpio_fifo_env_pkg.sv

${SIM_DIR_A}/../tests/fpio_fifo_tests_pkg.sv

${SIM_DIR_A}/../tb/fpio_fifo_tb.sv


