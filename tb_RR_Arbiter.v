`timescale 1ns/1ps
module tb_RR_Arbiter #(
parameter Req_Width = 10
)(
//input [Req_Width-1:0] req,
//input clk,
//input rst,
//output reg [Req_Width-1:0] gnt
);

reg [Req_Width-1:0] req;
wire [Req_Width-1:0] gnt;
reg clk;
reg rst;
wire [Req_Width-1:0] Pointer_Req_test;
wire [Req_Width-1:0] q_test;
wire [Req_Width-1:0] req_mask;
wire [Req_Width-1:0] priority_mask;
wire [Req_Width-1:0] priority_unmask;
wire [Req_Width-1:0] grant_mask;
wire [Req_Width-1:0] grant_unmask;
wire label_req_mask;
wire [2:0] label_req;
RR_Arbiter #(Req_Width) RRA1 (
.clk(clk),
.rst(rst),
.req(req),
.gnt(gnt),
.Pointer_Req_test(Pointer_Req_test),
.q_test(q_test),
.req_mask(req_mask),
.priority_mask(priority_mask),
.priority_unmask(priority_unmask),
.grant_mask(grant_mask),
.grant_unmask(grant_unmask),
.label_req_mask(label_req_mask),
.label_req(label_req)
);

parameter ClockPeriod = 10  ;
 
initial
	begin
		clk = 1 ;
    	repeat(40)
    		#(ClockPeriod) clk = ~clk;
	end

initial 
	begin
		rst = 1;
		req = {Req_Width{1'b0}};
		#40 rst = 0; req = 10'b0000000000;//0
		#20 req = 10'b0000001101;//2
		#20 req = 10'b0000001110;//cha dui
		#20 req = 10'b0001101101;//4
		#20 req = 10'b0011101001;
		#20 req = 10'b0011100101;
		#20 req = 10'b0011000110;
		#20 req = 10'b0010000111;//again
		#20 req = 10'b0000000111;
		#20 req = 10'b1000000110;
		#20 req = 10'b1000000110;
		#20 req = 10'b1000000011;
		$finish;
	end


endmodule


