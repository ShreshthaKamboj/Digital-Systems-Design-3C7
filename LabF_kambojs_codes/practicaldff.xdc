## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_in ]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_in ]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_in]
 
## Switches
#set_property PACKAGE_PIN V17 [get_ports {reset}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
set_property PACKAGE_PIN V17 [get_ports {rst_n}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
set_property PACKAGE_PIN V16 [get_ports {sh_en}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sh_en}]
	
	
##7 segment display - Cathode pins
#set_property PACKAGE_PIN W7 [get_ports {led_out[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[6]}]
#set_property PACKAGE_PIN W6 [get_ports {led_out[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[5]}]
#set_property PACKAGE_PIN U8 [get_ports {led_out[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[4]}]
#set_property PACKAGE_PIN V8 [get_ports {led_out[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
#set_property PACKAGE_PIN U5 [get_ports {led_out[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
#set_property PACKAGE_PIN V5 [get_ports {led_out[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
#set_property PACKAGE_PIN U7 [get_ports {led_out[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]


##Anode Selects
#set_property PACKAGE_PIN U2 [get_ports {anode_sel[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {anode_sel[0]}]
#set_property PACKAGE_PIN U4 [get_ports {anode_sel[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {anode_sel[1]}]
#set_property PACKAGE_PIN V4 [get_ports {anode_sel[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {anode_sel[2]}]
#set_property PACKAGE_PIN W4 [get_ports {anode_sel[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {anode_sel[3]}]


###Buttons
#set_property PACKAGE_PIN U18 [get_ports button_input[4]]						
#	set_property IOSTANDARD LVCMOS33 [get_ports button_input[4]]
#set_property PACKAGE_PIN T18 [get_ports button_input[0]]						
#	set_property IOSTANDARD LVCMOS33 [get_ports button_input[0]]
#set_property PACKAGE_PIN W19 [get_ports button_input[1]]						
#	set_property IOSTANDARD LVCMOS33 [get_ports button_input[1]]
#set_property PACKAGE_PIN T17 [get_ports button_input[3]]						
#	set_property IOSTANDARD LVCMOS33 [get_ports button_input[3]]
#set_property PACKAGE_PIN U17 [get_ports button_input[2]]						
#	set_property IOSTANDARD LVCMOS33 [get_ports button_input[2]]
 
##LEDS
set_property PACKAGE_PIN U16 [get_ports {Q_out[0]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {Q_out[1]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {Q_out[2]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {Q_out[3]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[3]}]
set_property PACKAGE_PIN W18 [get_ports {Q_out[4]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[4]}]
set_property PACKAGE_PIN U15 [get_ports {Q_out[5]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[5]}]
set_property PACKAGE_PIN U14 [get_ports {Q_out[6]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[6]}]
set_property PACKAGE_PIN V14 [get_ports {Q_out[7]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[7]}]
set_property PACKAGE_PIN V13 [get_ports {Q_out[8]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[8]}]
set_property PACKAGE_PIN V3 [get_ports {Q_out[9]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[9]}]
set_property PACKAGE_PIN W3 [get_ports {Q_out[10]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[10]}]
set_property PACKAGE_PIN U3 [get_ports {Q_out[11]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[11]}]
set_property PACKAGE_PIN P3 [get_ports {Q_out[12]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Q_out[12]}]
set_property PACKAGE_PIN N3 [get_ports max_tick_reg]						
	set_property IOSTANDARD LVCMOS33 [get_ports max_tick_reg]

