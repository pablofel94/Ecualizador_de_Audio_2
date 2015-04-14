`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:45 04/13/2015 
// Design Name: 
// Module Name:    filter_1 
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
module filter_1#(parameter largo = 25) (
	input wire signed [largo-1:0] data_i,
	input wire signed [largo-1:0] data_reg1,
	input wire signed [largo-1:0] data_reg2,
	input wire clk,
	input wire rst,
	output wire [largo-1:0] dato_o,
	output wire [1:0] func
    );

localparam 
op1 = 2'h0;
save2 = 2'h1;
out = 2'h2;

reg [largo:0] data_reg1_ac,data_reg1_next;
reg [largo:0] data_reg2_ac,data_reg2_next;
reg [1:0] func_ac,func_next;
reg [1:0] estado_actl,estado_sgt;
reg [largo:0] op_ac,op_next;

always@ (posedge clk, posedge rst)
	if (rst)
		begin
			estado_actl <= op1;
			data_reg1_ac <= 25'd0;
			data_reg2_ac <= 25'd0;
			func_ac <= 2'b0;
			op_ac <= 25'd0;
		end
	else
		begin
			estado_actl <= estado_sgt;
			data_reg1_ac <= data_reg1_next;
			data_reg2_ac <= data_reg2_next;
			func_ac <= func_next;
			op_ac <= op_next;
		end
		
always @*
	begin
		estado_sgt = estado_actl;
		op_next = op_ac;
		data_reg1_next = data_reg1_ac;
		data_reg2_next = data_reg2_ac;
		func_next = func_ac;
		case (estado_actl)
			op1: 
				if (data_reg1_next == 25'd0 )
					begin
						func_next = 2'h1;
						estado_sgt = save2;
						data_reg1_next = data_i;
					end
			save2:
				begin
				if (q_next == 4'd15 )
					estado_sgt = load; 
				else
					begin
					data_next  = {data_i,data_next [15:1]};
					q_next = q_next + 1'b1;
					estado_sgt = dps;
					end
				end
			out:
				begin
					estado_sgt = idle;
					cs_next = 1'b1;
					q_next = 4'd0;
				end
		endcase
	end
assign data_o[11:0] = data_com[15:4];
assign garg [3:0]  = data_com[3:0];
assign cs_o = cs_ac;

endmodule
