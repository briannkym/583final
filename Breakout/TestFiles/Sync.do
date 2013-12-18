onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sync_test/clk
add wave -noupdate /sync_test/R_in
add wave -noupdate /sync_test/G_in
add wave -noupdate /sync_test/B_in
add wave -noupdate /sync_test/x
add wave -noupdate /sync_test/y
add wave -noupdate /sync_test/HSync
add wave -noupdate /sync_test/VSync
add wave -noupdate -radix hexadecimal /sync_test/R
add wave -noupdate -radix hexadecimal /sync_test/G
add wave -noupdate -radix hexadecimal /sync_test/B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {416932769 ps} 0}
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
WaveRestoreZoom {289460 ns} {551604 ns}
