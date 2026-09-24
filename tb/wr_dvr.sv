class wr_dvr extends uvm_driver #(fifo_tx);

  fifo_tx req;
  virtual fifo_intrf vif;

  `uvm_component_utils(wr_dvr)
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
	  repeat(req.wr_dly)
        @(vif.wr_dvr_cb);

    end
  endtask

  task drive_tx(fifo_tx tx);
    @(vif.wr_dvr_cb);
    vif.wr_dvr_cb.wdata <= tx.wdata;
    vif.wr_dvr_cb.wr_en <= tx.wr_en;

    @(vif.wr_dvr_cb);
    vif.wr_dvr_cb.wr_en <= 0;
    vif.wr_dvr_cb.wdata <= 0;
  endtask

endclass
