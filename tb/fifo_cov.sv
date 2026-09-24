class fifo_cov extends uvm_subscriber#(fifo_tx);
fifo_tx tx;
  `uvm_component_utils(fifo_cov)
  covergroup fifo_cg;
     coverpoint tx.wr_en{
	    bins WRITES={1'b1};
	 }
  coverpoint tx.rd_en{
	    bins READS={1'b1};
	 }

  endgroup

  function new(string name="",uvm_component parent);
      super.new(name,parent);
	  fifo_cg=new();
  endfunction
  function void write(fifo_tx t);
     $cast(tx,t);
	 fifo_cg.sample();
  endfunction
endclass
