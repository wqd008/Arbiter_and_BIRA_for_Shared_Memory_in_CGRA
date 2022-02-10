`timescale  1ns / 1ps      

module tb_SM_Arbiter;      

    // Shared Memory Arbiters Parameters   
    parameter PERIOD            = 10            ;
    parameter FIFO_PTR          = 4             ;
    parameter FIFO_WIDTH        = 36            ;
    parameter FIFO_DEPTH        = 16            ;
	parameter MEM_BANK_NUM		= 16			;
	parameter PE_NUM            = 36			;
	
    // SM_Arbiter Inputs
    reg                         clk = 0         ;
    reg [PE_NUM-1:0]            rst_fifo = 0    ;
	reg	[MEM_BANK_NUM-1:0]		rst_arbiter = 0	;
    reg [PE_NUM-1:0]            write_en = 0    ;
    reg [PE_NUM-1:0]            read_en = 0     ;

	// Request Datas Definition
	reg [FIFO_WIDTH-1:0]      req_data_0 = 0 	  			 ; // the request data from PE0, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_1 = 0  			     ; // the request data from PE1, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_2 = 0	  			 ; // the request data from PE2, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_3 = 0	  		     ; // the request data from PE3, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_4 = 0 	  		     ; // the request data from PE4, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_5 = 0 	  			 ; // the request data from PE5, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_6 = 0 	  		     ; // the request data from PE6, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_7 = 0 	  		     ; // the request data from PE7, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_8 = 0 	  		     ; // the request data from PE8, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_9 = 0 	  		     ; // the request data from PE9, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_10 = 0 	  	 		 ; // the request data from PE10, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_11 = 0 	  			 ; // the request data from PE11, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_12 = 0 	  			 ; // the request data from PE12, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_13 = 0 	  			 ; // the request data from PE13, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_14 = 0 	  			 ; // the request data from PE14, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_15 = 0 	  			 ; // the request data from PE15, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_16 = 0 	  			 ; // the request data from PE16, each request is 36 bits, where the first 4 bits denotes the address of target bank
	reg [FIFO_WIDTH-1:0]      req_data_17 = 0 	  			 ; // ......
	reg [FIFO_WIDTH-1:0]      req_data_18 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_19 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_20 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_21 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_22 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_23 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_24 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_25 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_26 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_27 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_28 = 0 	  		 	 ;
	reg [FIFO_WIDTH-1:0]      req_data_29 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_30 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_31 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_32 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_33 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_34 = 0 	  			 ;
	reg [FIFO_WIDTH-1:0]      req_data_35 = 0 	  			 ;

    // Shared Memory Arbiters Outputs
	wire [PE_NUM-1:0] 		gnt_0						 ; // the grant result from arbitration of Memory Bank 0
	wire [PE_NUM-1:0] 		gnt_1						 ; // ......
	wire [PE_NUM-1:0] 		gnt_2						 ;
	wire [PE_NUM-1:0] 		gnt_3						 ;
	wire [PE_NUM-1:0] 		gnt_4						 ;
	wire [PE_NUM-1:0] 		gnt_5						 ;
	wire [PE_NUM-1:0] 		gnt_6						 ;
	wire [PE_NUM-1:0] 		gnt_7						 ;
	wire [PE_NUM-1:0] 		gnt_8						 ;
	wire [PE_NUM-1:0] 		gnt_9						 ;
	wire [PE_NUM-1:0] 		gnt_10						 ;
	wire [PE_NUM-1:0] 		gnt_11						 ;
	wire [PE_NUM-1:0] 		gnt_12						 ;
	wire [PE_NUM-1:0] 		gnt_13						 ;
	wire [PE_NUM-1:0] 		gnt_14						 ;
	wire [PE_NUM-1:0] 		gnt_15						 ;  

	// Request data read from FIFOs
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_0		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_1		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_2		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_3	    ;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_4		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_5		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_6		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_7		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_8		;
	wire	[PE_NUM-1:0] 		req_PE_to_Bank_9		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_10		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_11		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_12		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_13		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_14		;
	wire 	[PE_NUM-1:0] 		req_PE_to_Bank_15		;

	// next gnt signals for testing
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_0				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_1				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_2				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_3				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_4				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_5				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_6				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_7				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_8				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_9				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_10				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_11				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_12				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_13				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_14				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_15				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_16				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_17				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_18				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_19				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_20				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_21				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_22				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_23				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_24				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_25				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_26				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_27				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_28				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_29				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_30				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_31				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_32				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_33				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_34				;
	wire 	[MEM_BANK_NUM-1:0]	nxt_gnt_35				;


    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end

    initial
    begin
        $display("\nstatus: %t Testbench started\n\n", $time);
        #(PERIOD*10) rst_fifo  =  {PE_NUM{1'b1}}; rst_arbiter = {MEM_BANK_NUM{1'b1}};
        $display("status: %t done reset", $time);
        repeat(5) @(posedge clk);
		write_req_and_read_req_for_arbiter();
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

    SM_Arbiter 
    #(
        .FIFO_PTR               (FIFO_PTR      	 	),
        .FIFO_WIDTH             (FIFO_WIDTH     	),
        .FIFO_DEPTH             (FIFO_DEPTH    		),
		.MEM_BANK_NUM			(MEM_BANK_NUM		),
		.PE_NUM					(PE_NUM				)
    )
    u_SM_Arbiter 
    (
        .clk                    (clk            	),
        .rst_fifo               (rst_fifo       	),
		.rst_arbiter			(rst_arbiter		),
        .write_en               (write_en       	),
        .read_en                (read_en        	),
		.gnt_0					(gnt_0				),
		.gnt_1					(gnt_1				),
		.gnt_2					(gnt_2				),
		.gnt_3					(gnt_3				),
		.gnt_4					(gnt_4				),
		.gnt_5					(gnt_5				),
		.gnt_6					(gnt_6				),
		.gnt_7					(gnt_7				),
		.gnt_8					(gnt_8				),
		.gnt_9					(gnt_9				),
		.gnt_10					(gnt_10				),
		.gnt_11					(gnt_11				),
		.gnt_12					(gnt_12				),
		.gnt_13					(gnt_13				),
		.gnt_14					(gnt_14				),
		.gnt_15					(gnt_15				),
		.req_data_0				(req_data_0			),
		.req_data_1				(req_data_1			),
		.req_data_2				(req_data_2			),
		.req_data_3				(req_data_3			),
		.req_data_4				(req_data_4			),
		.req_data_5				(req_data_5			),
		.req_data_6				(req_data_6			),
		.req_data_7				(req_data_7			),
		.req_data_8				(req_data_8			),
		.req_data_9				(req_data_9			),
		.req_data_10			(req_data_10		),
		.req_data_11			(req_data_11		),
		.req_data_12			(req_data_12		),
		.req_data_13			(req_data_13		),
		.req_data_14			(req_data_14		),
		.req_data_15			(req_data_15		),
		.req_data_16			(req_data_16		),
		.req_data_17			(req_data_17		),
		.req_data_18			(req_data_18		),
		.req_data_19			(req_data_19		),
		.req_data_20			(req_data_20		),
		.req_data_21			(req_data_21		),
		.req_data_22			(req_data_22		),
		.req_data_23			(req_data_23		),
		.req_data_24			(req_data_24		),
		.req_data_25			(req_data_25		),
		.req_data_26			(req_data_26		),
		.req_data_27			(req_data_27		),
		.req_data_28			(req_data_28		),
		.req_data_29			(req_data_29		),
		.req_data_30			(req_data_30		),
		.req_data_31			(req_data_31		),
		.req_data_32			(req_data_32		),
		.req_data_33			(req_data_33		),
		.req_data_34			(req_data_34		),
		.req_data_35			(req_data_35		),
		.req_PE_to_Bank_0		(req_PE_to_Bank_0	),
		.req_PE_to_Bank_1		(req_PE_to_Bank_1	),
		.req_PE_to_Bank_2		(req_PE_to_Bank_2	),
		.req_PE_to_Bank_3		(req_PE_to_Bank_3	),
		.req_PE_to_Bank_4		(req_PE_to_Bank_4	),
		.req_PE_to_Bank_5		(req_PE_to_Bank_5	),
		.req_PE_to_Bank_6		(req_PE_to_Bank_6	),
		.req_PE_to_Bank_7		(req_PE_to_Bank_7	),
		.req_PE_to_Bank_8		(req_PE_to_Bank_8	),
		.req_PE_to_Bank_9		(req_PE_to_Bank_9	),
		.req_PE_to_Bank_10		(req_PE_to_Bank_10	),
		.req_PE_to_Bank_11		(req_PE_to_Bank_11	),
		.req_PE_to_Bank_12		(req_PE_to_Bank_12	),
		.req_PE_to_Bank_13		(req_PE_to_Bank_13	),
		.req_PE_to_Bank_14		(req_PE_to_Bank_14	),
		.req_PE_to_Bank_15		(req_PE_to_Bank_15	),
		.nxt_gnt_0				(nxt_gnt_0			),
		.nxt_gnt_1				(nxt_gnt_1			),
		.nxt_gnt_2				(nxt_gnt_2			),
		.nxt_gnt_3				(nxt_gnt_3			),
		.nxt_gnt_4				(nxt_gnt_4			),
		.nxt_gnt_5				(nxt_gnt_5			),
		.nxt_gnt_6				(nxt_gnt_6			),
		.nxt_gnt_7				(nxt_gnt_7			),
		.nxt_gnt_8				(nxt_gnt_8			),
		.nxt_gnt_9				(nxt_gnt_9			),
		.nxt_gnt_10				(nxt_gnt_10			),
		.nxt_gnt_11				(nxt_gnt_11			),
		.nxt_gnt_12				(nxt_gnt_12			),
		.nxt_gnt_13				(nxt_gnt_13			),
		.nxt_gnt_14				(nxt_gnt_14			),
		.nxt_gnt_15				(nxt_gnt_15			),
		.nxt_gnt_16				(nxt_gnt_16			),
		.nxt_gnt_17				(nxt_gnt_17			),
		.nxt_gnt_18				(nxt_gnt_18			),
		.nxt_gnt_19				(nxt_gnt_19			),
		.nxt_gnt_20				(nxt_gnt_20			),
		.nxt_gnt_21				(nxt_gnt_21			),
		.nxt_gnt_22				(nxt_gnt_22			),
		.nxt_gnt_23				(nxt_gnt_23			),
		.nxt_gnt_24				(nxt_gnt_24			),
		.nxt_gnt_25				(nxt_gnt_25			),
		.nxt_gnt_26				(nxt_gnt_26			),
		.nxt_gnt_27				(nxt_gnt_27			),
		.nxt_gnt_28				(nxt_gnt_28			),
		.nxt_gnt_29				(nxt_gnt_29			),
		.nxt_gnt_30				(nxt_gnt_30			),
		.nxt_gnt_31				(nxt_gnt_31			),
		.nxt_gnt_32				(nxt_gnt_32			),
		.nxt_gnt_33				(nxt_gnt_33			),
		.nxt_gnt_34				(nxt_gnt_34			),
		.nxt_gnt_35				(nxt_gnt_35			)
	
    );
    //--------------------------------------------------------------------------
    // write some requests data first, then read out for arbiters.
    //--------------------------------------------------------------------------
	task write_req_and_read_req_for_arbiter;
	reg [31:0]				index			;
	reg [FIFO_WIDTH-1:0] 	valW_0		    ;
	reg [FIFO_WIDTH-1:0] 	valW_1		    ;
	reg [FIFO_WIDTH-1:0] 	valW_2		    ;
	reg [FIFO_WIDTH-1:0] 	valW_3		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_4		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_5		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_6		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_7		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_8		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_9		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_10		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_11		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_12		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_13		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_14		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_15		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_16		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_17		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_18		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_19		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_20		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_21		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_22		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_23		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_24		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_25		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_26		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_27		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_28		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_29		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_30		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_31		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_32		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_33		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_34		    ;
//	reg [FIFO_WIDTH-1:0] 	valW_35		    ;
	begin
		//write the all request datas at first
		for (index = 0; index < 5; index = index + 1) begin
			// Randomize the reqeust data
            valW_0  = {4'b0010,$random};
			valW_1  = {4'b0010,$random};
			valW_2  = {4'b0010,$random};
			valW_3  = {4'b0010,$random};
//			valW_4  = $random;
//			valW_5  = $random;
//			valW_6  = $random;
//			valW_7  = $random;
//			valW_8  = $random;
//			valW_9  = $random;
//			valW_10 = $random;
//			valW_11 = $random;
//			valW_12 = $random;
//			valW_13 = $random;
//			valW_14 = $random;
//			valW_15 = $random;
//			valW_16 = $random;
//			valW_17 = $random;
//			valW_18 = $random;
//			valW_19 = $random;
//			valW_20 = $random;
//			valW_21 = $random;
//			valW_22 = $random;
//			valW_23 = $random;
//			valW_24 = $random;
//			valW_25 = $random;
//			valW_26 = $random;
//			valW_27 = $random;
//			valW_28 = $random;
//			valW_29 = $random;
//			valW_30 = $random;
//			valW_31 = $random;
//			valW_32 = $random;
//			valW_33 = $random;
//			valW_34 = $random;
//			valW_35 = $random;
//          only_write_fifo(valW_0,valW_1,valW_2,valW_3,valW_4,valW_5,valW_6,valW_7,valW_8,valW_9,valW_10,valW_11,valW_12,valW_13,valW_14,valW_15,valW_16,valW_17,valW_18,valW_19,valW_20,valW_21,valW_22,valW_23,valW_24,valW_25,valW_26,valW_27,valW_28,valW_29,valW_30,valW_31,valW_32,valW_33,valW_34,valW_35);
			only_write_fifo(valW_0,valW_1,valW_2,valW_3);
        end
		// Read the all requests for arbitration
		for (index = 0; index < 5; index = index + 1) begin
			only_read_fifo();
		end
	end
	endtask



    //--------------------------------------------------------------------------
    // only write fifo task
    //--------------------------------------------------------------------------
	task only_write_fifo;
		//input					fifo_empty		;
		//input					fifo_full		;
		input [FIFO_WIDTH-1:0] 	valW_0		    ;
		input [FIFO_WIDTH-1:0] 	valW_1		    ;
		input [FIFO_WIDTH-1:0] 	valW_2		    ;
		input [FIFO_WIDTH-1:0] 	valW_3		    ;
//		input [FIFO_WIDTH-1:0] 	valW_4		    ;
//		input [FIFO_WIDTH-1:0] 	valW_5		    ;
//		input [FIFO_WIDTH-1:0] 	valW_6		    ;
//		input [FIFO_WIDTH-1:0] 	valW_7		    ;
//		input [FIFO_WIDTH-1:0] 	valW_8		    ;
//		input [FIFO_WIDTH-1:0] 	valW_9		    ;
//		input [FIFO_WIDTH-1:0] 	valW_10		    ;
//		input [FIFO_WIDTH-1:0] 	valW_11		    ;
//		input [FIFO_WIDTH-1:0] 	valW_12		    ;
//		input [FIFO_WIDTH-1:0] 	valW_13		    ;
//		input [FIFO_WIDTH-1:0] 	valW_14		    ;
//		input [FIFO_WIDTH-1:0] 	valW_15		    ;
//		input [FIFO_WIDTH-1:0] 	valW_16		    ;
//		input [FIFO_WIDTH-1:0] 	valW_17		    ;
//		input [FIFO_WIDTH-1:0] 	valW_18		    ;
//		input [FIFO_WIDTH-1:0] 	valW_19		    ;
//		input [FIFO_WIDTH-1:0] 	valW_20		    ;
//		input [FIFO_WIDTH-1:0] 	valW_21		    ;
//		input [FIFO_WIDTH-1:0] 	valW_22		    ;
//		input [FIFO_WIDTH-1:0] 	valW_23		    ;
//		input [FIFO_WIDTH-1:0] 	valW_24		    ;
//		input [FIFO_WIDTH-1:0] 	valW_25		    ;
//		input [FIFO_WIDTH-1:0] 	valW_26		    ;
//		input [FIFO_WIDTH-1:0] 	valW_27		    ;
//		input [FIFO_WIDTH-1:0] 	valW_28		    ;
//		input [FIFO_WIDTH-1:0] 	valW_29		    ;
//		input [FIFO_WIDTH-1:0] 	valW_30		    ;
//		input [FIFO_WIDTH-1:0] 	valW_31		    ;
//		input [FIFO_WIDTH-1:0] 	valW_32		    ;
//		input [FIFO_WIDTH-1:0] 	valW_33		    ;
//		input [FIFO_WIDTH-1:0] 	valW_34		    ;
//		input [FIFO_WIDTH-1:0] 	valW_35		    ;
	begin
		@(posedge clk);
		//write_en    <= {PE_NUM{1'b1}};
		write_en	<= {{32{1'b0}},4'b1111};
        //write_data  <= value;
		//read_en     <= 1'b1;
		req_data_0	<= valW_0;
		req_data_1	<= valW_1;
		req_data_2	<= valW_2;
		req_data_3	<= valW_3;
//		req_data_4	<= valW_4;
//		req_data_5	<= valW_5;
//		req_data_6	<= valW_6;
//		req_data_7	<= valW_7;
//		req_data_8	<= valW_8;
//		req_data_9	<= valW_9;
//		req_data_10	<= valW_10;
//		req_data_11	<= valW_11;
//		req_data_12	<= valW_12;
//		req_data_13	<= valW_13;
//		req_data_14	<= valW_14;
//		req_data_15	<= valW_15;
//		req_data_16	<= valW_16;
//		req_data_17	<= valW_17;
//		req_data_18	<= valW_18;
//		req_data_19	<= valW_19;
//		req_data_20	<= valW_20;
//		req_data_21	<= valW_21;
//		req_data_22	<= valW_22;
//		req_data_23	<= valW_23;
//		req_data_24	<= valW_24;
//		req_data_25	<= valW_25;
//		req_data_26	<= valW_26;
//		req_data_27	<= valW_27;
//		req_data_28	<= valW_28;
//		req_data_29	<= valW_29;
//		req_data_30	<= valW_30;
//		req_data_31	<= valW_31;
//		req_data_32	<= valW_32;
//		req_data_33	<= valW_33;
//		req_data_34	<= valW_34;
//		req_data_35	<= valW_35;
		
	end
	endtask

    //--------------------------------------------------------------------------
    // only read fifo task
    //--------------------------------------------------------------------------
	task only_read_fifo;
		//input					fifo_empty		;
		//input					fifo_full		;

	begin
		@(posedge clk);
		write_en    <= {PE_NUM{1'b0}};
		read_en   	<= {PE_NUM{1'b1}};
        //write_data  <= value;
		//read_en     <= 1'b1
		
	end
	endtask

endmodule
