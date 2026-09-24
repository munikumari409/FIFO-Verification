class fifo_tx extends uvm_sequence_item;
  //typedef enum{WRITE,READ} op_t;
  rand bit[`WIDTH-1:0]wdata;
       bit[`WIDTH-1:0]rdata;
  rand bit wr_en,rd_en;
  rand bit [3:0]wr_dly,rd_dly;
  //op_t op;
     `uvm_object_utils_begin(fifo_tx)
	    `uvm_field_int(wr_en,UVM_ALL_ON|UVM_DEC)
	    `uvm_field_int(wdata,UVM_ALL_ON |UVM_DEC)
	    `uvm_field_int(rd_en,UVM_ALL_ON|UVM_DEC)

        `uvm_field_int(rdata,UVM_ALL_ON|UVM_DEC)

        `uvm_field_int(wr_dly,UVM_ALL_ON|UVM_DEC)
        `uvm_field_int(rd_dly,UVM_ALL_ON|UVM_DEC)

     `uvm_object_utils_end
     `NEW_OBJ
	 constraint dly_c{
        soft wr_dly==0;
		soft rd_dly==0;
	 }
 endclass
