`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:27:16 04/14/2015 
// Design Name: 
// Module Name:    resgister_fil 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module resgister_fil #(parameter largo = 24)(
	input wire clk,
	input wire rst,
	input wire [largo:0] data_i,
	output wire [largo:0] data_o
    );
	
reg [largo:0]data;
	
always @(posedge clk, posedge rst)
	if (rst)
		data = 0;
	else if (clk == 1)	
		data = data_i;

assign data_o = data;		
endmodule
