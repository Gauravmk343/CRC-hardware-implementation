`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 01:50:32
// Design Name: 
// Module Name: Error_generator
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


module Error_generator#(
    parameter N = 11,
    parameter M = 5
)(
    input [N+M-2:0] data_in,
    input enable_error,
    
    output reg [N+M-2:0] error_data
    );
    
always @ (data_in) begin
    if (enable_error) begin
        error_data[6:0] <= data_in[6:0];
        error_data[7] <= ~data_in[7];
        error_data[N+M-2:8] <= data_in[N+M-2:8];
    end
    else
        error_data <= data_in;
end
endmodule
