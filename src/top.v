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

    wire [7:0] a,b,c;
    wire sat;

    assign uo_out = a+(b^{8{sat}})+c;

    // Dummy implementation for now, just to make it synth:
    reciprocal reciprocal(
        .i_data({ui_in,uio_in,clk,ui_in[7:1]}),
        .i_abs(1'b1),
        .o_data({a,b,c}),
        .o_sat(sat)
    );

endmodule
