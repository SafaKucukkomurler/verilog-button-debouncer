`timescale 1ns / 1ps

module tb_debouncer;

	reg clk;
	reg signal_i;
	wire signal_o;
	
	localparam clock_freq = 100_000_000,
			   clock_period = 10, //ns
			   debounce_time = 1000,	
		       initial_value = 1'b0;
	
	initial begin	
		clk = 1'b0;    	
	end
	
	always begin 
		clk <= ~clk; 
		#(clock_period / 2); 
	end
	
	debouncer #(.clock_freq(clock_freq), .debounce_time(debounce_time), .initial_value(initial_value)) uut(.clk(clk), .signal_i(signal_i), .signal_o(signal_o));
	
	always begin
	
		signal_i = 0;
		# (2*(10**6));    // 2ms
		
		signal_i = 1;
		# (100*(10**3));  // 100us
		signal_i = 0;
		# (200*(10**3));  // 200us
		signal_i = 1;
		# (100*(10**3));  // 100us
		signal_i = 0;
		# (100*(10**3));  // 100us
		signal_i = 1;
		# (800*(10**3));  // 800us
		signal_i = 0;
		# (50*(10**3));   // 50us
		signal_i = 1;
		# (3*(10**6));    // 3ms
		
		signal_i = 0;
		# (100*(10**3));  // 100us
		signal_i = 1;
		# (200*(10**3));  // 200us
		signal_i = 0;
		# (950*(10**3));  // 950us
		signal_i = 1;
		# (150*(10**3));  // 150us
		signal_i = 0;
		# (2*(10**6));    // 2ms
		
		$display("Simulasyon Tamamlandi");
		$finish;

	end
	
	

endmodule