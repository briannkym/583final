onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /digit_test/rainbow
add wave -noupdate -radix unsigned /digit_test/number
add wave -noupdate -radix unsigned /digit_test/x
add wave -noupdate -radix unsigned /digit_test/y
add wave -noupdate -radix hexadecimal /digit_test/R
add wave -noupdate -radix hexadecimal /digit_test/G
add wave -noupdate -radix hexadecimal /digit_test/B
add wave -noupdate /digit_test/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {914607 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {4096 ns}
