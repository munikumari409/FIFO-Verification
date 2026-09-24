class rd_dvr extends uvm_driver #(fifo_tx);

  fifo_tx req;
  virtual fifo_intrf vif;

  `uvm_component_utils(rd_dvr)
  `NEW_CMP

  function void build();
    super.build();
    if(!uvm_config_db#(virtual fifo_intrf)::get(this,"","vif",vif))
      `uvm_fatal("VIF","Interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    wait(vif.rst==0);
    forever begin
      seq_item_port.get_next_item(req);
      drive_tx(req);
	  seq_item_port.item_done();
	   repeat(req.rd_dly)
        @(vif.rd_dvr_cb);
    end
  endtask


  task drive_tx(fifo_tx tx);

    @(vif.rd_dvr_cb);
    vif.rd_dvr_cb.rd_en<=1;

    @(vif.rd_dvr_cb);   // wait one clock

    if(tx.rd_en)
      tx.rdata<=vif.rd_dvr_cb.rdata;
    else
      tx.rdata<=0;

    vif.rd_dvr_cb.rd_en<=0;

  endtask

endclass
