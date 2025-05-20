`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo
// 
// Create Date: 05/11/2025 07:34:03 PM
// Design Name: 
// Module Name: Btn_MoveSelect
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


module Btn_MoveSelect(
    input clk,
    input btnL,
    input btnR,
    output reg [1:0] sel
    );
    
    reg btnL_dbnc, btnR_dbnc;
    
    initial sel <= 0;
    
    // Move "cursor" //
    always @ (posedge clk) begin
        btnL_dbnc <= btnL;
        btnR_dbnc <= btnR;
        if ((btnL_dbnc != btnL) || (btnR_dbnc!= btnR)) begin
            case({btnL, btnR, sel})
                6'b01_00: sel <= 3;
                6'b01_01,
                6'b01_10,
                6'b01_11: sel <= sel-1;
                6'b10_11: sel <= 0;
                6'b10_10,
                6'b10_01,
                6'b10_00: sel <= sel+1;
                // No default; stay the same in the failed case.
            endcase
        end
    end

endmodule
