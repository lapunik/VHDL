vcom -work work sedmi_segment.vhd
vcom -work work tb_sedmi_segment.vhd
vsim work.tb_sedmi_segment
do wave.do
run -all
