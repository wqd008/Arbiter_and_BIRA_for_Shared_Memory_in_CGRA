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
wire [Req_Width-1:0] nxt_gnt;
reg clk;
reg rst;
wire [Req_Width-1:0] Pointer_Req_test;
wire [Req_Width-1:0] q_test;
wire [Req_Width-1:0] req_mask;
wire [Req_Width-1:0] priority_mask;
wire [Req_Width-1:0] priority_unmask;
wire [Req_Width-1:0] grant_mask;
wire [Req_Width-1:0] grant_unmask;
//wire no_req_mask_label;
wire label_req_mask;
wire [2:0] label_req;
RR_Arbiter #(.Req_Width (Req_Width)
) RRA1 (
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
.label_req(label_req),
.nxt_gnt(nxt_gnt)
//.no_req_mask_label(no_req_mask_label)
);

parameter ClockPeriod = 10  ;
 
initial
	begin
		clk = 1 ;
    	repeat(80)
    		#(ClockPeriod) clk = ~clk;
	end

initial 
	begin
		rst = 0;
		req = {Req_Width{1'b0}};
		#210 rst = 1; req = 10'b0000000000;//0
		repeat(5) @(posedge clk);
//		#20 req = 10'b1010101111;
//		#20 req = 10'b1010101111;
//		#20 req = 10'b1010101111;
//		#20 req = 10'b1010101111;
//		#20 req = 10'b1010100000;
//		#20 req = 10'b1010100000;
		@(posedge clk); req = 10'b0000001111;//2
		@(posedge clk); req = 10'b1000001110;//cha dui
		@(posedge clk); req = 10'b1100001100;//4
		@(posedge clk); req = 10'b1110001000;
		@(posedge clk); req = 10'b1111000000;
		@(posedge clk); req = 10'b1110000000;
		@(posedge clk); req = 10'b1100000001;//again
		@(posedge clk); req = 10'b1000000011;
		@(posedge clk); req = 10'b0110001111;
		@(posedge clk); req = 10'b1110001110;
		@(posedge clk); req = 10'b1110001100;
		@(posedge clk); req = 10'b1110001000;
		@(posedge clk); req = 10'b1100000001;
		@(posedge clk); req = 10'b1000000001;
		@(posedge clk); req = 10'b0000100001;
		@(posedge clk); req = 10'b0110100100;
		@(posedge clk); req = 10'b0110100000;
		$finish;
	end


endmodule


