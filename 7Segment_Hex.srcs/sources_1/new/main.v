`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo
// 
// Create Date: 05/11/2025 07:45:20 PM
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
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
    input [3:0] sw,
    input btnC,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    output wire [6:0] seg,
    output wire [15:0] led,
    output wire [3:0] an,
    output wire dp
);
    
    wire en;
    wire [1:0] an_sel;
    wire [4*7-1:0] segData;
    wire [4*4-1:0] hexDataWire;
    
    reg btnU_dbnc; 
    reg btnD_dbnc;
    
    assign led[3:0]     = sw;                           // Switches state
    assign led[7:4]     = hexDataWire[(an_sel*4)+:4];   // Data state of selected digit
    assign led[15:9]    = ~segData[(an_sel*7)+:7];      // Segment state of selected digit
    
    assign en = btnU || btnD || btnC;
    
    btn_inc btn_inc(clk, btnC, btnU, btnD, an_sel, sw, hexDataWire);
    sw_EncodeHex sw_encode0(clk, hexDataWire[0+:4], segData[0+:7]);
    sw_EncodeHex sw_encode1(clk, hexDataWire[4+:4], segData[7+:7]);
    sw_EncodeHex sw_encode2(clk, hexDataWire[8+:4], segData[14+:7]);
    sw_EncodeHex sw_encode3(clk, hexDataWire[12+:4], segData[21+:7]);
    SevenSegment_Hex seg_hex(clk, en, an_sel, segData, seg, an, dp);
    Btn_MoveSelect mv_sel(clk, btnL, btnR, an_sel);
    
endmodule
