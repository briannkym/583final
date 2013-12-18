onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /kbd_tb/clock
add wave -noupdate /kbd_tb/reset
add wave -noupdate /kbd_tb/keyboard_clk
add wave -noupdate /kbd_tb/keyboard_data
add wave -noupdate -radix hexadecimal /kbd_tb/scan_code
add wave -noupdate /kbd_tb/scan_ready
add wave -noupdate /kbd_tb/LEDs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {2286725128 ps}
