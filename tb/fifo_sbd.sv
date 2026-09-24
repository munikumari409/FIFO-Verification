class fifo_sbd extends uvm_scoreboard;

  fifo_tx tx;
  uvm_analysis_imp #(fifo_tx,fifo_sbd) ap_imp;

  int num_matches, miss_matches;

  bit [`WIDTH-1:0] dataQ[$];
  bit [`WIDTH-1:0] exp_data;

  `uvm_component_utils(fifo_sbd)
  `NEW_CMP

  function void build();
    super.build();
    ap_imp = new("ap_imp", this);
  endfunction


  function void write(fifo_tx t);

    // WRITE transaction
    if(t.wr_en) begin
      dataQ.push_back(t.wdata);

      `uvm_info("SBD",
      $sformatf("WRITE stored=%0d queue_size=%0d",
      t.wdata,dataQ.size()), UVM_LOW)
    end

    // READ transaction
    if(t.rd_en) begin

      if(dataQ.size() > 0) begin
        exp_data = dataQ.pop_front();

        if(exp_data == t.rdata) begin
          num_matches++;
          `uvm_info("SBD",
          $sformatf("MATCH exp=%0d got=%0d",exp_data,t.rdata),
          UVM_LOW)
        end
        else begin
          miss_matches++;
          `uvm_error("SBD",
          $sformatf("MISMATCH exp=%0d got=%0d",exp_data,t.rdata))
        end
      end
      else begin
        `uvm_warning("SBD","Read happened when expected queue empty")
      end

    end

  endfunction

endclass
