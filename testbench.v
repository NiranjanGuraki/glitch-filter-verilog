`timescale 1ns/1ps

module glitch_filter_tb;


    reg clk;
    reg reset_n;
    reg sensor_in;

    wire sensor_out;

    glitch_filter DUT (
        .clk        (clk),
        .reset_n    (reset_n),
        .sensor_in  (sensor_in),
        .sensor_out (sensor_out)
    );

    
    always #5 clk = ~clk;

   
    initial
    begin

        // Create VCD file for waveform
        $dumpfile("glitch_filter.vcd");
        $dumpvars(0, glitch_filter_tb);

        // Initial values
        clk       = 1'b0;
        reset_n   = 1'b0;
        sensor_in = 1'b0;

        #12;

        reset_n = 1'b1;

        #10;
        sensor_in = 1'b1;

        #30;

       
        sensor_in = 1'b0;

        #10;

        sensor_in = 1'b1;

        #20;

       
        sensor_in = 1'b0;

        #30;

        
        sensor_in = 1'b1;

        #10;

        sensor_in = 1'b0;

        #20;

        
        $finish;

    end
    // Display values during simulation
   
    initial
    begin
        $monitor("Time = %0t | reset_n = %b | sensor_in = %b | sensor_out = %b",
                 $time, reset_n, sensor_in, sensor_out);
    end

endmodule