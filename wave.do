onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_RR_Arbiter/clk
add wave -noupdate -radix binary /tb_RR_Arbiter/req
add wave -noupdate -radix binary /tb_RR_Arbiter/gnt
add wave -noupdate -radix binary /tb_RR_Arbiter/grant_mask
add wave -noupdate -radix binary /tb_RR_Arbiter/grant_unmask
add wave -noupdate -radix binary /tb_RR_Arbiter/label_req
add wave -noupdate -radix binary /tb_RR_Arbiter/label_req_mask
add wave -noupdate -radix binary /tb_RR_Arbiter/Pointer_Req_test
add wave -noupdate -radix binary /tb_RR_Arbiter/priority_mask
add wave -noupdate -radix binary /tb_RR_Arbiter/priority_unmask
add wave -noupdate -radix binary /tb_RR_Arbiter/q_test
add wave -noupdate -radix binary /tb_RR_Arbiter/req_mask
add wave -noupdate -radix binary /tb_RR_Arbiter/rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45900 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {202725 ps}
