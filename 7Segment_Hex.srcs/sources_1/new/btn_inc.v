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
    input clk,
    input btnC,
    input btnU,
    input btnD,
    input [1:0] an_sel,
    input [3:0] sw,
    output [4*4-1:0] hexData
);
    reg init = 1'b1;
    reg sw_en = 1'b1;
    reg btnU_dbnc = 1'b0;
    reg btnD_dbnc = 1'b0;
    reg [4*4-1:0] hexDataBuffer;
    
    initial begin
        hexDataBuffer[0+:4] <= sw;
        hexDataBuffer[4+:4] <= sw;                          
        hexDataBuffer[8+:4] <= sw;
        hexDataBuffer[12+:4] <= sw;
    end
    
    assign hexData = hexDataBuffer;
    always @ (posedge clk) begin
        if (init) begin
            init <= 0;
        end else if (sw_en) begin
            hexDataBuffer[an_sel*4+:4] <= sw;
        end else
            hexDataBuffer[an_sel*4+:4] <= hexDataBuffer[an_sel*4+:4] + (btnU && !btnU_dbnc) - (btnD && !btnD_dbnc);
        
        btnU_dbnc <= btnU;
        btnD_dbnc <= btnD;
        sw_en <= btnC;
    end
endmodule
