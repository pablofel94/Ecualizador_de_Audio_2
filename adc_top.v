`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:26 04/09/2015 
// Design Name: 
// Module Name:    adc_top 
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
module adc_top(clk_i,rst_i,data_i,cs_sng,clk_o,garg,data_o);

	input wire clk_i;
	input wire rst_i;
	input wire data_i;
	output wire cs_sng;
	output wire clk_o; 
	output wire [3:0]garg;
	output wire [11:0]data_o;
	
wire clk_n;
	
CLK C (
    .clk_i(clk_i), 
    .rst_i(rst_i), 
    .clk_o(clk_n)
    );
adc_eq A (
    .clk_adc(clk_n), 
    .data_i(data_i),
    .cs_o(cs_sng), 
    .data_o(data_o), 
    .rst_adc(rst_i), 
    .garg(garg)
    );
	 
assign clk_o = clk_n;	
endmodule
