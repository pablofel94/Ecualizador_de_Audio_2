`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:30 04/12/2015 
// Design Name: 
// Module Name:    unidad_aritmetica 
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
module unidad_aritmetica#(parameter largo=24)(a,b,func,y_sal,overflow_o);
input signed [largo:0] a, b;
input signed [1:0] func;
output wire signed [largo:0] y_sal;
output wire signed overflow_o;

localparam 
suma = 2'h1,
multiplicacion = 2'h2;

reg [largo:0] maxpon,minpon;
reg [(2*largo+1):0] y1;
reg [largo:0] y;
reg overflow;

always@* 
	begin
		maxpon = (2**(largo)-1);
		minpon = -(2**(largo));
	end

always@*
begin
	overflow = 1'b0;
	case (func)
		suma:
		begin //suma
		y = a + b;
		if(a[largo]==1 && b[largo]==1 && y[largo]==0)
				begin
				y = minpon;
				overflow = 1'b1;
				end
		else 
			begin
				if(a[largo]==0 && b[largo]==0  && y[largo]==1)
					begin
					y = maxpon;
					overflow = 1'b1;
					end
				else 
					begin
					overflow = 1'b0;
					end
			end
		end
			
		multiplicacion: 
		begin //multiplicacion
			y1 = a * b;
			y = y1[40:16];
			if(a[largo]==1 && b[largo]==1 && y1[largo]==0)
				begin
				y = minpon;
				overflow = 1'b1;
				end
			else 
				begin
				if(a[largo]==1 && b[largo]==0  && y1[largo]==0)
					begin
					y = minpon;
					overflow = 1'b1;
					end
				else 
					begin
					if(a[largo]==0 && b[largo]==1  && y1[largo]==0)
						begin
						y = minpon;
						overflow = 1'b1;
						end
					else 
						begin
						if(a[largo]==0 && b[largo]==0  && y1[largo]==1)
							begin
							y = maxpon;
							overflow = 1'b1;
							end
						else
							begin
							overflow = 1'b0;
							end
						end
					end
				end
		end
		default: y = 25'sb1111_1111_1111_1111_1111_1111_1;
		endcase
end

assign overflow_o = overflow; 
assign y_sal = y;

endmodule
