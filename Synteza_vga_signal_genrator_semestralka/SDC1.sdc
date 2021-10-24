create_clock -name clk -period 20 [get_ports {clk}]
#derive_pll_clocks
#derive_clock_uncertainty

create_generated_clock -name clk_pll -source [get_ports {clk}] -divide_by 2 [get_registers {T_async:T_async1|output_Q}]

set_false_path -to [get_ports {vga_hsync vga_vsync}]
set_false_path -from [get_ports {n_reset}]

# tohl bude asi špatně
set_false_path -to [get_ports {vga_b[*] vga_g[*] vga_r[*] vga_blank vga_sync vga_clk}]
