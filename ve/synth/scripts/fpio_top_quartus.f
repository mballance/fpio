
-f ${MEMORY_PRIMITIVES}/rtl/fpga/altsyncram/rtl.f

-f ${FPIO}/rtl/rtl.f

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f

${SYNTH_DIR}/fpio_top.sv

/**
 * Port mapping
 */
-assign-pin clk_i PIN_K14
-assign-pin pad0_o PIN_AF10
-assign-pin pad1_o PIN_AD10
-assign-pin pad2_o PIN_AE11
-assign-pin pad3_o PIN_AD7

/**
 * Voltage
 */
-io-standard clk_i "3.3-V LVTTL"
-io-standard pad0_o "3.3-V LVTTL"
-io-standard pad1_o "3.3-V LVTTL"
-io-standard pad2_o "3.3-V LVTTL"
-io-standard pad3_o "3.3-V LVTTL"

