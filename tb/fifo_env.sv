class fifo_env extends uvm_env;
	 `uvm_component_utils(fifo_env)
	 `NEW_CMP
	 wr_agent w_agent;
	 rd_agent r_agent;
	 fifo_mon mon;
	 fifo_sbd sbd;
	 fifo_cov cov;
	 function void build();
	     super.build();
	      w_agent=wr_agent::type_id::create("w_agent",this);
          r_agent=rd_agent::type_id::create("r_agent",this);
		  mon=fifo_mon::type_id::create("mon",this);
          sbd=fifo_sbd::type_id::create("sbd",this);
          cov=fifo_cov::type_id::create("cov",this);
	 endfunction
     function void connect();
	     super.connect();
	     mon.mon_ap_h.connect(sbd.ap_imp);
         mon.mon_ap_h.connect(cov.analysis_export);
     endfunction
endclass
