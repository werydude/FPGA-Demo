`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo 
// 
// Create Date: 05/11/2025 07:45:20 PM
// Design Name: 
// Module Name: main
// Project Name: FPGA-Demo
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

`include "sw_EncodeHex.v"
`include "Btn_MoveSelect.v"
`include "SevenSegment_Hex.v"
`include "btn_inc.v"

module main(
    input clk,
    input [3:0] sw,             // Right 4 switches on Basys 3

    // Buttons
    input btnC,                
    input btnL,                 
    input btnR,
    input btnU,
    input btnD,


    output wire [15:0] led,     // All 16 Leds on the Basys 3
    output wire [6:0] seg,      // Segment data to push to 7-segment display
    output wire [3:0] an,       // Annode; selected display segment
    output wire dp              // Decimal point: displays chosen segment; blinks on interaction.
);
    
    wire en;                    // Enable; push data to display
    wire [1:0] an_sel;          // Selected annode/segement
    wire [4*7-1:0] segData;     // 4x7 array of converted data for each segment.
    wire [4*4-1:0] hexDataWire; // 4x7 array of raw hex data behind each segement.
    
    // "Debounce" up and down switches;
    // More of a repition preventer.
    reg btnU_dbnc; 
    reg btnD_dbnc;
    
    assign led[3:0]     = sw;                           // Switches state
    assign led[7:4]     = hexDataWire[(an_sel*4)+:4];   // Data state of selected digit
    assign led[15:9]    = ~segData[(an_sel*7)+:7];      // Segment state of selected digit
    
    assign en = btnU || btnD || btnC;                   // Enable when ever a button is pushed.     
    
    // Modules //
    btn_inc btn_inc(clk, btnC, btnU, btnD, an_sel, sw, hexDataWire);    // Manages internal hex state
    
    // Encodes hex data to segments
    sw_EncodeHex sw_encode0(clk, hexDataWire[0+:4], segData[0+:7]);     // Segment 0
    sw_EncodeHex sw_encode1(clk, hexDataWire[4+:4], segData[7+:7]);     // Segment 1
    sw_EncodeHex sw_encode2(clk, hexDataWire[8+:4], segData[14+:7]);    // Segment 2
    sw_EncodeHex sw_encode3(clk, hexDataWire[12+:4], segData[21+:7]);   // Segment 3
    
    SevenSegment_Hex seg_hex(clk, en, an_sel, segData, seg, an, dp);    // Drives display
    Btn_MoveSelect mv_sel(clk, btnL, btnR, an_sel);                     // Drives segement selector
    
endmodule
