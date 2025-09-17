module speed_decoder (
    input [2:0] digit,    // 3-bit input digit (1 to 6 states)
    output reg [6:0] tens, units  // 7-segment output (abcdefg)
);

    always @(*) begin
        units = 7'b1000000;  // Assign units inside the always block
        case (digit)
            3'd1: tens = 7'b1111001; // 1
            3'd2: tens = 7'b0100100; // 2
            3'd3: tens = 7'b0110000; // 3
            3'd4: tens = 7'b0011001; // 4
            3'd5: tens = 7'b0010010; // 5
            3'd6: tens = 7'b0000010; // 6
            default: tens = 7'b1111111; // Default to all segments off
        endcase
    end

endmodule
