`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo
// 
// Create Date: 05/11/2025 07:34:03 PM
// Design Name: 
// Module Name: sw_EncodeHex
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



module sw_EncodeHex(
    input clk,
    input [3:0] hexData,
    output [6:0] segPattern
);   
    function [6:0] pattern (input [3:0] hex);
        case (hex)
            4'h00:      pattern = ~7'b0111111; // 
            4'h01:      pattern = ~7'b0000110;
            4'h02:      pattern = ~7'b1011011;
            4'h03:      pattern = ~7'b1001111;
            4'h04:      pattern = ~7'b1100110;
            4'h05:      pattern = ~7'b1101101;
            4'h06:      pattern = ~7'b1111101;
            4'h07:      pattern = ~7'b0000111;
            4'h08:      pattern = ~7'b1111111;
            4'h09:      pattern = ~7'b1100111;
            4'h0A:      pattern = ~7'b1110111;
            4'h0B:      pattern = ~7'b1111100;
            4'h0C:      pattern = ~7'b0111001;
            4'h0D:      pattern = ~7'b1011110;
            4'h0E:      pattern = ~7'b1111001;
            4'h0F:      pattern = ~7'b1110001;
            default:    pattern = ~7'b1001001; // Three bars mean error
        endcase
    endfunction
    
    assign segPattern = pattern(hexData);
    
endmodule
