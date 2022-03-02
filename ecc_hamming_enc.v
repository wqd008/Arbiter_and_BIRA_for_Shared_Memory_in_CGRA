`timescale 1ns/1ps
// hamming encoder for 32bit data ECC
// an ECC with an ability to detect 2bits mistakes and correct 1bit mistake
module ecc_hamming_encoder #(
parameter DATA_WIDTH 	= 32	,	// the data width
parameter PARITY_LENGTH = 6			// the length of parity bit , which equals to 6 for 32bits data
)(
input clk,
input rst_n,
input [DATA_WIDTH-1:0] d_in,				// input data
output reg [DATA_WIDTH-1:0] d_out, 			// output data
output reg [PARITY_LENGTH-1:0] parity_out, 	// output parity code
output reg odd_even_parity,					// output odd even parity code for testing two bits mistakes (without this code, hamming could only test one bit mistake)
output [DATA_WIDTH+PARITY_LENGTH-1:0] codeword_out 		// output codeword
);

//--------------------------------------------------------------------------
// There are four situations:
// 1. parity = 0; odd_even_parity = 0; no mistake
// 2. parity ? 0; odd_even_parity = 1; one mistake
// 3. parity ? 0; odd_even_parity = 0; two mistakes but can't be corrected
// 4. parity = 0; odd_even_parity = 1; One mistakes on odd_even_parity
// Thus the hamming code can detect 2 bit mistakes and correct 1 bit mistake.
//--------------------------------------------------------------------------

always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n) begin
		d_out 			<= 		0;
		parity_out 		<= 		0;
		odd_even_parity	<=		0;
		//codeword_out 	<= 		0;

	end
	else begin // even parity
		d_out			<=		d_in;
		odd_even_parity	<=		^ codeword_out;
		parity_out[0]	<=		d_in[0] ^ d_in[1] ^ d_in[3] ^ d_in[4] ^ d_in[6] ^ d_in[8] ^ d_in[10] ^ d_in[11] ^ d_in[13] ^ d_in[15] ^ d_in[17] ^ d_in[19] ^ d_in[21] ^ d_in[23] ^ d_in[25] ^ d_in[26] ^ d_in[28] ^ d_in[30];
		parity_out[1]	<=		d_in[0] ^ d_in[2] ^ d_in[3] ^ d_in[5] ^ d_in[6] ^ d_in[9] ^ d_in[10] ^ d_in[12] ^ d_in[13] ^ d_in[16] ^ d_in[17] ^ d_in[20] ^ d_in[21] ^ d_in[24] ^ d_in[25] ^ d_in[27] ^ d_in[28] ^ d_in[31];
		parity_out[2]	<=		d_in[1] ^ d_in[2] ^ d_in[3] ^ d_in[7] ^ d_in[8] ^ d_in[9] ^ d_in[10] ^ d_in[14] ^ d_in[15] ^ d_in[16] ^ d_in[17] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25] ^ d_in[29] ^ d_in[30] ^ d_in[31];
		parity_out[3]	<=		d_in[4] ^ d_in[5] ^ d_in[6] ^ d_in[7] ^ d_in[8] ^ d_in[9] ^ d_in[10] ^ d_in[18] ^ d_in[19] ^ d_in[20] ^ d_in[21] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25];
		parity_out[4]	<=		d_in[11] ^ d_in[12] ^ d_in[13] ^ d_in[14] ^ d_in[15] ^ d_in[16] ^ d_in[17] ^ d_in[18] ^ d_in[19] ^ d_in[20] ^ d_in[21] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25];
		parity_out[5]	<=		d_in[26] ^ d_in[27] ^ d_in[28] ^ d_in[29] ^ d_in[30] ^ d_in[31];
	end
end
assign codeword_out[0] 		=		parity_out[0];
assign codeword_out[1] 		=		parity_out[1];
assign codeword_out[2] 		=		d_out[0];
assign codeword_out[3] 		=		parity_out[2];
assign codeword_out[6:4] 	=		d_out[3:1];
assign codeword_out[7] 		=		parity_out[3];
assign codeword_out[14:8] 	=		d_out[10:4];
assign codeword_out[15] 	=		parity_out[4];
assign codeword_out[30:16] 	=		d_out[25:11];
assign codeword_out[31] 	=		parity_out[5];
assign codeword_out[37:32] 	=		d_out[31:26];
endmodule
