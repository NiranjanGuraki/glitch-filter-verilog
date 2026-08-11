module glitch_filter (
    input  wire clk,
    input  wire reset_n,
    input  wire sensor_in,
    output reg  sensor_out
);

    
    reg previous_sensor;

    always @(posedge clk or negedge reset_n)
    begin

        // Active-low reset
        if (!reset_n)
        begin
            previous_sensor <= 1'b0;
            sensor_out      <= 1'b0;
        end

        else
        begin
           
            if (sensor_in == previous_sensor)
            begin
                
                sensor_out <= sensor_in;
            end
            previous_sensor <= sensor_in;
        end

    end

endmodule