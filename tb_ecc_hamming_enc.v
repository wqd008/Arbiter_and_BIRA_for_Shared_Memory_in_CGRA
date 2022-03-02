`timescale 1ns/1ps
module tb_ecc_hamming_enc #(
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
wire [DATA_WIDTH-1:0] d_out; 			// output data
wire [PARITY_LENGTH-1:0] parity_out; 		// output parity code
wire [DATA_WIDTH+PARITY_LENGTH-1:0] codeword_out; 		// output codeword
wire odd_even_parity;
ecc_hamming_encoder 
#(
        .DATA_WIDTH            	(DATA_WIDTH		),
        .PARITY_LENGTH			(PARITY_LENGTH	)

) 
u_ecc_hamming_encoder (
.clk(clk),
.rst_n(rst_n),
.d_in(d_in),
.d_out(d_out),
.parity_out(parity_out),
.codeword_out(codeword_out),
.odd_even_parity(odd_even_parity)
);

initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
initial
    begin
        $display("\nstatus: %t Testbench started\n\n", $time);
        #(PERIOD*10) rst_n  =  1;
        $display("status: %t done reset", $time);
        repeat(5) @(posedge clk);
		d_in = {{4{1'b1}},{28{1'b0}}};
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