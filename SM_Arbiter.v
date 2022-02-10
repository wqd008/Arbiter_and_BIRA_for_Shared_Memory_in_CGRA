`timescale 1ns / 1ps

module SM_Arbiter //Arbiter for Shared Memory in CGRA
#(
    //----------------------------------
    // Parameter Declarations for FIFO
    //----------------------------------
    parameter FIFO_PTR 			= 4             , // the corresponding address of each word in fifo
    parameter FIFO_WIDTH        = 36            , // the width of each word in fifo (the upper four bits denote the target bank, the rest denotes the data)
    parameter FIFO_DEPTH        = 16            , // the total room a fifo could store
	parameter MEM_BANK_NUM	    = 16			, // the number of the memory banks
    //----------------------------------
    // Parameter Declarations for Arbiter
    //----------------------------------
    parameter PE_NUM            = 36			  // the number of request number, which equals to the number of pe
)
(
    //----------------------------------
    // IO Declarations for 36 FIFOs
    //----------------------------------
	input 						clk			   		 		 , // clock
	input [PE_NUM-1:0] 			rst_fifo					 , // rst signal for fifos
	input [MEM_BANK_NUM-1:0] 	rst_arbiter					 , // rst signal for Arbiters
	input [PE_NUM-1:0] 			write_en					 , // write enable signal
	input [PE_NUM-1:0] 			read_en						 , // read enable signal
	input [FIFO_WIDTH-1:0]      req_data_0 	  			     , // the request data from PE0, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_1 	  			     , // the request data from PE1, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_2 	  			     , // the request data from PE2, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_3 	  			     , // the request data from PE3, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_4 	  			     , // the request data from PE4, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_5 	  			     , // the request data from PE5, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_6 	  			     , // the request data from PE6, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_7 	  			     , // the request data from PE7, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_8 	  			     , // the request data from PE8, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_9 	  			     , // the request data from PE9, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_10 	  			 , // the request data from PE10, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_11 	  			 , // the request data from PE11, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_12 	  			 , // the request data from PE12, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_13 	  			 , // the request data from PE13, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_14 	  			 , // the request data from PE14, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_15 	  			 , // the request data from PE15, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_16 	  			 , // the request data from PE16, each request is 36 bits, where the first 4 bits denotes the address of target bank
	input [FIFO_WIDTH-1:0]      req_data_17 	  			 , // ......
	input [FIFO_WIDTH-1:0]      req_data_18 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_19 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_20 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_21 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_22 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_23 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_24 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_25 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_26 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_27 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_28 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_29 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_30 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_31 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_32 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_33 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_34 	  			 ,
	input [FIFO_WIDTH-1:0]      req_data_35 	  			 ,
    //----------------------------------
    // IO Declarations for RR_Arbiter
    //----------------------------------
	output  [PE_NUM-1:0] 	gnt_0						 , // the grant result from arbitration of Memory Bank 0
	output  [PE_NUM-1:0] 	gnt_1						 , // ......
	output  [PE_NUM-1:0] 	gnt_2						 ,
	output  [PE_NUM-1:0] 	gnt_3						 ,
	output  [PE_NUM-1:0] 	gnt_4						 ,
	output  [PE_NUM-1:0] 	gnt_5						 ,
	output  [PE_NUM-1:0] 	gnt_6						 ,
	output  [PE_NUM-1:0] 	gnt_7						 ,
	output  [PE_NUM-1:0] 	gnt_8						 ,
	output  [PE_NUM-1:0] 	gnt_9						 ,
	output  [PE_NUM-1:0] 	gnt_10						 ,
	output  [PE_NUM-1:0] 	gnt_11						 ,
	output  [PE_NUM-1:0] 	gnt_12						 ,
	output  [PE_NUM-1:0] 	gnt_13						 ,
	output  [PE_NUM-1:0] 	gnt_14						 ,
	output  [PE_NUM-1:0] 	gnt_15						 ,
    //----------------------------------
    // Middle Signals about the output of 32 FIFOs for Testing
    //----------------------------------
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_0		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_1		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_2		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_3	    ,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_4		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_5		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_6		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_7		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_8		,
	output	[PE_NUM-1:0] 		req_PE_to_Bank_9		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_10		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_11		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_12		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_13		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_14		,
	output 	[PE_NUM-1:0] 		req_PE_to_Bank_15		,

    //----------------------------------
    // Final Signals about the output of 16 Arbiters for Testing
    //----------------------------------
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_0				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_1				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_2				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_3				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_4				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_5				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_6				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_7				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_8				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_9				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_10				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_11				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_12				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_13				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_14				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_15				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_16				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_17				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_18				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_19				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_20				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_21				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_22				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_23				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_24				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_25				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_26				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_27				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_28				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_29				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_30				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_31				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_32				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_33				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_34				,
	output 	[MEM_BANK_NUM-1:0]	nxt_gnt_35				

                
);
    //----------------------------------
    // Middle Wire Definition for request from PE 0~35 to Bank 0~15
    //----------------------------------	
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_0		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_1		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_2		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_3	    ;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_4		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_5		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_6		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_7		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_8		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_9		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_10		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_11		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_12		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_13		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_14		;
//	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_15		;
	//----------------------------------
    // Middle Wire Definition for nxt_gnt signal
    //----------------------------------	
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_0				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_1				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_2				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_3				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_4				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_5				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_6				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_7				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_8				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_9				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_10				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_11				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_12				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_13				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_14				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_15				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_16				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_17				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_18				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_19				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_20				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_21				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_22				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_23				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_24				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_25				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_26				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_27				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_28				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_29				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_30				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_31				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_32				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_33				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_34				;
//	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_35				;

    //----------------------------------
    // Simulate the 36 FIFOs manually
    //----------------------------------
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_0
    (
    .clk(clk),
    .rst_n(rst_fifo[0]),
    .write_en(write_en[0]),
    .read_en(read_en[0]),
    .write_data(req_data_0),
    .nxt_gnt(nxt_gnt_0),
    .req_pea_to_bank({req_PE_to_Bank_15[0],req_PE_to_Bank_14[0],req_PE_to_Bank_13[0],req_PE_to_Bank_12[0],req_PE_to_Bank_11[0],req_PE_to_Bank_10[0],req_PE_to_Bank_9[0],req_PE_to_Bank_8[0],req_PE_to_Bank_7[0],req_PE_to_Bank_6[0],req_PE_to_Bank_5[0],req_PE_to_Bank_4[0],req_PE_to_Bank_3[0],req_PE_to_Bank_2[0],req_PE_to_Bank_1[0],req_PE_to_Bank_0[0]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_1
    (
    .clk(clk),
    .rst_n(rst_fifo[1]),
    .write_en(write_en[1]),
    .read_en(read_en[1]),
    .write_data(req_data_1),
    .nxt_gnt(nxt_gnt_1),
    .req_pea_to_bank({req_PE_to_Bank_15[1],req_PE_to_Bank_14[1],req_PE_to_Bank_13[1],req_PE_to_Bank_12[1],req_PE_to_Bank_11[1],req_PE_to_Bank_10[1],req_PE_to_Bank_9[1],req_PE_to_Bank_8[1],req_PE_to_Bank_7[1],req_PE_to_Bank_6[1],req_PE_to_Bank_5[1],req_PE_to_Bank_4[1],req_PE_to_Bank_3[1],req_PE_to_Bank_2[1],req_PE_to_Bank_1[1],req_PE_to_Bank_0[1]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_2
    (
    .clk(clk),
    .rst_n(rst_fifo[2]),
    .write_en(write_en[2]),
    .read_en(read_en[2]),
    .write_data(req_data_2),
    .nxt_gnt(nxt_gnt_2),
    .req_pea_to_bank({req_PE_to_Bank_15[2],req_PE_to_Bank_14[2],req_PE_to_Bank_13[2],req_PE_to_Bank_12[2],req_PE_to_Bank_11[2],req_PE_to_Bank_10[2],req_PE_to_Bank_9[2],req_PE_to_Bank_8[2],req_PE_to_Bank_7[2],req_PE_to_Bank_6[2],req_PE_to_Bank_5[2],req_PE_to_Bank_4[2],req_PE_to_Bank_3[2],req_PE_to_Bank_2[2],req_PE_to_Bank_1[2],req_PE_to_Bank_0[2]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_3
    (
    .clk(clk),
    .rst_n(rst_fifo[3]),
    .write_en(write_en[3]),
    .read_en(read_en[3]),
    .write_data(req_data_3),
    .nxt_gnt(nxt_gnt_3),
    .req_pea_to_bank({req_PE_to_Bank_15[3],req_PE_to_Bank_14[3],req_PE_to_Bank_13[3],req_PE_to_Bank_12[3],req_PE_to_Bank_11[3],req_PE_to_Bank_10[3],req_PE_to_Bank_9[3],req_PE_to_Bank_8[3],req_PE_to_Bank_7[3],req_PE_to_Bank_6[3],req_PE_to_Bank_5[3],req_PE_to_Bank_4[3],req_PE_to_Bank_3[3],req_PE_to_Bank_2[3],req_PE_to_Bank_1[3],req_PE_to_Bank_0[3]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_4
    (
    .clk(clk),
    .rst_n(rst_fifo[4]),
    .write_en(write_en[4]),
    .read_en(read_en[4]),
    .write_data(req_data_4),
    .nxt_gnt(nxt_gnt_4),
    .req_pea_to_bank({req_PE_to_Bank_15[4],req_PE_to_Bank_14[4],req_PE_to_Bank_13[4],req_PE_to_Bank_12[4],req_PE_to_Bank_11[4],req_PE_to_Bank_10[4],req_PE_to_Bank_9[4],req_PE_to_Bank_8[4],req_PE_to_Bank_7[4],req_PE_to_Bank_6[4],req_PE_to_Bank_5[4],req_PE_to_Bank_4[4],req_PE_to_Bank_3[4],req_PE_to_Bank_2[4],req_PE_to_Bank_1[4],req_PE_to_Bank_0[4]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_5
    (
    .clk(clk),
    .rst_n(rst_fifo[5]),
    .write_en(write_en[5]),
    .read_en(read_en[5]),
    .write_data(req_data_5),
    .nxt_gnt(nxt_gnt_5),
    .req_pea_to_bank({req_PE_to_Bank_15[5],req_PE_to_Bank_14[5],req_PE_to_Bank_13[5],req_PE_to_Bank_12[5],req_PE_to_Bank_11[5],req_PE_to_Bank_10[5],req_PE_to_Bank_9[5],req_PE_to_Bank_8[5],req_PE_to_Bank_7[5],req_PE_to_Bank_6[5],req_PE_to_Bank_5[5],req_PE_to_Bank_4[5],req_PE_to_Bank_3[5],req_PE_to_Bank_2[5],req_PE_to_Bank_1[5],req_PE_to_Bank_0[5]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_6
    (
    .clk(clk),
    .rst_n(rst_fifo[6]),
    .write_en(write_en[6]),
    .read_en(read_en[6]),
    .write_data(req_data_6),
    .nxt_gnt(nxt_gnt_6),
    .req_pea_to_bank({req_PE_to_Bank_15[6],req_PE_to_Bank_14[6],req_PE_to_Bank_13[6],req_PE_to_Bank_12[6],req_PE_to_Bank_11[6],req_PE_to_Bank_10[6],req_PE_to_Bank_9[6],req_PE_to_Bank_8[6],req_PE_to_Bank_7[6],req_PE_to_Bank_6[6],req_PE_to_Bank_5[6],req_PE_to_Bank_4[6],req_PE_to_Bank_3[6],req_PE_to_Bank_2[6],req_PE_to_Bank_1[6],req_PE_to_Bank_0[6]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_7
    (
    .clk(clk),
    .rst_n(rst_fifo[7]),
    .write_en(write_en[7]),
    .read_en(read_en[7]),
    .write_data(req_data_7),
    .nxt_gnt(nxt_gnt_7),
    .req_pea_to_bank({req_PE_to_Bank_15[7],req_PE_to_Bank_14[7],req_PE_to_Bank_13[7],req_PE_to_Bank_12[7],req_PE_to_Bank_11[7],req_PE_to_Bank_10[7],req_PE_to_Bank_9[7],req_PE_to_Bank_8[7],req_PE_to_Bank_7[7],req_PE_to_Bank_6[7],req_PE_to_Bank_5[7],req_PE_to_Bank_4[7],req_PE_to_Bank_3[7],req_PE_to_Bank_2[7],req_PE_to_Bank_1[7],req_PE_to_Bank_0[7]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_8
    (
    .clk(clk),
    .rst_n(rst_fifo[8]),
    .write_en(write_en[8]),
    .read_en(read_en[8]),
    .write_data(req_data_8),
    .nxt_gnt(nxt_gnt_8),
    .req_pea_to_bank({req_PE_to_Bank_15[8],req_PE_to_Bank_14[8],req_PE_to_Bank_13[8],req_PE_to_Bank_12[8],req_PE_to_Bank_11[8],req_PE_to_Bank_10[8],req_PE_to_Bank_9[8],req_PE_to_Bank_8[8],req_PE_to_Bank_7[8],req_PE_to_Bank_6[8],req_PE_to_Bank_5[8],req_PE_to_Bank_4[8],req_PE_to_Bank_3[8],req_PE_to_Bank_2[8],req_PE_to_Bank_1[8],req_PE_to_Bank_0[8]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_9
    (
    .clk(clk),
    .rst_n(rst_fifo[9]),
    .write_en(write_en[9]),
    .read_en(read_en[9]),
    .write_data(req_data_9),
    .nxt_gnt(nxt_gnt_9),
    .req_pea_to_bank({req_PE_to_Bank_15[9],req_PE_to_Bank_14[9],req_PE_to_Bank_13[9],req_PE_to_Bank_12[9],req_PE_to_Bank_11[9],req_PE_to_Bank_10[9],req_PE_to_Bank_9[9],req_PE_to_Bank_8[9],req_PE_to_Bank_7[9],req_PE_to_Bank_6[9],req_PE_to_Bank_5[9],req_PE_to_Bank_4[9],req_PE_to_Bank_3[9],req_PE_to_Bank_2[9],req_PE_to_Bank_1[9],req_PE_to_Bank_0[9]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_10
    (
    .clk(clk),
    .rst_n(rst_fifo[10]),
    .write_en(write_en[10]),
    .read_en(read_en[10]),
    .write_data(req_data_10),
    .nxt_gnt(nxt_gnt_10),
    .req_pea_to_bank({req_PE_to_Bank_15[10],req_PE_to_Bank_14[10],req_PE_to_Bank_13[10],req_PE_to_Bank_12[10],req_PE_to_Bank_11[10],req_PE_to_Bank_10[10],req_PE_to_Bank_9[10],req_PE_to_Bank_8[10],req_PE_to_Bank_7[10],req_PE_to_Bank_6[10],req_PE_to_Bank_5[10],req_PE_to_Bank_4[10],req_PE_to_Bank_3[10],req_PE_to_Bank_2[10],req_PE_to_Bank_1[10],req_PE_to_Bank_0[10]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_11
    (
    .clk(clk),
    .rst_n(rst_fifo[11]),
    .write_en(write_en[11]),
    .read_en(read_en[11]),
    .write_data(req_data_11),
    .nxt_gnt(nxt_gnt_11),
    .req_pea_to_bank({req_PE_to_Bank_15[11],req_PE_to_Bank_14[11],req_PE_to_Bank_13[11],req_PE_to_Bank_12[11],req_PE_to_Bank_11[11],req_PE_to_Bank_10[11],req_PE_to_Bank_9[11],req_PE_to_Bank_8[11],req_PE_to_Bank_7[11],req_PE_to_Bank_6[11],req_PE_to_Bank_5[11],req_PE_to_Bank_4[11],req_PE_to_Bank_3[11],req_PE_to_Bank_2[11],req_PE_to_Bank_1[11],req_PE_to_Bank_0[11]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_12
    (
    .clk(clk),
    .rst_n(rst_fifo[12]),
    .write_en(write_en[12]),
    .read_en(read_en[12]),
    .write_data(req_data_12),
    .nxt_gnt(nxt_gnt_12),
    .req_pea_to_bank({req_PE_to_Bank_15[12],req_PE_to_Bank_14[12],req_PE_to_Bank_13[12],req_PE_to_Bank_12[12],req_PE_to_Bank_11[12],req_PE_to_Bank_10[12],req_PE_to_Bank_9[12],req_PE_to_Bank_8[12],req_PE_to_Bank_7[12],req_PE_to_Bank_6[12],req_PE_to_Bank_5[12],req_PE_to_Bank_4[12],req_PE_to_Bank_3[12],req_PE_to_Bank_2[12],req_PE_to_Bank_1[12],req_PE_to_Bank_0[12]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_13
    (
    .clk(clk),
    .rst_n(rst_fifo[13]),
    .write_en(write_en[13]),
    .read_en(read_en[13]),
    .write_data(req_data_13),
    .nxt_gnt(nxt_gnt_13),
    .req_pea_to_bank({req_PE_to_Bank_15[13],req_PE_to_Bank_14[13],req_PE_to_Bank_13[13],req_PE_to_Bank_12[13],req_PE_to_Bank_11[13],req_PE_to_Bank_10[13],req_PE_to_Bank_9[13],req_PE_to_Bank_8[13],req_PE_to_Bank_7[13],req_PE_to_Bank_6[13],req_PE_to_Bank_5[13],req_PE_to_Bank_4[13],req_PE_to_Bank_3[13],req_PE_to_Bank_2[13],req_PE_to_Bank_1[13],req_PE_to_Bank_0[13]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_14
    (
    .clk(clk),
    .rst_n(rst_fifo[14]),
    .write_en(write_en[14]),
    .read_en(read_en[14]),
    .write_data(req_data_14),
    .nxt_gnt(nxt_gnt_14),
    .req_pea_to_bank({req_PE_to_Bank_15[14],req_PE_to_Bank_14[14],req_PE_to_Bank_13[14],req_PE_to_Bank_12[14],req_PE_to_Bank_11[14],req_PE_to_Bank_10[14],req_PE_to_Bank_9[14],req_PE_to_Bank_8[14],req_PE_to_Bank_7[14],req_PE_to_Bank_6[14],req_PE_to_Bank_5[14],req_PE_to_Bank_4[14],req_PE_to_Bank_3[14],req_PE_to_Bank_2[14],req_PE_to_Bank_1[14],req_PE_to_Bank_0[14]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_15
    (
    .clk(clk),
    .rst_n(rst_fifo[15]),
    .write_en(write_en[15]),
    .read_en(read_en[15]),
    .write_data(req_data_15),
    .nxt_gnt(nxt_gnt_15),
    .req_pea_to_bank({req_PE_to_Bank_15[15],req_PE_to_Bank_14[15],req_PE_to_Bank_13[15],req_PE_to_Bank_12[15],req_PE_to_Bank_11[15],req_PE_to_Bank_10[15],req_PE_to_Bank_9[15],req_PE_to_Bank_8[15],req_PE_to_Bank_7[15],req_PE_to_Bank_6[15],req_PE_to_Bank_5[15],req_PE_to_Bank_4[15],req_PE_to_Bank_3[15],req_PE_to_Bank_2[15],req_PE_to_Bank_1[15],req_PE_to_Bank_0[15]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_16
    (
    .clk(clk),
    .rst_n(rst_fifo[16]),
    .write_en(write_en[16]),
    .read_en(read_en[16]),
    .write_data(req_data_16),
    .nxt_gnt(nxt_gnt_16),
    .req_pea_to_bank({req_PE_to_Bank_15[16],req_PE_to_Bank_14[16],req_PE_to_Bank_13[16],req_PE_to_Bank_12[16],req_PE_to_Bank_11[16],req_PE_to_Bank_10[16],req_PE_to_Bank_9[16],req_PE_to_Bank_8[16],req_PE_to_Bank_7[16],req_PE_to_Bank_6[16],req_PE_to_Bank_5[16],req_PE_to_Bank_4[16],req_PE_to_Bank_3[16],req_PE_to_Bank_2[16],req_PE_to_Bank_1[16],req_PE_to_Bank_0[16]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_17
    (
    .clk(clk),
    .rst_n(rst_fifo[17]),
    .write_en(write_en[17]),
    .read_en(read_en[17]),
    .write_data(req_data_17),
    .nxt_gnt(nxt_gnt_17),
    .req_pea_to_bank({req_PE_to_Bank_15[17],req_PE_to_Bank_14[17],req_PE_to_Bank_13[17],req_PE_to_Bank_12[17],req_PE_to_Bank_11[17],req_PE_to_Bank_10[17],req_PE_to_Bank_9[17],req_PE_to_Bank_8[17],req_PE_to_Bank_7[17],req_PE_to_Bank_6[17],req_PE_to_Bank_5[17],req_PE_to_Bank_4[17],req_PE_to_Bank_3[17],req_PE_to_Bank_2[17],req_PE_to_Bank_1[17],req_PE_to_Bank_0[17]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_18
    (
    .clk(clk),
    .rst_n(rst_fifo[18]),
    .write_en(write_en[18]),
    .read_en(read_en[18]),
    .write_data(req_data_18),
    .nxt_gnt(nxt_gnt_18),
    .req_pea_to_bank({req_PE_to_Bank_15[18],req_PE_to_Bank_14[18],req_PE_to_Bank_13[18],req_PE_to_Bank_12[18],req_PE_to_Bank_11[18],req_PE_to_Bank_10[18],req_PE_to_Bank_9[18],req_PE_to_Bank_8[18],req_PE_to_Bank_7[18],req_PE_to_Bank_6[18],req_PE_to_Bank_5[18],req_PE_to_Bank_4[18],req_PE_to_Bank_3[18],req_PE_to_Bank_2[18],req_PE_to_Bank_1[18],req_PE_to_Bank_0[18]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_19
    (
    .clk(clk),
    .rst_n(rst_fifo[19]),
    .write_en(write_en[19]),
    .read_en(read_en[19]),
    .write_data(req_data_19),
    .nxt_gnt(nxt_gnt_19),
    .req_pea_to_bank({req_PE_to_Bank_15[19],req_PE_to_Bank_14[19],req_PE_to_Bank_13[19],req_PE_to_Bank_12[19],req_PE_to_Bank_11[19],req_PE_to_Bank_10[19],req_PE_to_Bank_9[19],req_PE_to_Bank_8[19],req_PE_to_Bank_7[19],req_PE_to_Bank_6[19],req_PE_to_Bank_5[19],req_PE_to_Bank_4[19],req_PE_to_Bank_3[19],req_PE_to_Bank_2[19],req_PE_to_Bank_1[19],req_PE_to_Bank_0[19]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_20
    (
    .clk(clk),
    .rst_n(rst_fifo[20]),
    .write_en(write_en[20]),
    .read_en(read_en[20]),
    .write_data(req_data_20),
    .nxt_gnt(nxt_gnt_20),
    .req_pea_to_bank({req_PE_to_Bank_15[20],req_PE_to_Bank_14[20],req_PE_to_Bank_13[20],req_PE_to_Bank_12[20],req_PE_to_Bank_11[20],req_PE_to_Bank_10[20],req_PE_to_Bank_9[20],req_PE_to_Bank_8[20],req_PE_to_Bank_7[20],req_PE_to_Bank_6[20],req_PE_to_Bank_5[20],req_PE_to_Bank_4[20],req_PE_to_Bank_3[20],req_PE_to_Bank_2[20],req_PE_to_Bank_1[20],req_PE_to_Bank_0[20]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_21
    (
    .clk(clk),
    .rst_n(rst_fifo[21]),
    .write_en(write_en[21]),
    .read_en(read_en[21]),
    .write_data(req_data_21),
    .nxt_gnt(nxt_gnt_21),
    .req_pea_to_bank({req_PE_to_Bank_15[21],req_PE_to_Bank_14[21],req_PE_to_Bank_13[21],req_PE_to_Bank_12[21],req_PE_to_Bank_11[21],req_PE_to_Bank_10[21],req_PE_to_Bank_9[21],req_PE_to_Bank_8[21],req_PE_to_Bank_7[21],req_PE_to_Bank_6[21],req_PE_to_Bank_5[21],req_PE_to_Bank_4[21],req_PE_to_Bank_3[21],req_PE_to_Bank_2[21],req_PE_to_Bank_1[21],req_PE_to_Bank_0[21]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_22
    (
    .clk(clk),
    .rst_n(rst_fifo[22]),
    .write_en(write_en[22]),
    .read_en(read_en[22]),
    .write_data(req_data_22),
    .nxt_gnt(nxt_gnt_22),
    .req_pea_to_bank({req_PE_to_Bank_15[22],req_PE_to_Bank_14[22],req_PE_to_Bank_13[22],req_PE_to_Bank_12[22],req_PE_to_Bank_11[22],req_PE_to_Bank_10[22],req_PE_to_Bank_9[22],req_PE_to_Bank_8[22],req_PE_to_Bank_7[22],req_PE_to_Bank_6[22],req_PE_to_Bank_5[22],req_PE_to_Bank_4[22],req_PE_to_Bank_3[22],req_PE_to_Bank_2[22],req_PE_to_Bank_1[22],req_PE_to_Bank_0[22]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_23
    (
    .clk(clk),
    .rst_n(rst_fifo[23]),
    .write_en(write_en[23]),
    .read_en(read_en[23]),
    .write_data(req_data_23),
    .nxt_gnt(nxt_gnt_23),
    .req_pea_to_bank({req_PE_to_Bank_15[23],req_PE_to_Bank_14[23],req_PE_to_Bank_13[23],req_PE_to_Bank_12[23],req_PE_to_Bank_11[23],req_PE_to_Bank_10[23],req_PE_to_Bank_9[23],req_PE_to_Bank_8[23],req_PE_to_Bank_7[23],req_PE_to_Bank_6[23],req_PE_to_Bank_5[23],req_PE_to_Bank_4[23],req_PE_to_Bank_3[23],req_PE_to_Bank_2[23],req_PE_to_Bank_1[23],req_PE_to_Bank_0[23]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_24
    (
    .clk(clk),
    .rst_n(rst_fifo[24]),
    .write_en(write_en[24]),
    .read_en(read_en[24]),
    .write_data(req_data_24),
    .nxt_gnt(nxt_gnt_24),
    .req_pea_to_bank({req_PE_to_Bank_15[24],req_PE_to_Bank_14[24],req_PE_to_Bank_13[24],req_PE_to_Bank_12[24],req_PE_to_Bank_11[24],req_PE_to_Bank_10[24],req_PE_to_Bank_9[24],req_PE_to_Bank_8[24],req_PE_to_Bank_7[24],req_PE_to_Bank_6[24],req_PE_to_Bank_5[24],req_PE_to_Bank_4[24],req_PE_to_Bank_3[24],req_PE_to_Bank_2[24],req_PE_to_Bank_1[24],req_PE_to_Bank_0[24]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_25
    (
    .clk(clk),
    .rst_n(rst_fifo[25]),
    .write_en(write_en[25]),
    .read_en(read_en[25]),
    .write_data(req_data_25),
    .nxt_gnt(nxt_gnt_25),
    .req_pea_to_bank({req_PE_to_Bank_15[25],req_PE_to_Bank_14[25],req_PE_to_Bank_13[25],req_PE_to_Bank_12[25],req_PE_to_Bank_11[25],req_PE_to_Bank_10[25],req_PE_to_Bank_9[25],req_PE_to_Bank_8[25],req_PE_to_Bank_7[25],req_PE_to_Bank_6[25],req_PE_to_Bank_5[25],req_PE_to_Bank_4[25],req_PE_to_Bank_3[25],req_PE_to_Bank_2[25],req_PE_to_Bank_1[25],req_PE_to_Bank_0[25]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_26
    (
    .clk(clk),
    .rst_n(rst_fifo[26]),
    .write_en(write_en[26]),
    .read_en(read_en[26]),
    .write_data(req_data_26),
    .nxt_gnt(nxt_gnt_26),
    .req_pea_to_bank({req_PE_to_Bank_15[26],req_PE_to_Bank_14[26],req_PE_to_Bank_13[26],req_PE_to_Bank_12[26],req_PE_to_Bank_11[26],req_PE_to_Bank_10[26],req_PE_to_Bank_9[26],req_PE_to_Bank_8[26],req_PE_to_Bank_7[26],req_PE_to_Bank_6[26],req_PE_to_Bank_5[26],req_PE_to_Bank_4[26],req_PE_to_Bank_3[26],req_PE_to_Bank_2[26],req_PE_to_Bank_1[26],req_PE_to_Bank_0[26]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_27
    (
    .clk(clk),
    .rst_n(rst_fifo[27]),
    .write_en(write_en[27]),
    .read_en(read_en[27]),
    .write_data(req_data_27),
    .nxt_gnt(nxt_gnt_27),
    .req_pea_to_bank({req_PE_to_Bank_15[27],req_PE_to_Bank_14[27],req_PE_to_Bank_13[27],req_PE_to_Bank_12[27],req_PE_to_Bank_11[27],req_PE_to_Bank_10[27],req_PE_to_Bank_9[27],req_PE_to_Bank_8[27],req_PE_to_Bank_7[27],req_PE_to_Bank_6[27],req_PE_to_Bank_5[27],req_PE_to_Bank_4[27],req_PE_to_Bank_3[27],req_PE_to_Bank_2[27],req_PE_to_Bank_1[27],req_PE_to_Bank_0[27]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_28
    (
    .clk(clk),
    .rst_n(rst_fifo[28]),
    .write_en(write_en[28]),
    .read_en(read_en[28]),
    .write_data(req_data_28),
    .nxt_gnt(nxt_gnt_28),
    .req_pea_to_bank({req_PE_to_Bank_15[28],req_PE_to_Bank_14[28],req_PE_to_Bank_13[28],req_PE_to_Bank_12[28],req_PE_to_Bank_11[28],req_PE_to_Bank_10[28],req_PE_to_Bank_9[28],req_PE_to_Bank_8[28],req_PE_to_Bank_7[28],req_PE_to_Bank_6[28],req_PE_to_Bank_5[28],req_PE_to_Bank_4[28],req_PE_to_Bank_3[28],req_PE_to_Bank_2[28],req_PE_to_Bank_1[28],req_PE_to_Bank_0[28]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_29
    (
    .clk(clk),
    .rst_n(rst_fifo[29]),
    .write_en(write_en[29]),
    .read_en(read_en[29]),
    .write_data(req_data_29),
    .nxt_gnt(nxt_gnt_29),
    .req_pea_to_bank({req_PE_to_Bank_15[29],req_PE_to_Bank_14[29],req_PE_to_Bank_13[29],req_PE_to_Bank_12[29],req_PE_to_Bank_11[29],req_PE_to_Bank_10[29],req_PE_to_Bank_9[29],req_PE_to_Bank_8[29],req_PE_to_Bank_7[29],req_PE_to_Bank_6[29],req_PE_to_Bank_5[29],req_PE_to_Bank_4[29],req_PE_to_Bank_3[29],req_PE_to_Bank_2[29],req_PE_to_Bank_1[29],req_PE_to_Bank_0[29]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_30
    (
    .clk(clk),
    .rst_n(rst_fifo[30]),
    .write_en(write_en[30]),
    .read_en(read_en[30]),
    .write_data(req_data_30),
    .nxt_gnt(nxt_gnt_30),
    .req_pea_to_bank({req_PE_to_Bank_15[30],req_PE_to_Bank_14[30],req_PE_to_Bank_13[30],req_PE_to_Bank_12[30],req_PE_to_Bank_11[30],req_PE_to_Bank_10[30],req_PE_to_Bank_9[30],req_PE_to_Bank_8[30],req_PE_to_Bank_7[30],req_PE_to_Bank_6[30],req_PE_to_Bank_5[30],req_PE_to_Bank_4[30],req_PE_to_Bank_3[30],req_PE_to_Bank_2[30],req_PE_to_Bank_1[30],req_PE_to_Bank_0[30]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_31
    (
    .clk(clk),
    .rst_n(rst_fifo[31]),
    .write_en(write_en[31]),
    .read_en(read_en[31]),
    .write_data(req_data_31),
    .nxt_gnt(nxt_gnt_31),
    .req_pea_to_bank({req_PE_to_Bank_15[31],req_PE_to_Bank_14[31],req_PE_to_Bank_13[31],req_PE_to_Bank_12[31],req_PE_to_Bank_11[31],req_PE_to_Bank_10[31],req_PE_to_Bank_9[31],req_PE_to_Bank_8[31],req_PE_to_Bank_7[31],req_PE_to_Bank_6[31],req_PE_to_Bank_5[31],req_PE_to_Bank_4[31],req_PE_to_Bank_3[31],req_PE_to_Bank_2[31],req_PE_to_Bank_1[31],req_PE_to_Bank_0[31]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_32
    (
    .clk(clk),
    .rst_n(rst_fifo[32]),
    .write_en(write_en[32]),
    .read_en(read_en[32]),
    .write_data(req_data_32),
    .nxt_gnt(nxt_gnt_32),
    .req_pea_to_bank({req_PE_to_Bank_15[32],req_PE_to_Bank_14[32],req_PE_to_Bank_13[32],req_PE_to_Bank_12[32],req_PE_to_Bank_11[32],req_PE_to_Bank_10[32],req_PE_to_Bank_9[32],req_PE_to_Bank_8[32],req_PE_to_Bank_7[32],req_PE_to_Bank_6[32],req_PE_to_Bank_5[32],req_PE_to_Bank_4[32],req_PE_to_Bank_3[32],req_PE_to_Bank_2[32],req_PE_to_Bank_1[32],req_PE_to_Bank_0[32]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_33
    (
    .clk(clk),
    .rst_n(rst_fifo[33]),
    .write_en(write_en[33]),
    .read_en(read_en[33]),
    .write_data(req_data_33),
    .nxt_gnt(nxt_gnt_33),
    .req_pea_to_bank({req_PE_to_Bank_15[33],req_PE_to_Bank_14[33],req_PE_to_Bank_13[33],req_PE_to_Bank_12[33],req_PE_to_Bank_11[33],req_PE_to_Bank_10[33],req_PE_to_Bank_9[33],req_PE_to_Bank_8[33],req_PE_to_Bank_7[33],req_PE_to_Bank_6[33],req_PE_to_Bank_5[33],req_PE_to_Bank_4[33],req_PE_to_Bank_3[33],req_PE_to_Bank_2[33],req_PE_to_Bank_1[33],req_PE_to_Bank_0[33]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_34
    (
    .clk(clk),
    .rst_n(rst_fifo[34]),
    .write_en(write_en[34]),
    .read_en(read_en[34]),
    .write_data(req_data_34),
    .nxt_gnt(nxt_gnt_34),
    .req_pea_to_bank({req_PE_to_Bank_15[34],req_PE_to_Bank_14[34],req_PE_to_Bank_13[34],req_PE_to_Bank_12[34],req_PE_to_Bank_11[34],req_PE_to_Bank_10[34],req_PE_to_Bank_9[34],req_PE_to_Bank_8[34],req_PE_to_Bank_7[34],req_PE_to_Bank_6[34],req_PE_to_Bank_5[34],req_PE_to_Bank_4[34],req_PE_to_Bank_3[34],req_PE_to_Bank_2[34],req_PE_to_Bank_1[34],req_PE_to_Bank_0[34]})
    );
    synch_fifo
    #(
    .FIFO_PTR			(FIFO_PTR		),
    .FIFO_WIDTH			(FIFO_WIDTH		),
    .FIFO_DEPTH			(FIFO_DEPTH 	),
    .MEM_BANK_NUM		(MEM_BANK_NUM	)
    )
    u_synch_fifo_35
    (
    .clk(clk),
    .rst_n(rst_fifo[35]),
    .write_en(write_en[35]),
    .read_en(read_en[35]),
    .write_data(req_data_35),
    .nxt_gnt(nxt_gnt_35),
    .req_pea_to_bank({req_PE_to_Bank_15[35],req_PE_to_Bank_14[35],req_PE_to_Bank_13[35],req_PE_to_Bank_12[35],req_PE_to_Bank_11[35],req_PE_to_Bank_10[35],req_PE_to_Bank_9[35],req_PE_to_Bank_8[35],req_PE_to_Bank_7[35],req_PE_to_Bank_6[35],req_PE_to_Bank_5[35],req_PE_to_Bank_4[35],req_PE_to_Bank_3[35],req_PE_to_Bank_2[35],req_PE_to_Bank_1[35],req_PE_to_Bank_0[35]})
    );

    //----------------------------------
    // Simulate the 16 Memory Banks manually
    //----------------------------------
    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_0
    (
    .clk(clk),
    .rst(rst_arbiter[0]),
    .req(req_PE_to_Bank_0),
    .nxt_gnt({nxt_gnt_35[0],nxt_gnt_34[0],nxt_gnt_33[0],nxt_gnt_32[0],nxt_gnt_31[0],nxt_gnt_30[0],nxt_gnt_29[0],nxt_gnt_28[0],nxt_gnt_27[0],nxt_gnt_26[0],nxt_gnt_25[0],nxt_gnt_24[0],nxt_gnt_23[0],nxt_gnt_22[0],nxt_gnt_21[0],nxt_gnt_20[0],nxt_gnt_19[0],nxt_gnt_18[0],nxt_gnt_17[0],nxt_gnt_16[0],nxt_gnt_15[0],nxt_gnt_14[0],nxt_gnt_13[0],nxt_gnt_12[0],nxt_gnt_11[0],nxt_gnt_10[0],nxt_gnt_9[0],nxt_gnt_8[0],nxt_gnt_7[0],nxt_gnt_6[0],nxt_gnt_5[0],nxt_gnt_4[0],nxt_gnt_3[0],nxt_gnt_2[0],nxt_gnt_1[0],nxt_gnt_0[0]}),
    .gnt(gnt_0)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_1
    (
    .clk(clk),
    .rst(rst_arbiter[1]),
    .req(req_PE_to_Bank_1),
    .nxt_gnt({nxt_gnt_35[1],nxt_gnt_34[1],nxt_gnt_33[1],nxt_gnt_32[1],nxt_gnt_31[1],nxt_gnt_30[1],nxt_gnt_29[1],nxt_gnt_28[1],nxt_gnt_27[1],nxt_gnt_26[1],nxt_gnt_25[1],nxt_gnt_24[1],nxt_gnt_23[1],nxt_gnt_22[1],nxt_gnt_21[1],nxt_gnt_20[1],nxt_gnt_19[1],nxt_gnt_18[1],nxt_gnt_17[1],nxt_gnt_16[1],nxt_gnt_15[1],nxt_gnt_14[1],nxt_gnt_13[1],nxt_gnt_12[1],nxt_gnt_11[1],nxt_gnt_10[1],nxt_gnt_9[1],nxt_gnt_8[1],nxt_gnt_7[1],nxt_gnt_6[1],nxt_gnt_5[1],nxt_gnt_4[1],nxt_gnt_3[1],nxt_gnt_2[1],nxt_gnt_1[1],nxt_gnt_0[1]}),
    .gnt(gnt_1)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_2
    (
    .clk(clk),
    .rst(rst_arbiter[2]),
    .req(req_PE_to_Bank_2),
    .nxt_gnt({nxt_gnt_35[2],nxt_gnt_34[2],nxt_gnt_33[2],nxt_gnt_32[2],nxt_gnt_31[2],nxt_gnt_30[2],nxt_gnt_29[2],nxt_gnt_28[2],nxt_gnt_27[2],nxt_gnt_26[2],nxt_gnt_25[2],nxt_gnt_24[2],nxt_gnt_23[2],nxt_gnt_22[2],nxt_gnt_21[2],nxt_gnt_20[2],nxt_gnt_19[2],nxt_gnt_18[2],nxt_gnt_17[2],nxt_gnt_16[2],nxt_gnt_15[2],nxt_gnt_14[2],nxt_gnt_13[2],nxt_gnt_12[2],nxt_gnt_11[2],nxt_gnt_10[2],nxt_gnt_9[2],nxt_gnt_8[2],nxt_gnt_7[2],nxt_gnt_6[2],nxt_gnt_5[2],nxt_gnt_4[2],nxt_gnt_3[2],nxt_gnt_2[2],nxt_gnt_1[2],nxt_gnt_0[2]}),
    .gnt(gnt_2)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_3
    (
    .clk(clk),
    .rst(rst_arbiter[3]),
    .req(req_PE_to_Bank_3),
    .nxt_gnt({nxt_gnt_35[3],nxt_gnt_34[3],nxt_gnt_33[3],nxt_gnt_32[3],nxt_gnt_31[3],nxt_gnt_30[3],nxt_gnt_29[3],nxt_gnt_28[3],nxt_gnt_27[3],nxt_gnt_26[3],nxt_gnt_25[3],nxt_gnt_24[3],nxt_gnt_23[3],nxt_gnt_22[3],nxt_gnt_21[3],nxt_gnt_20[3],nxt_gnt_19[3],nxt_gnt_18[3],nxt_gnt_17[3],nxt_gnt_16[3],nxt_gnt_15[3],nxt_gnt_14[3],nxt_gnt_13[3],nxt_gnt_12[3],nxt_gnt_11[3],nxt_gnt_10[3],nxt_gnt_9[3],nxt_gnt_8[3],nxt_gnt_7[3],nxt_gnt_6[3],nxt_gnt_5[3],nxt_gnt_4[3],nxt_gnt_3[3],nxt_gnt_2[3],nxt_gnt_1[3],nxt_gnt_0[3]}),
    .gnt(gnt_3)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_4
    (
    .clk(clk),
    .rst(rst_arbiter[4]),
    .req(req_PE_to_Bank_4),
    .nxt_gnt({nxt_gnt_35[4],nxt_gnt_34[4],nxt_gnt_33[4],nxt_gnt_32[4],nxt_gnt_31[4],nxt_gnt_30[4],nxt_gnt_29[4],nxt_gnt_28[4],nxt_gnt_27[4],nxt_gnt_26[4],nxt_gnt_25[4],nxt_gnt_24[4],nxt_gnt_23[4],nxt_gnt_22[4],nxt_gnt_21[4],nxt_gnt_20[4],nxt_gnt_19[4],nxt_gnt_18[4],nxt_gnt_17[4],nxt_gnt_16[4],nxt_gnt_15[4],nxt_gnt_14[4],nxt_gnt_13[4],nxt_gnt_12[4],nxt_gnt_11[4],nxt_gnt_10[4],nxt_gnt_9[4],nxt_gnt_8[4],nxt_gnt_7[4],nxt_gnt_6[4],nxt_gnt_5[4],nxt_gnt_4[4],nxt_gnt_3[4],nxt_gnt_2[4],nxt_gnt_1[4],nxt_gnt_0[4]}),
    .gnt(gnt_4)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_5
    (
    .clk(clk),
    .rst(rst_arbiter[5]),
    .req(req_PE_to_Bank_5),
    .nxt_gnt({nxt_gnt_35[5],nxt_gnt_34[5],nxt_gnt_33[5],nxt_gnt_32[5],nxt_gnt_31[5],nxt_gnt_30[5],nxt_gnt_29[5],nxt_gnt_28[5],nxt_gnt_27[5],nxt_gnt_26[5],nxt_gnt_25[5],nxt_gnt_24[5],nxt_gnt_23[5],nxt_gnt_22[5],nxt_gnt_21[5],nxt_gnt_20[5],nxt_gnt_19[5],nxt_gnt_18[5],nxt_gnt_17[5],nxt_gnt_16[5],nxt_gnt_15[5],nxt_gnt_14[5],nxt_gnt_13[5],nxt_gnt_12[5],nxt_gnt_11[5],nxt_gnt_10[5],nxt_gnt_9[5],nxt_gnt_8[5],nxt_gnt_7[5],nxt_gnt_6[5],nxt_gnt_5[5],nxt_gnt_4[5],nxt_gnt_3[5],nxt_gnt_2[5],nxt_gnt_1[5],nxt_gnt_0[5]}),
    .gnt(gnt_5)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_6
    (
    .clk(clk),
    .rst(rst_arbiter[6]),
    .req(req_PE_to_Bank_6),
    .nxt_gnt({nxt_gnt_35[6],nxt_gnt_34[6],nxt_gnt_33[6],nxt_gnt_32[6],nxt_gnt_31[6],nxt_gnt_30[6],nxt_gnt_29[6],nxt_gnt_28[6],nxt_gnt_27[6],nxt_gnt_26[6],nxt_gnt_25[6],nxt_gnt_24[6],nxt_gnt_23[6],nxt_gnt_22[6],nxt_gnt_21[6],nxt_gnt_20[6],nxt_gnt_19[6],nxt_gnt_18[6],nxt_gnt_17[6],nxt_gnt_16[6],nxt_gnt_15[6],nxt_gnt_14[6],nxt_gnt_13[6],nxt_gnt_12[6],nxt_gnt_11[6],nxt_gnt_10[6],nxt_gnt_9[6],nxt_gnt_8[6],nxt_gnt_7[6],nxt_gnt_6[6],nxt_gnt_5[6],nxt_gnt_4[6],nxt_gnt_3[6],nxt_gnt_2[6],nxt_gnt_1[6],nxt_gnt_0[6]}),
    .gnt(gnt_6)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_7
    (
    .clk(clk),
    .rst(rst_arbiter[7]),
    .req(req_PE_to_Bank_7),
    .nxt_gnt({nxt_gnt_35[7],nxt_gnt_34[7],nxt_gnt_33[7],nxt_gnt_32[7],nxt_gnt_31[7],nxt_gnt_30[7],nxt_gnt_29[7],nxt_gnt_28[7],nxt_gnt_27[7],nxt_gnt_26[7],nxt_gnt_25[7],nxt_gnt_24[7],nxt_gnt_23[7],nxt_gnt_22[7],nxt_gnt_21[7],nxt_gnt_20[7],nxt_gnt_19[7],nxt_gnt_18[7],nxt_gnt_17[7],nxt_gnt_16[7],nxt_gnt_15[7],nxt_gnt_14[7],nxt_gnt_13[7],nxt_gnt_12[7],nxt_gnt_11[7],nxt_gnt_10[7],nxt_gnt_9[7],nxt_gnt_8[7],nxt_gnt_7[7],nxt_gnt_6[7],nxt_gnt_5[7],nxt_gnt_4[7],nxt_gnt_3[7],nxt_gnt_2[7],nxt_gnt_1[7],nxt_gnt_0[7]}),
    .gnt(gnt_7)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_8
    (
    .clk(clk),
    .rst(rst_arbiter[8]),
    .req(req_PE_to_Bank_8),
    .nxt_gnt({nxt_gnt_35[8],nxt_gnt_34[8],nxt_gnt_33[8],nxt_gnt_32[8],nxt_gnt_31[8],nxt_gnt_30[8],nxt_gnt_29[8],nxt_gnt_28[8],nxt_gnt_27[8],nxt_gnt_26[8],nxt_gnt_25[8],nxt_gnt_24[8],nxt_gnt_23[8],nxt_gnt_22[8],nxt_gnt_21[8],nxt_gnt_20[8],nxt_gnt_19[8],nxt_gnt_18[8],nxt_gnt_17[8],nxt_gnt_16[8],nxt_gnt_15[8],nxt_gnt_14[8],nxt_gnt_13[8],nxt_gnt_12[8],nxt_gnt_11[8],nxt_gnt_10[8],nxt_gnt_9[8],nxt_gnt_8[8],nxt_gnt_7[8],nxt_gnt_6[8],nxt_gnt_5[8],nxt_gnt_4[8],nxt_gnt_3[8],nxt_gnt_2[8],nxt_gnt_1[8],nxt_gnt_0[8]}),
    .gnt(gnt_8)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_9
    (
    .clk(clk),
    .rst(rst_arbiter[9]),
    .req(req_PE_to_Bank_9),
    .nxt_gnt({nxt_gnt_35[9],nxt_gnt_34[9],nxt_gnt_33[9],nxt_gnt_32[9],nxt_gnt_31[9],nxt_gnt_30[9],nxt_gnt_29[9],nxt_gnt_28[9],nxt_gnt_27[9],nxt_gnt_26[9],nxt_gnt_25[9],nxt_gnt_24[9],nxt_gnt_23[9],nxt_gnt_22[9],nxt_gnt_21[9],nxt_gnt_20[9],nxt_gnt_19[9],nxt_gnt_18[9],nxt_gnt_17[9],nxt_gnt_16[9],nxt_gnt_15[9],nxt_gnt_14[9],nxt_gnt_13[9],nxt_gnt_12[9],nxt_gnt_11[9],nxt_gnt_10[9],nxt_gnt_9[9],nxt_gnt_8[9],nxt_gnt_7[9],nxt_gnt_6[9],nxt_gnt_5[9],nxt_gnt_4[9],nxt_gnt_3[9],nxt_gnt_2[9],nxt_gnt_1[9],nxt_gnt_0[9]}),
    .gnt(gnt_9)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_10
    (
    .clk(clk),
    .rst(rst_arbiter[10]),
    .req(req_PE_to_Bank_10),
    .nxt_gnt({nxt_gnt_35[10],nxt_gnt_34[10],nxt_gnt_33[10],nxt_gnt_32[10],nxt_gnt_31[10],nxt_gnt_30[10],nxt_gnt_29[10],nxt_gnt_28[10],nxt_gnt_27[10],nxt_gnt_26[10],nxt_gnt_25[10],nxt_gnt_24[10],nxt_gnt_23[10],nxt_gnt_22[10],nxt_gnt_21[10],nxt_gnt_20[10],nxt_gnt_19[10],nxt_gnt_18[10],nxt_gnt_17[10],nxt_gnt_16[10],nxt_gnt_15[10],nxt_gnt_14[10],nxt_gnt_13[10],nxt_gnt_12[10],nxt_gnt_11[10],nxt_gnt_10[10],nxt_gnt_9[10],nxt_gnt_8[10],nxt_gnt_7[10],nxt_gnt_6[10],nxt_gnt_5[10],nxt_gnt_4[10],nxt_gnt_3[10],nxt_gnt_2[10],nxt_gnt_1[10],nxt_gnt_0[10]}),
    .gnt(gnt_10)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_11
    (
    .clk(clk),
    .rst(rst_arbiter[11]),
    .req(req_PE_to_Bank_11),
    .nxt_gnt({nxt_gnt_35[11],nxt_gnt_34[11],nxt_gnt_33[11],nxt_gnt_32[11],nxt_gnt_31[11],nxt_gnt_30[11],nxt_gnt_29[11],nxt_gnt_28[11],nxt_gnt_27[11],nxt_gnt_26[11],nxt_gnt_25[11],nxt_gnt_24[11],nxt_gnt_23[11],nxt_gnt_22[11],nxt_gnt_21[11],nxt_gnt_20[11],nxt_gnt_19[11],nxt_gnt_18[11],nxt_gnt_17[11],nxt_gnt_16[11],nxt_gnt_15[11],nxt_gnt_14[11],nxt_gnt_13[11],nxt_gnt_12[11],nxt_gnt_11[11],nxt_gnt_10[11],nxt_gnt_9[11],nxt_gnt_8[11],nxt_gnt_7[11],nxt_gnt_6[11],nxt_gnt_5[11],nxt_gnt_4[11],nxt_gnt_3[11],nxt_gnt_2[11],nxt_gnt_1[11],nxt_gnt_0[11]}),
    .gnt(gnt_11)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_12
    (
    .clk(clk),
    .rst(rst_arbiter[12]),
    .req(req_PE_to_Bank_12),
    .nxt_gnt({nxt_gnt_35[12],nxt_gnt_34[12],nxt_gnt_33[12],nxt_gnt_32[12],nxt_gnt_31[12],nxt_gnt_30[12],nxt_gnt_29[12],nxt_gnt_28[12],nxt_gnt_27[12],nxt_gnt_26[12],nxt_gnt_25[12],nxt_gnt_24[12],nxt_gnt_23[12],nxt_gnt_22[12],nxt_gnt_21[12],nxt_gnt_20[12],nxt_gnt_19[12],nxt_gnt_18[12],nxt_gnt_17[12],nxt_gnt_16[12],nxt_gnt_15[12],nxt_gnt_14[12],nxt_gnt_13[12],nxt_gnt_12[12],nxt_gnt_11[12],nxt_gnt_10[12],nxt_gnt_9[12],nxt_gnt_8[12],nxt_gnt_7[12],nxt_gnt_6[12],nxt_gnt_5[12],nxt_gnt_4[12],nxt_gnt_3[12],nxt_gnt_2[12],nxt_gnt_1[12],nxt_gnt_0[12]}),
    .gnt(gnt_12)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_13
    (
    .clk(clk),
    .rst(rst_arbiter[13]),
    .req(req_PE_to_Bank_13),
    .nxt_gnt({nxt_gnt_35[13],nxt_gnt_34[13],nxt_gnt_33[13],nxt_gnt_32[13],nxt_gnt_31[13],nxt_gnt_30[13],nxt_gnt_29[13],nxt_gnt_28[13],nxt_gnt_27[13],nxt_gnt_26[13],nxt_gnt_25[13],nxt_gnt_24[13],nxt_gnt_23[13],nxt_gnt_22[13],nxt_gnt_21[13],nxt_gnt_20[13],nxt_gnt_19[13],nxt_gnt_18[13],nxt_gnt_17[13],nxt_gnt_16[13],nxt_gnt_15[13],nxt_gnt_14[13],nxt_gnt_13[13],nxt_gnt_12[13],nxt_gnt_11[13],nxt_gnt_10[13],nxt_gnt_9[13],nxt_gnt_8[13],nxt_gnt_7[13],nxt_gnt_6[13],nxt_gnt_5[13],nxt_gnt_4[13],nxt_gnt_3[13],nxt_gnt_2[13],nxt_gnt_1[13],nxt_gnt_0[13]}),
    .gnt(gnt_13)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_14
    (
    .clk(clk),
    .rst(rst_arbiter[14]),
    .req(req_PE_to_Bank_14),
    .nxt_gnt({nxt_gnt_35[14],nxt_gnt_34[14],nxt_gnt_33[14],nxt_gnt_32[14],nxt_gnt_31[14],nxt_gnt_30[14],nxt_gnt_29[14],nxt_gnt_28[14],nxt_gnt_27[14],nxt_gnt_26[14],nxt_gnt_25[14],nxt_gnt_24[14],nxt_gnt_23[14],nxt_gnt_22[14],nxt_gnt_21[14],nxt_gnt_20[14],nxt_gnt_19[14],nxt_gnt_18[14],nxt_gnt_17[14],nxt_gnt_16[14],nxt_gnt_15[14],nxt_gnt_14[14],nxt_gnt_13[14],nxt_gnt_12[14],nxt_gnt_11[14],nxt_gnt_10[14],nxt_gnt_9[14],nxt_gnt_8[14],nxt_gnt_7[14],nxt_gnt_6[14],nxt_gnt_5[14],nxt_gnt_4[14],nxt_gnt_3[14],nxt_gnt_2[14],nxt_gnt_1[14],nxt_gnt_0[14]}),
    .gnt(gnt_14)
    );

    RR_Arbiter
    #(
    .Req_Width			(PE_NUM		)
    )
    u_RR_Arbiter_15
    (
    .clk(clk),
    .rst(rst_arbiter[15]),
    .req(req_PE_to_Bank_15),
    .nxt_gnt({nxt_gnt_35[15],nxt_gnt_34[15],nxt_gnt_33[15],nxt_gnt_32[15],nxt_gnt_31[15],nxt_gnt_30[15],nxt_gnt_29[15],nxt_gnt_28[15],nxt_gnt_27[15],nxt_gnt_26[15],nxt_gnt_25[15],nxt_gnt_24[15],nxt_gnt_23[15],nxt_gnt_22[15],nxt_gnt_21[15],nxt_gnt_20[15],nxt_gnt_19[15],nxt_gnt_18[15],nxt_gnt_17[15],nxt_gnt_16[15],nxt_gnt_15[15],nxt_gnt_14[15],nxt_gnt_13[15],nxt_gnt_12[15],nxt_gnt_11[15],nxt_gnt_10[15],nxt_gnt_9[15],nxt_gnt_8[15],nxt_gnt_7[15],nxt_gnt_6[15],nxt_gnt_5[15],nxt_gnt_4[15],nxt_gnt_3[15],nxt_gnt_2[15],nxt_gnt_1[15],nxt_gnt_0[15]}),
    .gnt(gnt_15)
    );



endmodule