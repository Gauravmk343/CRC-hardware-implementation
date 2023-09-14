`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 01:45:36
// Design Name: 
// Module Name: CRC_top
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


module CRC_top#(
    parameter N = 11,
    parameter M = 5
)(
    input Clk, 
    input reset, 
    input [N-1:0] data_in,
    input [M-1:0] polynomial, 
    input error_enable,
    
    output  [N-1:0] data_out,
    output   error_check
    );
    
wire [N+M-2:0] divider_to_error_gen__encoded_data;

wire [N+M-2:0] error_gen_to_error_det__error_data;

DIVIDER divider (
    .Clk(Clk),
    .reset(reset),
    .Data_in(data_in),
    .polynomial(polynomial),
    .crc_encoded_data(divider_to_error_gen__encoded_data)
);

ERROR_DETECTION error_detection (
    .Clk(Clk),
    .reset(reset),
    .encoded_data(error_gen_to_error_det__error_data), 
    .polynomial(polynomial),
    .final_data(data_out),
    .error_check(error_check)
);

Error_generator error_gen (
    .data_in(divider_to_error_gen__encoded_data),
    .enable_error(error_enable),
    .error_data(error_gen_to_error_det__error_data)
);
endmodule
