onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /vga_tb/clk
add wave -noupdate /vga_tb/paddle_x
add wave -noupdate /vga_tb/ball_x
add wave -noupdate /vga_tb/ball_y
add wave -noupdate /vga_tb/bricks
add wave -noupdate /vga_tb/draw_mode
add wave -noupdate /vga_tb/red
add wave -noupdate /vga_tb/green
add wave -noupdate /vga_tb/blue
add wave -noupdate /vga_tb/H_sync
add wave -noupdate /vga_tb/V_sync
add wave -noupdate -divider SyncXY
add wave -noupdate /vga_tb/VGA_Imp/Sync_Imp/x
add wave -noupdate /vga_tb/VGA_Imp/Sync_Imp/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7413715451 ps} 0}
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
WaveRestoreZoom {7322402592 ps} {10140926180 ps}
