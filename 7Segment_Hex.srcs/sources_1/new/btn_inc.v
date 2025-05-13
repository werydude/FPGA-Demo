`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2025 11:49:23 AM
// Design Name: 
// Module Name: btn_inc
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


module btn_inc(
    input btnU,
    input btnD,
    input [3:0] hexDataIn,
    output reg [3:0] hexDataOut
);
    always @ (hexDataIn) hexDataOut <= hexDataIn;
    always @ (btnU or btnD) begin
        hexDataOut <= hexDataOut + btnU - btnD;
    end
endmodule
