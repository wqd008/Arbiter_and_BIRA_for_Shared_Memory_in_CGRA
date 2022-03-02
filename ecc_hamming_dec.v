`timescale 1ns/1ps
// hamming encoder for 32bit data ECC
module ecc_hamming_decoder #(
parameter DATA_WIDTH 	= 32	,	// the data width
parameter PARITY_LENGTH = 6			// the length of parity bit , which equals to 6 for 32bits data
)(
input clk,
input rst_n,
input [DATA_WIDTH-1:0] d_in,									// input data (may contain mistakes)
input [PARITY_LENGTH-1:0] parity_in,							// input parity code
input odd_even_parity,											// input odd-even parity
output reg [DATA_WIDTH-1:0] d_out_correct, 						// output data
output reg [2:0] label_out,													// output condition label. 1: no mistake 2: one mistake and corrected 3:two mistakes but can't corrected 4:one mistake on odd_even_parity
output odd_even_imm,
output [PARITY_LENGTH-1:0] parity_imm 
//output [DATA_WIDTH+PARITY_LENGTH-1:0] codeword_out_correct 		// output codeword
);
//reg [PARITY_LENGTH-1:0] parity = 0;

//wire [PARITY_LENGTH-1:0] parity_imm ;
//wire odd_even_imm;
wire [PARITY_LENGTH+DATA_WIDTH-1:0] codeword;
reg  [PARITY_LENGTH+DATA_WIDTH-1:0] codeword_imm;
reg  [2:0] label_imm;
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
		d_out_correct 		<= 		0;
		label_out			<=		0;
		//parity_out 		<= 		0;
		//codeword_out 	<= 		0;

	end
	else begin
		d_out_correct		<=		{codeword_imm[37:32],codeword_imm[30:16],codeword_imm[14:8],codeword_imm[6:4],codeword_imm[2]};
		label_out			<=		label_imm;
	end
end
always @ (d_in or parity_in or odd_even_parity) begin
		//--------------------------------------------------------------------------
		// obtain the codeword
		//--------------------------------------------------------------------------
		codeword_imm[0] 		=		parity_in[0];
		codeword_imm[1] 		=		parity_in[1];
		codeword_imm[2] 		=		d_in[0];
		codeword_imm[3] 		=		parity_in[2];
		codeword_imm[6:4] 		=		d_in[3:1];
		codeword_imm[7] 		=		parity_in[3];
		codeword_imm[14:8] 		=		d_in[10:4];
		codeword_imm[15] 		=		parity_in[4];
		codeword_imm[30:16] 	=		d_in[25:11];
		codeword_imm[31] 		=		parity_in[5];
		codeword_imm[37:32] 	=		d_in[31:26];
		if ((parity_imm == 0) & (odd_even_imm == 0)) begin
			label_imm 		= 		1;
			//codeword_imm			=		codeword_imm;
		end
		else if ((parity_imm != 0) & (odd_even_imm == 1)) begin
			label_imm		=		2;
			//decoder to one-hot
			case(parity_imm)
             6'b000001:     codeword_imm[0] = ~codeword[0];
             6'b000010:     codeword_imm[1] = ~codeword[1];
             6'b000011:     codeword_imm[2] = ~codeword[2];
             6'b000100:     codeword_imm[3] = ~codeword[3];
             6'b000101:     codeword_imm[4] = ~codeword[4];
             6'b000110:     codeword_imm[5] = ~codeword[5];
             6'b000111:     codeword_imm[6] = ~codeword[6];
             6'b001000:     codeword_imm[7] = ~codeword[7];
             6'b001001:     codeword_imm[8] = ~codeword[8];
             6'b001010:     codeword_imm[9] = ~codeword[9];
             6'b001011:     codeword_imm[10] = ~codeword[10];
             6'b001100:     codeword_imm[11] = ~codeword[11];
             6'b001101:     codeword_imm[12] = ~codeword[12];
             6'b001110:     codeword_imm[13] = ~codeword[13];
             6'b001111:     codeword_imm[14] = ~codeword[14];
             6'b010000:     codeword_imm[15] = ~codeword[15];
             6'b010001:     codeword_imm[16] = ~codeword[16];
             6'b010010:     codeword_imm[17] = ~codeword[17];
             6'b010011:     codeword_imm[18] = ~codeword[18];
             6'b010100:     codeword_imm[19] = ~codeword[19];
             6'b010101:     codeword_imm[20] = ~codeword[20];
             6'b010110:     codeword_imm[21] = ~codeword[21];
             6'b010111:     codeword_imm[22] = ~codeword[22];
             6'b011000:     codeword_imm[23] = ~codeword[23];
             6'b011001:     codeword_imm[24] = ~codeword[24];
             6'b011010:     codeword_imm[25] = ~codeword[25];
             6'b011011:     codeword_imm[26] = ~codeword[26];
             6'b011100:     codeword_imm[27] = ~codeword[27];
             6'b011101:     codeword_imm[28] = ~codeword[28];
             6'b011110:     codeword_imm[29] = ~codeword[29];
             6'b011111:     codeword_imm[30] = ~codeword[30];
             6'b100000:     codeword_imm[31] = ~codeword[31];
             6'b100001:     codeword_imm[32] = ~codeword[32];
             6'b100010:     codeword_imm[33] = ~codeword[33];
             6'b100011:     codeword_imm[34] = ~codeword[34];
             6'b100100:     codeword_imm[35] = ~codeword[35];
             6'b100101:     codeword_imm[36] = ~codeword[36];
             6'b100110:     codeword_imm[37] = ~codeword[37];
			   default:		codeword_imm	 = codeword		;

			endcase
		end
		else if ((parity_imm != 0) & (odd_even_imm == 0)) begin
			label_imm 		= 		3;
			//d_out			=		d_in;
		end
		else begin
			label_imm		=		4;
			//d_out			=		d_in;
		end
end

//--------------------------------------------------------------------------
// calculate the parity code from data
//--------------------------------------------------------------------------
assign	parity_imm[0]	=		parity_in[0] ^ d_in[0] ^ d_in[1] ^ d_in[3] ^ d_in[4] ^ d_in[6] ^ d_in[8] ^ d_in[10] ^ d_in[11] ^ d_in[13] ^ d_in[15] ^ d_in[17] ^ d_in[19] ^ d_in[21] ^ d_in[23] ^ d_in[25] ^ d_in[26] ^ d_in[28] ^ d_in[30];
assign	parity_imm[1]	=		parity_in[1] ^ d_in[0] ^ d_in[2] ^ d_in[3] ^ d_in[5] ^ d_in[6] ^ d_in[9] ^ d_in[10] ^ d_in[12] ^ d_in[13] ^ d_in[16] ^ d_in[17] ^ d_in[20] ^ d_in[21] ^ d_in[24] ^ d_in[25] ^ d_in[27] ^ d_in[28] ^ d_in[31];
assign 	parity_imm[2]	=		parity_in[2] ^ d_in[1] ^ d_in[2] ^ d_in[3] ^ d_in[7] ^ d_in[8] ^ d_in[9] ^ d_in[10] ^ d_in[14] ^ d_in[15] ^ d_in[16] ^ d_in[17] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25] ^ d_in[29] ^ d_in[30] ^ d_in[31];
assign 	parity_imm[3]	=		parity_in[3] ^ d_in[4] ^ d_in[5] ^ d_in[6] ^ d_in[7] ^ d_in[8] ^ d_in[9] ^ d_in[10] ^ d_in[18] ^ d_in[19] ^ d_in[20] ^ d_in[21] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25];
assign	parity_imm[4]	=		parity_in[4] ^ d_in[11] ^ d_in[12] ^ d_in[13] ^ d_in[14] ^ d_in[15] ^ d_in[16] ^ d_in[17] ^ d_in[18] ^ d_in[19] ^ d_in[20] ^ d_in[21] ^ d_in[22] ^ d_in[23] ^ d_in[24] ^ d_in[25];
assign	parity_imm[5]	=		parity_in[5] ^ d_in[26] ^ d_in[27] ^ d_in[28] ^ d_in[29] ^ d_in[30] ^ d_in[31];
//--------------------------------------------------------------------------
// obtain the codeword
//--------------------------------------------------------------------------
assign 	codeword[0] 		=		parity_in[0];
assign 	codeword[1] 		=		parity_in[1];
assign 	codeword[2] 		=		d_in[0];
assign 	codeword[3] 		=		parity_in[2];
assign 	codeword[6:4] 		=		d_in[3:1];
assign 	codeword[7] 		=		parity_in[3];
assign 	codeword[14:8] 		=		d_in[10:4];
assign 	codeword[15] 		=		parity_in[4];
assign 	codeword[30:16] 	=		d_in[25:11];
assign 	codeword[31] 		=		parity_in[5];
assign 	codeword[37:32] 	=		d_in[31:26];
//--------------------------------------------------------------------------
// obtain the odd_even-parity
//--------------------------------------------------------------------------
assign odd_even_imm = (^ codeword) ^ odd_even_parity;
endmodule
