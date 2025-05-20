`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo 
// 
// Create Date: 05/08/2025 02:47:30 PM
// Design Name: 7-Segment Display Driver
// Module Name: SevenSegment_Hex
// Project Name: FPGA-Demo
// Target Devices: Basys 3
// Description: 
// 
// Additional Comments:
//      NOTE: Annodes are OFF when high
//
//      We need a counter to keep each section of display on
//      For an appropriate ammount of time.
//      1ms <= timer <= 16ms
//
//      Size of counter = 2^k bits
//      Min <= Bits * clock <= max
//
//      1ms <= 2^k * 100MHz <= 16ms
//      1ms <= 2^k * 10ns <= 16ms
//      1ms/10ns <= 2^k <= 16ms/10ns
//      10^5 <= 2^k <= 16*2^5
//      10^5 < 2^17 <= 2^k <= 2^20 < 16*10^5
//
//      17 <= k <= 20
// 
//      Min and max values with these bits
//      (65537 < 131_072) <= timer <= (524289 < 1_048_576)
// 
//      So we *should* be able to get away with an even 16 bits (65536),
//      But if things go weird, we'll increase.
//////////////////////////////////////////////////////////////////////////////////

`define DISP_COUNTER_BITS 16
`define DISP_SEGS 4   // Insert immature joke here.

// Since 4 display segments, each gets 1/4 of the total bits-time, or -2 bits;
`define DISP_COUNTER_SEG_BITS `DISP_COUNTER_BITS - $clog2(`DISP_SEGS)

module SevenSegment_Hex(
    input clk,                              
    input en,                               // Commits data to display 
    input [1:0] an_sel,                     // Annode Select: chooses which segment to display.
    input [(`DISP_SEGS*7)-1:0] segState,    // 4x7 Array of data for each segment
    output reg [6:0] seg,                   // Segement Data output
    output reg [`DISP_SEGS:0] an,           // Annode choice
    output reg dp                           // Decimal point: displays chosen segment; blinks on interaction.
);

    reg [1:0] an_curr = 0;                  // Current annode
    reg disp_en;                            // Enable when counter is complete

    // Counter for matching display refresh timing
    // Starts at 1 so we don't trigger right away
    reg [`DISP_COUNTER_SEG_BITS-1:0] disp_counter = 1
    
    // Refresh Display //
    always @ (posedge clk) begin
        disp_en <= 1'b0;
        disp_counter <= (disp_counter + 1'd1);
        
        // When counter overflows, select next
        // display segment.
        if (!disp_counter) begin
            disp_en <= 1'b1;
        end
        if (disp_en) begin
            an_curr <= an_curr + 1;
        end
    end
    
    // Write Data to display //
    always @ (posedge clk) begin
        // Negation bc annodes are OFF when high
        an <= ~(4'b0001 << an_curr);            // Enable annode in HW
        dp <= ~((an_curr == an_sel) && !en);    // Show selected segement with dec. point. Unless button press, then disable.
        seg <= segState[(an_curr*7)+:7];        // Push current segment's data to HW
    end
    

    
endmodule
