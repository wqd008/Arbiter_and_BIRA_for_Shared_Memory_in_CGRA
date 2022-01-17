`timescale 1ns / 1ps

module synch_fifo
#(
    //----------------------------------
    // Parameter Declarations
    //----------------------------------
    parameter FIFO_PTR              = 4             , // the corresponding address of each word in fifo
    parameter FIFO_WIDTH            = 36            , // the width of each word in fifo (the upper four bits denote the target bank, the rest denotes the data)
    parameter FIFO_DEPTH            = 16            , // the total room a fifo could store
	parameter MEM_BANK_NUM			= 16			  // the number of the memory banks
)
(
    //----------------------------------
    // IO Declarations
    //----------------------------------
    input                           clk             ,
    input                           rst_n           ,
    input                           write_en        ,
    input [FIFO_WIDTH-1:0]          write_data      ,
    input                           read_en         ,
	input                           nxt_gnt         ,// the signal nxt_grant is high when the fifo wins the arbitration.
    output reg [FIFO_WIDTH-1:0]     read_data       ,
    output reg                      full            ,
    output reg                      empty           ,
    output reg [FIFO_PTR:0]         room_avail      ,
    output [FIFO_PTR:0]             data_avail  	,
	output reg [FIFO_PTR-1:0]       wr_ptr          ,// only for testing
	output reg [FIFO_PTR-1:0]       rd_ptr          ,// only for testing
	output reg [FIFO_PTR:0]         num_entries     ,
	output reg [FIFO_PTR-1:0]       wr_ptr_nxt      ,
	output reg [FIFO_PTR-1:0]       rd_ptr_nxt      ,
	output reg [FIFO_PTR:0]         num_entries_nxt ,
	output reg [MEM_BANK_NUM-1:0]   req_pea_to_bank 
);

    //----------------------------------
    // Local Parameter Declarations
    //----------------------------------
    localparam FIFO_DEPTH_MINUS1    = FIFO_DEPTH-1  ;
	reg [FIFO_WIDTH-1:0] 		memory[FIFO_DEPTH-1:0];
    //----------------------------------
    // Variable Declarations
    //----------------------------------
    //reg [FIFO_PTR-1:0]              wr_ptr          ;
    //reg [FIFO_PTR-1:0]              wr_ptr_nxt      ;

    //reg [FIFO_PTR-1:0]              rd_ptr          ;
    //reg [FIFO_PTR-1:0]              rd_ptr_nxt      ;

    //reg [FIFO_PTR:0]                num_entries     ;
    //reg [FIFO_PTR:0]                num_entries_nxt ;

    wire                            full_nxt        ;
    wire                            empty_nxt       ;

    wire [FIFO_PTR:0]               room_avail_nxt  ;
	wire [3:0]						req_addr		;

    //--------------------------------------------------------------------------
    // write-pointer control logic
    //--------------------------------------------------------------------------
    always @(*)
    begin 
        wr_ptr_nxt = wr_ptr;
        
        if (write_en) begin
            if (wr_ptr == FIFO_DEPTH_MINUS1)
                wr_ptr_nxt = 'd0;
            else
                wr_ptr_nxt = wr_ptr + 1'b1;
        end
    end 

    //--------------------------------------------------------------------------
    // read-pointer control logic
    //--------------------------------------------------------------------------
    always @(*)
    begin 
        rd_ptr_nxt = rd_ptr;
        
        if (read_en && nxt_gnt) begin
            if (rd_ptr == FIFO_DEPTH_MINUS1)
                rd_ptr_nxt = 'd0;
            else
                rd_ptr_nxt = rd_ptr + 1'b1;
        end
    end 

    //--------------------------------------------------------------------------
    // calculate number of occupied entries in the FIFO
    //--------------------------------------------------------------------------
    always @(*)
    begin
        num_entries_nxt = num_entries;

        if (write_en && read_en && nxt_gnt)                       //read and write simultaneously, the rest number is not change
            num_entries_nxt = num_entries;
        else if (write_en)                             //only write, plus 1
            num_entries_nxt = num_entries + 1'b1;
        else if (read_en && nxt_gnt)                              //only read, substract 1
            num_entries_nxt = num_entries - 1'b1;
    end

    assign full_nxt         = (num_entries_nxt == FIFO_DEPTH);
    assign empty_nxt        = (num_entries_nxt == 'd0);
    assign data_avail       = num_entries;
    assign room_avail_nxt   = (FIFO_DEPTH - num_entries_nxt);
	assign req_addr         =  read_data[35:32];// getting the address of the target memory bank

    //--------------------------------------------------------------------------
    // register output
    //--------------------------------------------------------------------------
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) begin
            wr_ptr      <= 'd0;
            rd_ptr      <= 'd0;
            num_entries <= 'd0;
            full        <= 1'b0;
            empty       <= 1'b1;
			req_pea_to_bank	<= {MEM_BANK_NUM{1'b0}};
            room_avail  <= FIFO_DEPTH;
        end
        else begin
			wr_ptr      <= wr_ptr_nxt;
            rd_ptr      <= rd_ptr_nxt;
            num_entries <= num_entries_nxt;
            full        <= full_nxt;
            empty       <= empty_nxt;
			req_pea_to_bank[req_addr]	<= ~empty_nxt;		// the req corresponding to the bank is high
            room_avail  <= room_avail_nxt;
			read_data	<= (read_en ? memory[rd_ptr_nxt] : memory[rd_ptr]);// can fasten one clock for the read process
			if (write_en) begin
				memory[wr_ptr] <= write_data;
        	end
			//if (read_en) begin
				//read_data   <= memory[rd_ptr];
			//end
        end
		// write data to memory
//        if (write_en) begin
//	    	memory[wr_ptr] <= write_data;	
//		end

    	// Read data from memory
//    	if (read_en) begin
//	    	read_data <= memory[rd_ptr];
//		end
    
    end 

    //--------------------------------------------------------------------------
    // SRAM memory instantiation
    //--------------------------------------------------------------------------
//    sram
//    #(
//	.PTR			(FIFO_PTR		),
//	.FIFO_WIDTH		(FIFO_WIDTH		)
//    )
//    u_sram
//    (
//	.wrclk			(clk			),
//	.wren			(write_en		),
//	.wrptr			(wr_ptr			),
//	.wrdata			(write_data		),
//	.rdclk			(clk			),
//	.rden			(read_en		),
//	.rdptr			(rd_ptr			),
//	.rddata			(read_data		)
//    );

endmodule

`timescale 1ns / 1ps

module sram
#(
    //----------------------------------
    // Paramter Declarations
    //----------------------------------
    parameter PTR 			= 4			,
    parameter FIFO_WIDTH		= 16			,
    parameter A_MAX 			= 2**(PTR)
)
(
    //----------------------------------
    // IO Declarations
    //----------------------------------
    // Write port
    input                		wrclk			,
    input [PTR-1:0] 			wrptr			,
    input [FIFO_WIDTH-1:0] 		wrdata			,
    input                		wren			,

    // Read port
    input           			rdclk   		,
    input [PTR-1:0] 			rdptr			,
    input                		rden			,
    output reg [FIFO_WIDTH-1:0]         rddata			
);

    //----------------------------------
    // Variable Declarations
    //----------------------------------
    // Memory as multi-dimensional array
    reg [FIFO_WIDTH-1:0] 		memory[A_MAX-1:0];
	
    //----------------------------------
    // Start of Main Code
    //----------------------------------
	
    // Write data to memory
    always @(posedge wrclk) 
    begin
        if (wren) begin
	    memory[wrptr] <= wrdata;	
	end
    end

    // Read data from memory
    always @(posedge rdclk) 
    begin
	if (rden) begin
	    rddata <= memory[rdptr];
	end
    end
	
endmodule
