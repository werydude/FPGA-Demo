`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo
// 
// Create Date: 05/08/2025 02:47:30 PM
// Design Name: 
// Module Name: SevenSegment_Hex
// Project Name: 
// Target Devices: Basys 3
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// NOTE: Annode are OFF when high

// We need a counter to keep each section of display on
// For an appropriate ammount of time.
// 1ms <= timer <= 16ms
//
// Size of counter = 2^k bits
// Min <= Bits * clock <= max
//
// 1ms <= 2^k * 100MHz <= 16ms
// 1ms <= 2^k * 10ns <= 16ms
// 1ms/10ns <= 2^k <= 16ms/10ns
// 10^5 <= 2^k <= 16*2^5
// 10^5 < 2^17 <= 2^k <= 2^20 < 16*10^5
//
// 17 <= k <= 20
// 
// Min and max values with these bits
// (65537 < 131_072) <= timer <= (524289 < 1_048_576)
// 
// So we *should* be able to get away with an even 16 bits (65536),
// But if things go weird, we'll increase.

`define DISP_COUNTER_BITS 16
`define DISP_SEGS 4   // Insert immature joke here.
`define DISP_COUNTER_SEG_BITS `DISP_COUNTER_BITS - $clog2(`DISP_SEGS)
`define DISP_SEG_DEFAULT ~7'b1001001

module SevenSegment_Hex(
    input clk,
    input en,
    input [1:0] an_sel,
    input [(`DISP_SEGS*7)-1:0] segState, // [3:0] segState [6:0]
    output reg [6:0] seg,
    output reg [`DISP_SEGS:0] an,
    output reg dp
);

    reg [1:0] an_curr = 0;
    reg init = 0; // We need to wait to populate segData correctly
    reg [`DISP_COUNTER_SEG_BITS-1:0] disp_counter = 1;
    reg disp_en;
    
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
        an <= ~(4'b0001 << an_curr);
        dp <= ~((an_curr == an_sel) && !en);
        seg <= segState[(an_curr*7)+:7];
    end
    

    
endmodule
