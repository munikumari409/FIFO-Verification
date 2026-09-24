interface fifo_intrf(input logic wr_clk,rd_clk,rst);
    logic wr_en;
	logic [`WIDTH-1:0]wdata;
	logic full,overflow;
   
    logic rd_en;
	logic [`WIDTH-1:0]rdata;
	logic empty,underflow;

	clocking wr_dvr_cb @(posedge wr_clk);
	    default input #0 output #1;
		input full,overflow;
		output wr_en,wdata;
	endclocking
    clocking rd_dvr_cb @(posedge rd_clk);
	    default input #0 output #1;
		input empty,underflow,rdata;
		output rd_en;
	endclocking
    clocking wr_mon_cb @(posedge wr_clk);
	    default input #1;
		input wr_en,wdata,full,overflow;
	endclocking
	 clocking rd_mon_cb @(posedge rd_clk);
	    default input #1;
		input rd_en,rdata,empty,underflow;
	endclocking

endinterface
