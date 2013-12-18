onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /kbd_control_tb/clock
add wave -noupdate /kbd_control_tb/reset
add wave -noupdate /kbd_control_tb/keyboard_clk
add wave -noupdate /kbd_control_tb/keyboard_data
add wave -noupdate /kbd_control_tb/scan_code
add wave -noupdate /kbd_control_tb/scan_ready
add wave -noupdate /kbd_control_tb/LEDs
add wave -noupdate /kbd_control_tb/control_en
add wave -noupdate /kbd_control_tb/control_mode
add wave -noupdate /kbd_control_tb/control_signal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1265035649 ps} 0}
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
WaveRestoreZoom {0 ps} {1973323838 ps}
