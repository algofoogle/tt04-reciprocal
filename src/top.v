`default_nettype none
`timescale 1ns / 1ps

module tt_um_algofoogle_reciprocal(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    assign uio_oe = 8'b0000_0000;
    assign uio_out = 8'b0000_0000;

    reg [23:0] num_in;
    wire reset = ~rst_n;
    reg [2:0] state;
    reg [7:0] part_out;
    assign uo_out = part_out;

    always @(posedge clk) begin
        if (reset) begin
            num_in <= 0;
            part_out <= 0;
            state <= 0;
        end else begin
            state <= state + 1;
            case (state)
                0, 1, 2: num_in <= {num_in[15:0],ui_in};
                3: part_out <= a;
                4: part_out <= b;
                5: part_out <= c;
                // default: // Do nothing.
            endcase
        end
    end

    wire [7:0] a,b,c;
    wire sat;

    // Dummy implementation for now, just to make it synth:
    reciprocal reciprocal(
        .i_data(num_in),
        .i_abs(1'b1),
        .o_data({a,b,c}),
        .o_sat(sat)
    );

endmodule
