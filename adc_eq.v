`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:51 04/08/2015 
// Design Name: 
// Module Name:    adc_eq 
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
module adc_eq(clk_adc,data_i,cs_o,data_o,rst_adc,garg);
	 
input wire clk_adc;
input wire rst_adc;
input wire  data_i;
output wire cs_o;
output wire [3:0] garg;
output wire [11:0] data_o;	 
	 
localparam
idle = 2'b00,
dps = 2'b01,
load = 2'b10;

reg [3:0] q_ac,q_next;
reg cs_ac,cs_next;
reg [1:0] estado_actl,estado_sgt;
reg [15:0] data_next,data_com;

always@ (posedge clk_adc, posedge rst_adc)
	if (rst_adc)
		begin
			estado_actl <= idle;
			q_ac <= 4'd0;
			cs_ac <= 1'b1;
			data_com <= 16'd0;
		end
	else
		begin
			estado_actl <= estado_sgt;
			q_ac <= q_next;
			cs_ac <= cs_next;
			data_com <= data_next;
		end
		
always @*
	begin
		estado_sgt = estado_actl;
		cs_next = cs_ac;
		q_next = q_ac;
		data_next = data_com;
		case (estado_actl)
			idle: 
				if (cs_next== 1'b1 )
					begin
						cs_next = 1'b0;
						estado_sgt = dps;
						data_next = {data_i,data_next [15:1]};
					end
			dps:
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
			load:
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
