
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f
-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f

-f ${WB_SYS_IP}/rtl/wb_sram_bridges/wb_sram_bridges.f

-f ${FPIO}/rtl/wb_rtl.f

-F ./ve/bfms/fpio_fifo_in_client/uvm/sve.F
./ve/bfms/fpio_fifo_in_client/fpio_fifo_in_client_bfm.sv

-F ./ve/bfms/fpio_fifo_out_client/uvm/sve.F
./ve/bfms/fpio_fifo_out_client/fpio_fifo_out_client_bfm.sv

-f ${SV_BFMS}/sve.f

-F ./ve/fpio_fifo_uvm/sve.F

-F ./ve/fpio_uvm/sve.F
