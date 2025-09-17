module lab2(
    input speed_sel,
	 input resetb,
	 input clk,
	 input step_size,
	 input direction,
	 input on,
	 input quarter,
	 output [6:0] sev_seg_o, sev_seg_t,
	 output [3:0] pulses_out,
	 output wire en_counter_check,	// delete
	 output wire enable_check,			// delete
	 output wire prev_enable_check,	// delete
	 output wire [6:0] counter_check,			// delete
	 output wire count_ended_check
);

wire [2:0] curr_speed;
wire [31:0] cycles;  // connects from freq divider to counter cycle block.
wire freq_sm_enable;

speed_sm speed_sm_inst
(
	.speed_sel(speed_sel) ,	// input  speed_sel_sig
	.resetb(resetb) ,	// input  resetb_sig
	.curr_speed(curr_speed) 	// output [2:0] curr_speed_sig
);

speed_decoder speed_decoder_inst
(
	.digit(curr_speed) ,	// input [2:0] digit_sig
	.tens(sev_seg_t) ,	// output [6:0] tens_sig
	.units(sev_seg_o) 	// output [6:0] units_sig
);


freq_divider freq_divider_inst
(
	.speed_in(curr_speed) ,	// input [2:0] speed_in_sig
	.cycles(cycles) 	// output [31:0] cycles_sig
);


counter_cycle counter_cycle_inst
(
	.clk(clk) ,	// input  clk_sig
	.cycles(cycles) ,	// input [31:0] cycles_sig
	.carry_out(freq_sm_enable) 	// output  carry_out_sig
);


freq_sm freq_sm_inst
(
	.en(freq_sm_enable),	// input  en_sig
	.clk(clk),	// input  clk_sig
	.step_size(step_size) ,	// input  step_size_sig
	.dir(direction),	// input  dir_sig
	.on_switch(on),	// input  on_switch_sig
	.quarter(quarter),	// input  quarter_sig
	.resetb(resetb),	// input  resetb_sig
	.motor(pulses_out), 	// output [3:0] motor_sig
	.en_counter_check(en_counter_check),	// output  en_counter_check_sig     delete
	.enable_check(enable_check),				// output  enable_check_sig			delete
	.prev_enable_check(prev_enable_check),	// output  prev_enable_check_sig 	delete
	.counter_check(counter_check), 			// output  counter_check_sig			delete
	.count_ended_check(count_ended_check) 	// output  count_ended_check_sig   delete
);



endmodule