module async_fifo(wr_clk,rd_clk,rst,wr_en,rd_en,wdata,rdata,full,overflow,empty,underflow);
     input wr_clk,rd_clk,rst,wr_en,rd_en;
	 input [`WIDTH-1:0]wdata;
	 output reg [`WIDTH-1:0]rdata;
	 output reg full,overflow,empty,underflow;

	 reg[`WIDTH-1:0]fifo[`FIFO_SIZE-1:0];
     integer i;
     reg [`PTR_WIDTH-1:0]wr_ptr,rd_ptr,wr_ptr_rd_clk,rd_ptr_wr_clk;
	 reg wr_tgl_f,rd_tgl_f,wr_tgl_f_rd_clk,rd_tgl_f_wr_clk;

	 always@(posedge wr_clk)begin
	      if(rst==1)begin
		       rdata=0;
			   full=0;
			   overflow=0;
			   empty=0;
			   underflow=0;
			   wr_ptr=0;
			   rd_ptr=0;
			   wr_ptr_rd_clk=0;
			   rd_ptr_wr_clk=0;
			   wr_tgl_f=0;
			   rd_tgl_f=0;
			   wr_tgl_f_rd_clk=0;
			   rd_tgl_f_wr_clk=0;

			   for(i=0;i<`FIFO_SIZE-1;i=i+1) fifo[i]=0;
		  end
		  if(wr_en==1)begin
		      if(full==1) overflow=1;
			  else begin
			      fifo[wr_ptr]=wdata;
				  if(wr_ptr==`FIFO_SIZE-1) wr_tgl_f=~wr_tgl_f;
				  else wr_ptr=wr_ptr+1;
			  end
		  end
	 end
	 always@(posedge rd_clk)begin
	     if(rd_en==1)begin
		       if(empty==1) underflow=1;
			   else begin
			       rdata=fifo[rd_ptr];
				   if(rd_ptr==`FIFO_SIZE-1) rd_tgl_f=~rd_tgl_f;
				   else rd_ptr=rd_ptr+1;
			   end
		 end
	 end

	 always@(posedge wr_clk)begin
	     rd_ptr_wr_clk=rd_ptr;
		 rd_tgl_f_wr_clk=rd_tgl_f;
	 end

     always@(posedge rd_clk)begin
	     wr_ptr_rd_clk=wr_ptr;
		 wr_tgl_f_rd_clk=wr_tgl_f;
	 end

	 always@(*)begin
	     if(wr_ptr==rd_ptr_wr_clk && wr_tgl_f==rd_tgl_f_wr_clk) empty=1;
		 else empty=0;
		 if(rd_ptr==wr_ptr_rd_clk && rd_tgl_f!=wr_tgl_f_rd_clk) full=1;
		 else full=0;
	 end

endmodule
