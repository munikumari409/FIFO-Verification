class fifo_mon extends uvm_monitor;

 fifo_tx tx;
 uvm_analysis_port #(fifo_tx) mon_ap_h;
 virtual fifo_intrf vif;

 `uvm_component_utils(fifo_mon)
 `NEW_CMP

 function void build();
   super.build();
   mon_ap_h = new("mon_ap_h", this);

   if(!uvm_config_db#(virtual fifo_intrf)::get(this,"","vif",vif))
      `uvm_fatal("VIF","Interface not found")
 endfunction


 task run_phase(uvm_phase phase);

   wait(vif.rst==0);

   fork

     forever begin
       @(vif.wr_mon_cb);
       if(vif.wr_mon_cb.wr_en) begin
         tx=fifo_tx::type_id::create("tx");
         tx.wr_en=1;
         tx.rd_en=0;
         tx.wdata=vif.wr_mon_cb.wdata;
         mon_ap_h.write(tx);
       end
     end

    forever begin
      @(vif.rd_mon_cb);
      if(vif.rd_mon_cb.rd_en) begin
         tx=fifo_tx::type_id::create("tx");
         @(vif.rd_mon_cb);   // wait next read clock
          tx.rd_en=1;
          tx.rdata=vif.rd_mon_cb.rdata;
          mon_ap_h.write(tx);
      end
    end
  join

 endtask

endclass
