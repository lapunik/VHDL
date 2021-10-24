create_clock -name clk -period 10.000 [get_ports {input_CLK}]
set_false_path -from [get_ports {input_RESTART}]
set_false_path -to [get_ports {output_SEGMENT_0_3[*] output_SEGMENT_4_7[*]}]