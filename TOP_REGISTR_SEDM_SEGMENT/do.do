vcom -work work registr_8bit_async.vhd
vcom -work work sedmi_segment_async.vhd
vcom -work work top_registr_sedmi_segment.vhd
vcom -work work tb_top_registr_sedmi_segment.vhd

vsim work.tb_top_registr_sedmi_segment

do wave.do
run -all
