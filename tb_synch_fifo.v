`timescale  1ns / 1ps      

module tb_synch_fifo;      

    // synch_fifo Parameters   
    parameter PERIOD            = 10            ;
    parameter FIFO_PTR          = 4             ;
    parameter FIFO_WIDTH        = 32            ;
    parameter FIFO_DEPTH        = 16            ;

    // synch_fifo Inputs
    reg                         clk = 0         ;
    reg                         rst_n = 0       ;
    reg                         write_en = 0    ;
    reg [FIFO_WIDTH-1:0]        write_data = 0  ;
    reg                         read_en = 0     ;
	//reg		                    nxt_gnt = 1   ;

    // synch_fifo Outputs
    wire [FIFO_WIDTH-1:0]       read_data       ;
    wire                        full            ;
    wire                        empty           ;
    wire [FIFO_PTR:0]           room_avail      ;
    wire [FIFO_PTR:0]           data_avail      ;
	wire [FIFO_PTR-1:0]         wr_ptr          ;
	wire [FIFO_PTR-1:0]         rd_ptr          ;
	wire [FIFO_PTR:0]           num_entries     ;
	wire [FIFO_PTR-1:0]         wr_ptr_nxt      ;
	wire [FIFO_PTR-1:0]         rd_ptr_nxt      ;
	wire [FIFO_PTR:0]           num_entries_nxt ;
	wire                        req             ;

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
		//read_not_popup_and_write_repeat_fifo();
        //read_after_write(50);
        //repeat(5) @(posedge clk);
        //read_all_after_write_all();
        //repeat(5) @(posedge clk);
		read_and_write_simultaneously();
		//repeat(5) @(posedge clk);
		//initialization();
		//#(PERIOD*10) rst_n  =  1;
		//repeat(5) @(posedge clk);
		
        $finish;
    end

    synch_fifo 
    #(
        .FIFO_PTR               (FIFO_PTR       ),
        .FIFO_WIDTH             (FIFO_WIDTH     ),
        .FIFO_DEPTH             (FIFO_DEPTH     )
    )
    u_synch_fifo 
    (
        .clk                    (clk            ),
        .rst_n                  (rst_n          ),
        .write_en               (write_en       ),
        .write_data             (write_data     ),
        .read_en                (read_en        ),
		//.nxt_gnt                (nxt_gnt        ),
        .read_data              (read_data      ),
        .full                   (full           ),
        .empty                  (empty          ),
        .room_avail             (room_avail     ),
        .data_avail             (data_avail     ),
		.wr_ptr                 (wr_ptr         ),
		.rd_ptr                 (rd_ptr         ),
		.num_entries            (num_entries    ),
		.wr_ptr_nxt             (wr_ptr_nxt     ),
		.rd_ptr_nxt             (rd_ptr_nxt     ),
		.num_entries_nxt        (num_entries_nxt),
		.req					(req			)
    );
    //--------------------------------------------------------------------------
    // read and write simultaneously, but not popup datas sometimes.
    //--------------------------------------------------------------------------
	task read_not_popup_and_write_repeat_fifo;
	reg [31:0]              index           ;
    reg [FIFO_WIDTH-1:0] 	valW		    ;
	begin
		for (index = 0; index < 1; index = index + 1) begin
            valW = $random;
            write_fifo(full,valW);
        end
        for (index = 1; index < 2**FIFO_PTR; index = index + 1) begin
            valW = $random;
            read_and_popup_and_write_fifo(empty,full,valW);
			valW = $random;
			read_not_popup_and_write_fifo(empty,full,valW);
            //read_and_popup_and_write_fifo(empty,full,valW);
            //if (read_data != valC) begin
				//error = error + 1;
            	//$display("status: %t ERROR at Index:0x%08x D:0x%02x, but D:0x%02x expected",$time,index, read_data, valC);
            //end
        end
	end
	endtask

	task read_and_popup_and_write_fifo;
	input					fifo_empty		;
	input					fifo_full		;
	input [FIFO_WIDTH-1:0]  value           ;
	//reg [31:0]              index           ;
    //reg [FIFO_WIDTH-1:0] 	valW		    ;
	begin
		@(posedge clk);
		read_en     <= 1'b1;
		//nxt_gnt     <= 1'b1;
		write_en    <= ~fifo_full;
        write_data  <= value;
	end
	endtask

	task read_not_popup_and_write_fifo;
	input					fifo_empty		;
	input					fifo_full		;
	input [FIFO_WIDTH-1:0]  value           ;
	//reg [31:0]              index           ;
    //reg [FIFO_WIDTH-1:0] 	valW		    ;
	begin
		@(posedge clk);
		read_en     <= 1'b1;
		//nxt_gnt     <= 1'b0;
		write_en    <= ~fifo_full;
        write_data  <= value;
	end
	endtask

    //--------------------------------------------------------------------------
    // read and write simultaneously
    //--------------------------------------------------------------------------
	task read_and_write_simultaneously;
    reg [31:0]              index           ;
    reg [FIFO_WIDTH-1:0] 	valW		    ;
    //reg [FIFO_WIDTH-1:0]    valC            ;
	//integer 		error		;
    begin
        //error = 0;
		
        for (index = 0; index < 1; index = index + 1) begin
            valW = ~(index + 1);
            write_fifo(full,valW);
        end

        for (index = 1; index < 2**FIFO_PTR; index = index + 1) begin
            valW = ~(index + 1);
            read_write_fifo(empty,full,valW);
            //if (read_data != valC) begin
				//error = error + 1;
            	//$display("status: %t ERROR at Index:0x%08x D:0x%02x, but D:0x%02x expected",$time,index, read_data, valC);
            //end
        end
		
        //if (error == 0) 
	    //$display("status: %t read-all-after-write-all test pass", $time);
    end
	endtask
    //--------------------------------------------------------------------------
    // read after write task
    //--------------------------------------------------------------------------
    task read_after_write;
	input [31:0] 	        num_write		; 
	reg [31:0] 		idx			; 
	reg [FIFO_WIDTH-1:0] 	valW			;
	integer                 error			;
    begin
        $display("status: %t total number of write data : %d", $time,num_write);
	error = 0;
	for (idx = 0; idx < num_write; idx = idx + 1) begin
	    valW = $random;
	    write_fifo(full, valW);
	    read_fifo(empty);
	    if (read_data != valW) begin
		error = error + 1;
		$display("status: %t ERROR at idx:0x%08x D:0x%02x, but D:0x%02x expected",$time,
			idx, read_data, valW);
	    end
	end
	if (error == 0) 
	    $display("status: %t read-after-write test pass", $time);
    end
    endtask

    //--------------------------------------------------------------------------
    // read all after write all task, write to fifo until it is full
    //--------------------------------------------------------------------------
    task read_all_after_write_all;
    reg [31:0]              index           ;
    reg [FIFO_WIDTH-1:0] 	valW		    ;
    reg [FIFO_WIDTH-1:0]    valC            ;
	integer 		        error		    ;
    begin
        error = 0;
        for (index = 0; index < 2**FIFO_PTR; index = index + 1) begin
            valW = ~(index + 1);
            write_fifo(full,valW);
        end

        for (index = 1; index < 2**FIFO_PTR; index = index + 1) begin
            valC = ~(index + 1);
            read_fifo(empty);
            if (read_data != valC) begin
		error = error + 1;
                $display("status: %t ERROR at Index:0x%08x D:0x%02x, but D:0x%02x expected",$time,
			index, read_data, valC);
            end
        end

        if (error == 0) 
	    $display("status: %t read-all-after-write-all test pass", $time);
    end
    endtask

    //--------------------------------------------------------------------------
    // write fifo task
    //--------------------------------------------------------------------------
    task write_fifo;
        input                   fifo_full       ;
        input [FIFO_WIDTH-1:0]  value           ;
    begin
		//@(posedge clk);
        write_en    <= ~fifo_full;
        write_data  <= value;
        //#(PERIOD/2)
		@(posedge clk);
        write_en    <= 1'b0;
    end
    endtask

    //--------------------------------------------------------------------------
    // read fifo task
    //--------------------------------------------------------------------------
    task read_fifo;
        input                   fifo_empty      ;
    begin
        //@(posedge clk);
        read_en     <= 1'b1;
        @(posedge clk);
		//#(PERIOD/2)
        read_en     <= 1'b0;
        //@(posedge clk);
    end
    endtask

    //--------------------------------------------------------------------------
    // read and write fifo task
    //--------------------------------------------------------------------------
	task read_write_fifo;
		input					fifo_empty		;
		input					fifo_full		;
		input [FIFO_WIDTH-1:0]  value           ;
	begin
		@(posedge clk);
		write_en    <= ~fifo_full;
        write_data  <= value;
		read_en     <= 1'b1;
		
	end
	endtask

    //--------------------------------------------------------------------------
    // only write fifo task
    //--------------------------------------------------------------------------
	task only_write_fifo;
		//input					fifo_empty		;
		input					fifo_full		;
		input [FIFO_WIDTH-1:0]  value           ;
	begin
		@(posedge clk);
		write_en    <= ~fifo_full;
        write_data  <= value;
		//read_en     <= 1'b1;
		
	end
	endtask

    //--------------------------------------------------------------------------
    // Initialization
    //--------------------------------------------------------------------------
	task initialization;
	begin
		@(posedge clk);
		rst_n <= 0;
	end
	endtask
endmodule
