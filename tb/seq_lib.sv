class fifo_base_seq extends uvm_sequence#(fifo_tx);;
fifo_tx req;
  `uvm_object_utils(fifo_base_seq)
  `NEW_OBJ
   uvm_phase phase;
   task pre_body();
      phase=get_starting_phase();
	  if(phase!=null)begin
	     phase.raise_objection(this);
		 phase.phase_done.set_drain_time(this,100);
	  end
   endtask

  task post_body();

	  if(phase!=null)begin
	     phase.drop_objection(this);
	  end
   endtask

endclass
class fifo_wr_seq extends fifo_base_seq;
  `uvm_object_utils(fifo_wr_seq)
  `NEW_OBJ
  rand int wr_count;
  task body();
     repeat(wr_count) begin
         `uvm_do_with(req,{req.wr_en==1;
                           req.rd_en==0;})
     end
  endtask
  
endclass
class fifo_rd_seq extends fifo_base_seq;
  `uvm_object_utils(fifo_rd_seq)
  `NEW_OBJ
   rand int rd_count;

   task body();
     repeat(rd_count) begin
       `uvm_do_with(req,{req.rd_en==1;
                         req.wr_en==0;})
     end
endtask
  
endclass

class fifo_wr_dly_seq extends fifo_base_seq;
  `uvm_object_utils(fifo_wr_dly_seq)
  `NEW_OBJ
   rand int wr_count;

   task body();
      repeat(wr_count)begin
       `uvm_do_with(req,{req.wr_en==1;
                         req.rd_en==0;
	                     req.wr_dly inside {[1:15]};})
	  end
   endtask

  
endclass
class fifo_rd_dly_seq extends fifo_base_seq;
  `uvm_object_utils(fifo_rd_dly_seq)
  `NEW_OBJ
  
   rand int rd_count;

   task body();
      repeat(rd_count)begin
       `uvm_do_with(req,{req.rd_en==1;
                         req.wr_en==0;
	                     req.rd_dly inside {[1:15]};})
	  end
   endtask

  
endclass
