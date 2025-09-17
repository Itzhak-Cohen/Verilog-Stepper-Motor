module speed_sm(
    input speed_sel,
    input resetb,
    output reg [2:0] curr_speed
);

    parameter state10 = 3'b001,
              state20 = 3'b010,
              state30 = 3'b011,
              state40 = 3'b100,
              state50 = 3'b101,
              state60 = 3'b110;

    reg [2:0] cs, ns;
    reg back_or_forth; // forth = 0

    always @(negedge speed_sel or negedge resetb) begin
        if (~resetb) begin
            cs <= state10;
            back_or_forth <= 1'b0;
        end else begin
            cs <= ns;
            // Update back_or_forth based on the state transitions
            if (cs == state50 && back_or_forth == 1'b0) begin
                back_or_forth <= 1'b1;
            end else if (cs == state20 && back_or_forth == 1'b1) begin
                back_or_forth <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        ns = cs; // Default assignment to avoid latches
        case(cs)
            state10: ns = state20;
            state20: ns = (back_or_forth == 1'b0) ? state30 : state10;
            state30: ns = (back_or_forth == 1'b0) ? state40 : state20;
            state40: ns = (back_or_forth == 1'b0) ? state50 : state30;
            state50: ns = (back_or_forth == 1'b0) ? state60 : state40;
            state60: ns = state50;
            default: ns = state10;
        endcase
    end

    // Set output
    always @(cs) begin
        curr_speed <= cs;
    end

endmodule
