onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top_registr_sedmi_segment/stop
add wave -noupdate -expand /tb_top_registr_sedmi_segment/seg_4_7
add wave -noupdate -expand /tb_top_registr_sedmi_segment/seg_0_3
add wave -noupdate /tb_top_registr_sedmi_segment/res
add wave -noupdate -expand /tb_top_registr_sedmi_segment/input
add wave -noupdate /tb_top_registr_sedmi_segment/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {130441 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {119593 ns} {136407 ns}
