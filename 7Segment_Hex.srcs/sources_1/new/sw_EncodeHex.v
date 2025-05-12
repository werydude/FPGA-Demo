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
    input [3:0] sw,
    output reg [6:0] segPattern
);   
    always @ (*) begin
        case (sw)
            4'h00:      segPattern <= ~7'b0111111;
            4'h01:      segPattern <= ~7'b0000110;
            4'h02:      segPattern <= ~7'b1011011;
            4'h03:      segPattern <= ~7'b1001111;
            4'h04:      segPattern <= ~7'b1100110;
            4'h05:      segPattern <= ~7'b1101101;
            4'h06:      segPattern <= ~7'b1111101;
            4'h07:      segPattern <= ~7'b0000111;
            4'h08:      segPattern <= ~7'b1111111;
            4'h09:      segPattern <= ~7'b1100111;
            4'h0A:      segPattern <= ~7'b1110111;
            4'h0B:      segPattern <= ~7'b1111100;
            4'h0C:      segPattern <= ~7'b0111001;
            4'h0D:      segPattern <= ~7'b1011110;
            4'h0E:      segPattern <= ~7'b1111001;
            4'h0F:      segPattern <= ~7'b1110001;
            default:    segPattern <= ~7'b1001001; // Three bars mean error
        endcase
    end
endmodule
