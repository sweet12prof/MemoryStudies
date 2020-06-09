

create_clock -period 2.600 -name clk -waveform {0.000 1.300} [get_ports clk]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {A[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {A[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports {WriteData[*]}]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {WriteData[*]}]
set_input_delay -clock [get_clocks clk] -min -add_delay 2.000 [get_ports WE]
set_input_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports WE]
set_output_delay -clock [get_clocks clk] -min -add_delay 0.000 [get_ports {ReadData[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay 2.000 [get_ports {ReadData[*]}]
