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
`define DISP_COUNTERS_SEG_BITS `DISP_COUNTER_BITS - 2

module SevenSegment_Hex(
    input clk,
    input btnC,
    input [1:0] an_sel,
    input [6:0] segData,
    output reg [6:0] seg,
    output reg [3:0] an,
    output reg dp
    );

    reg [1:0] an_curr = 0;
    reg [`DISP_COUNTERS_SEG_BITS-1:0] disp_counter = 0;
    reg disp_en;
    
    reg [6:0] segState [0:3];
    
    // Refresh Display //
    always @ (posedge clk) begin
        disp_en <= 1'b0;
        disp_counter <= (disp_counter + 1'd1);
        
        // When counter overflows, select next
        // display segment.
        if (!disp_counter) disp_en <= 1'b1;
        if (disp_en) an_curr <= an_curr + 1;
    end
    
    // Select data //
    always @ (btnC) begin
        if (an_curr == an_sel && btnC) segState[an_curr] <= segData;
    end
    
    // Write Data to display //
    always @ (posedge clk) begin
        an <= ~(4'b0001 << an_curr);
        dp <= ~((an_curr == an_sel) && ~btnC);
        seg <= segState[an_curr];
    end
    

    
endmodule
