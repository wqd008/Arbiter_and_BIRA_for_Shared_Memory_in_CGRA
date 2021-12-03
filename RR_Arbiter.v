`timescale 1ns/1ps
// two paralleled fixed-priority arbiter using mask algorithm
module RR_Arbiter #(
parameter Req_Width = 5
)(
input clk,
input rst,
input [Req_Width-1:0] req,
output [Req_Width-1:0] gnt,
output reg [Req_Width-1:0] Pointer_Req_test, // for test
output reg [Req_Width-1:0] q_test,
output [Req_Width-1:0] req_mask,
output [Req_Width-1:0] priority_mask,
output [Req_Width-1:0] priority_unmask,
output [Req_Width-1:0] grant_unmask,
output [Req_Width-1:0] grant_mask,
output label_req_mask,
output reg [2:0] label_req
);
reg [Req_Width-1:0] Pointer_Req;//denote the next priority
//wire [Req_Width-1:0] req_mask;
//wire [Req_Width-1:0] priority_mask;
//wire [Req_Width-1:0] grant_mask;
//wire [Req_Width-1:0] priority_unmask;
//wire [Req_Width-1:0] grant_unmask;
wire no_req_mask_label;
//the first FP arbiter with masking
assign req_mask = req & Pointer_Req;
assign priority_mask[0] = 1'b0;
assign priority_mask[Req_Width-1:1] = req_mask[Req_Width-2:0] | priority_mask[Req_Width-2:0];//or operation for each bit, from small to big bit
assign grant_mask[Req_Width-1:0] = req_mask[Req_Width-1:0] & (~priority_mask[Req_Width-1:0]);

//the second FP arbiter without masking
assign priority_unmask[0] = 1'b0;
assign priority_unmask[Req_Width-1:1] = req[Req_Width-2:0] | priority_unmask[Req_Width-2:0];//?????????
assign grant_unmask[Req_Width-1:0] = req[Req_Width-1:0] & (~priority_unmask[Req_Width-1:0]);

//Based on the value of req_mask, choose mask or unmask. (if req_mask is none, it means two conditions
//1: no req; 2: req is in the unmask part.
assign no_req_mask_label = ~(|req_mask);
assign gnt = ({Req_Width{no_req_mask_label}} & grant_unmask) | grant_mask;

//test
assign label_req_mask = |req_mask;
//assign label_req = |req;
//reg [Req_Width-1:0] q;
//Update the Pointer_Reg

always @ (posedge clk) begin
	#1
	if (rst) begin
		q_test <= {Req_Width{1'b1}};// initialize
		//q_test <= q;
		//Pointer_Req <= q_test;
		//Pointer_Req_test <= q_test;
		label_req <= 1;
		//Pointer_Req_test <= {Req_Width{1'b1}};
	end
	else begin
		if (label_req_mask) begin // still have req after mask
			q_test <= priority_mask;
			//Pointer_Req <= q_test;
			//Pointer_Req_test <= q_test;
			label_req <= 2;
			//Pointer_Req_test <= priority_mask;
		end
		else begin // no req after mask, so choose the req with no mask
			if (|req) begin //req with no mask have req
				q_test <= priority_unmask;
				//Pointer_Req <= q_test;// delay one clock, otherwise the result will be wrong, since the comb circuit will immediately use the pointer-reg
				//Pointer_Req_test <= q_test;
				label_req <= 3;
				//Pointer_Req_test <= priority_unmask;
			end
			else begin //req with no mask is none, so remain, don't change
				q_test <= Pointer_Req;
				//Pointer_Req <= q_test;
				//Pointer_Req_test <= q_test;
				label_req <= 4;
				//Pointer_Req_test <= Pointer_Req;
			end
		end
	end
	
end

always @ (posedge clk) begin
	Pointer_Req <= q_test;
	Pointer_Req_test <= q_test;
end
endmodule