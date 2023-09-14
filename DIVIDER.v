`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2023 11:31:33
// Design Name: 
// Module Name: DIVIDER
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


module DIVIDER #(
    parameter N = 11, 
    parameter M = 5
)(
    input Clk, 
    input reset,
    input [N-1:0] Data_in, 
    input [M-1:0] polynomial, 
    output reg [N+M-2:0] crc_encoded_data
    );
reg [N+M-2:0] dividend;
reg [M-2:0] remainder = 0;
reg [$clog2(N+M):0] shift_count= 0;


always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        shift_count <= 0;
        remainder <= 0;
        
    end
    else begin
        if (shift_count == N+1) begin
            remainder = dividend[N+M-2:N];
            crc_encoded_data <= {Data_in, remainder};
        end
        else if (shift_count == 0) begin
            dividend = {Data_in, remainder[M-2:0]};
            dividend[N+M-2:N-1] <= dividend[N+M-2:N-1]^polynomial;
            shift_count = shift_count + 1;
        end
        else begin
            if (dividend[N+M-2] == 1) begin
                dividend[N+M-2:N-1] <= dividend[N+M-2:N-1]^polynomial;
            end
            else begin
                dividend <= dividend << 1'b1;
                shift_count <= shift_count + 1;
            end
        end
    end
end
endmodule
