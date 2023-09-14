`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 01:01:34
// Design Name: 
// Module Name: ERROR_DETECTION
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


module ERROR_DETECTION#(
    parameter N = 11,
    parameter M = 5
)(
    input Clk,
    input reset,
    input [N+M-2:0] encoded_data, 
    input [M-1:0] polynomial,
    
    output reg [N-1:0] final_data,
    output reg error_check
    );
reg [N+M-2:0] dividend;
reg [M-2:0] remainder;
reg [$clog2(N+M):0] shift_count= 0;

always @ (posedge Clk or posedge reset) begin
    if (reset) begin
        shift_count <= 0;
        remainder <= 0;
        
    end
    else if(encoded_data!= 0) begin
        if (shift_count == N+1) begin
            remainder = dividend[N+M-2:N];
            final_data <= encoded_data[N+M-2:M-1];
            if (remainder == 0) 
                error_check <= 0;
            else 
                error_check <= 1;
        end
        else if (shift_count == 0) begin
            dividend = encoded_data;
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
