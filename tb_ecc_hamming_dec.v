`timescale 1ns/1ps
module tb_ecc_hamming_dec #(
parameter DATA_WIDTH 	= 32	,	// the data width
parameter PARITY_LENGTH = 6			// the length of parity bit , which equals to 6 for 32bits data
)(
//input [Req_Width-1:0] req,
//input clk,
//input rst,
//output reg [Req_Width-1:0] gnt
);
parameter PERIOD            = 10            ;
reg clk = 0;
reg rst_n = 0;
reg [DATA_WIDTH-1:0] d_in = 0;			// input data
reg [PARITY_LENGTH-1:0] parity_in = 0;  // input parity
wire [DATA_WIDTH-1:0] d_out_correct; 			// output data
wire [PARITY_LENGTH-1:0] parity_imm; 		// output parity code
wire odd_even_imm;
wire [2:0] label_out; 		// output codeword
reg odd_even_parity = 0 ;
ecc_hamming_decoder 
#(
        .DATA_WIDTH            	(DATA_WIDTH		),
        .PARITY_LENGTH			(PARITY_LENGTH	)

) 
u_ecc_hamming_decoder (
.clk(clk),
.rst_n(rst_n),
.d_in(d_in),
.parity_in(parity_in),
.odd_even_parity(odd_even_parity),
.d_out_correct(d_out_correct),
.label_out(label_out),
.odd_even_imm(odd_even_imm),
.parity_imm(parity_imm)
);

initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
initial
    begin
        $display("\nstatus: %t Testbench started\n\n", $time);
        #(PERIOD*10) rst_n  =  1;odd_even_parity = 1'b1;
        $display("status: %t done reset", $time);
        repeat(5) @(posedge clk);
		d_in = {{4'b1101},{28{1'b0}}}; parity_in = 6'b000100; odd_even_parity = 1'b1;
		@(posedge clk);
		d_in = {{6'b111101},{26{1'b0}}}; parity_in = 6'b000100; odd_even_parity = 1'b1;
		@(posedge clk);
		d_in = {{4{1'b1}},{28{1'b0}}}; parity_in = 6'b001100; odd_even_parity = 1'b1;
		@(posedge clk);
		d_in = {{4{1'b1}},{28{1'b0}}}; parity_in = 6'b000100; odd_even_parity = 1'b0;
		@(posedge clk);
		d_in = {{4{1'b1}},{28{1'b0}}}; parity_in = 6'b000100; odd_even_parity = 1'b1;
		//read_not_popup_and_write_repeat_fifo();
        //read_after_write(50);
        //repeat(5) @(posedge clk);
        //read_all_after_write_all();
        //repeat(5) @(posedge clk);
		//read_and_write_simultaneously();
		//repeat(5) @(posedge clk);
		//initialization();
		//#(PERIOD*10) rst_n  =  1;
		//repeat(5) @(posedge clk);
		
        $finish;
    end
endmodule
