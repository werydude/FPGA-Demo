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

module main(
    input clk,
    input [3:0] sw,
    input btnC,
    input btnL,
    input btnR,
    output wire [6:0] seg,
    output [3:0] led,
    output wire [3:0] an,
    output wire dp
);
    
    wire [1:0] an_sel;
    wire [6:0] segData;
    assign led = sw;
    
    sw_EncodeHex sw_encode(sw, segData);
    SevenSegment_Hex seg_hex(clk, btnC, an_sel, segData, seg, an, dp);
    Btn_MoveSelect mv_sel(clk, btnL, btnR, an_sel);
    
endmodule
