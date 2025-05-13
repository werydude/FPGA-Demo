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

`define DISP_SEG_DEFAULT ~7'b1001001


module main(
    input clk,
    input [3:0] sw,
    input btnC,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    output wire [6:0] seg,
    output wire [3:0] led,
    output wire [3:0] an,
    output wire dp
);
    
    wire en;
    wire [1:0] an_sel;
    wire [6:0] segData;
    reg [3:0] hexData = 'bz;
    
    reg btnU_dbnc; 
    reg btnD_dbnc;
    
    assign led = sw;

    assign en = btnU || btnD || btnC;
    always @ (posedge clk) begin
        if ((hexData !== 'bz) || btnC) begin
            hexData = sw;
        end else hexData <= hexData + (btnU && !btnU_dbnc) - (btnD && !btnD_dbnc);
        btnU_dbnc <= btnU;
        btnD_dbnc <= btnD;
    end
    
    // btn_inc btn_inc(btnU, btnD, hexData, hexDataWire);
    sw_EncodeHex sw_encode(clk, hexData, segData);
    SevenSegment_Hex seg_hex(clk, en, an_sel, segData, seg, an, dp);
    Btn_MoveSelect mv_sel(clk, btnL, btnR, an_sel);
    
endmodule
