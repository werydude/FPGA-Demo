`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Computer and Engineering Research @ WVC, directed by Takyiu Liu
// Engineer: Tahv Demayo
// 
// Create Date: 05/12/2025 11:49:23 AM
// Design Name: Data State Manager
// Module Name: btn_inc
// Project Name: FPGA-Demo
// Target Devices: Basys 3
// Description: Controls the internal hex data for each display segement
//////////////////////////////////////////////////////////////////////////////////


module btn_inc(
    input clk,
    input btnC,
    input btnU,
    input btnD,
    input [1:0] an_sel,             // Selected annode/segment
    input [3:0] sw,                 // Swiches 0-3 (right most 4)
    output [4*4-1:0] hexData        // 4x4 array of hex data.
);
    reg init = 1'b1;                // 1 Cycle delay to ensure correct input data
    reg sw_en = 1'b1;               // Switch Enable; Overwrites current data with current switch value 
    
    // "Debounce" up and down switches;
    // More of a repition preventer.
    reg btnU_dbnc = 1'b0;
    reg btnD_dbnc = 1'b0;
    
    reg [4*4-1:0] hexDataBuffer;    // Internal buffer
    

    // Attempt* to push initial switch data to buffer,
    // so that displays start with switch data.
    // *NOTE: THIS IS CURRENTLY BROKEN //
    initial begin
        hexDataBuffer[0+:4] <= sw; 
        hexDataBuffer[4+:4] <= sw;                          
        hexDataBuffer[8+:4] <= sw;
        hexDataBuffer[12+:4] <= sw;
    end
    
    assign hexData = hexDataBuffer; // Connect internal buffer to output AFTER initial setting.*
    always @ (posedge clk) begin
        if (init) begin // Initial Data
            init <= 0;
        end else if (sw_en) begin // Switch overwrite
            hexDataBuffer[an_sel*4+:4] <= sw;
        end else // Increment/decrement internal state with (dedupped) buttons.
            hexDataBuffer[an_sel*4+:4] <= hexDataBuffer[an_sel*4+:4] + (btnU && !btnU_dbnc) - (btnD && !btnD_dbnc);
        
        // Update state
        btnU_dbnc <= btnU;
        btnD_dbnc <= btnD;
        sw_en <= btnC;
    end
endmodule
