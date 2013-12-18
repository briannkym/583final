onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /raster_test/x_pos
add wave -noupdate -radix unsigned /raster_test/y_pos
add wave -noupdate -radix unsigned /raster_test/paddle_x
add wave -noupdate -radix unsigned /raster_test/ball_x
add wave -noupdate -radix unsigned /raster_test/ball_y
add wave -noupdate -radix hexadecimal /raster_test/bricks
add wave -noupdate -radix hexadecimal /raster_test/score
add wave -noupdate -radix hexadecimal /raster_test/lives
add wave -noupdate -radix hexadecimal /raster_test/draw_mode
add wave -noupdate -radix hexadecimal /raster_test/R
add wave -noupdate -radix hexadecimal /raster_test/G
add wave -noupdate -radix hexadecimal /raster_test/B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {448412 ps} 0}
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
WaveRestoreZoom {0 ps} {1024 ns}
