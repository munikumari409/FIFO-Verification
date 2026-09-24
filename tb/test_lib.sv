class fifo_base_test extends uvm_test;
  int num_matches;
  int miss_matches;
   `uvm_component_utils(fifo_base_test)
   `NEW_CMP
   fifo_env env;
   function void build();
     super.build();
	 env=fifo_env::type_id::create("env",this);
   endfunction

   function void end_of_elaboration();
     uvm_top.print_topology();
   endfunction

function void report();

  num_matches  = env.sbd.num_matches;
  miss_matches = env.sbd.miss_matches;

  if(miss_matches == 0)
    `uvm_info("STATUS",
      $sformatf("%s PASS matches=%0d mismatches=%0d",
      get_type_name(), num_matches, miss_matches), UVM_NONE)
  else
    `uvm_error("STATUS",
      $sformatf("%s FAIL matches=%0d mismatches=%0d",
      get_type_name(), num_matches, miss_matches))
endfunction
endclass

class fifo_wr_rd_test extends fifo_base_test;
   `uvm_component_utils(fifo_wr_rd_test)
   `NEW_CMP
    fifo_wr_seq wr_seq;
    fifo_rd_seq rd_seq;
    task run_phase(uvm_phase phase);
	   wr_seq=fifo_wr_seq::type_id::create("wr_seq");
       rd_seq=fifo_rd_seq::type_id::create("rd_seq");

	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	   wr_seq.wr_count=10;
	   wr_seq.start(env.w_agent.sqr);
       rd_seq.rd_count=10;
	   rd_seq.start(env.r_agent.sqr);
	   phase.drop_objection(this);
   endtask
endclass

class fifo_underflow_test extends fifo_base_test;
   `uvm_component_utils(fifo_underflow_test)
   `NEW_CMP
    fifo_wr_seq wr_seq;
    fifo_rd_seq rd_seq;
    task run_phase(uvm_phase phase);
	   wr_seq=fifo_wr_seq::type_id::create("wr_seq");
       rd_seq=fifo_rd_seq::type_id::create("rd_seq");
	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	   wr_seq.wr_count=16;
	   wr_seq.start(env.w_agent.sqr);
       rd_seq.rd_count=16+1;
	   rd_seq.start(env.r_agent.sqr);
	   phase.drop_objection(this);
   endtask
endclass

class fifo_overflow_test extends fifo_base_test;
   `uvm_component_utils(fifo_overflow_test)
   `NEW_CMP
    fifo_wr_seq wr_seq;
	fifo_rd_seq rd_seq;
	task run_phase(uvm_phase phase);
	   wr_seq=fifo_wr_seq::type_id::create("wr_seq");
       rd_seq=fifo_rd_seq::type_id::create("rd_seq");

	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	   wr_seq.wr_count=16+1;
	   wr_seq.start(env.w_agent.sqr);
       rd_seq.rd_count=16;
	   rd_seq.start(env.r_agent.sqr);
	   phase.drop_objection(this);
   endtask
endclass


class fifo_wr_rd_dly_test extends fifo_base_test;
   `uvm_component_utils(fifo_wr_rd_dly_test)
   `NEW_CMP
    fifo_wr_dly_seq wr_seq;
    fifo_rd_dly_seq rd_seq;
    task run_phase(uvm_phase phase);
	   wr_seq=fifo_wr_dly_seq::type_id::create("wr_seq");
       rd_seq=fifo_rd_dly_seq::type_id::create("rd_seq");

	   phase.raise_objection(this);
	   phase.phase_done.set_drain_time(this,100);
	   wr_seq.wr_count=16;
	   wr_seq.start(env.w_agent.sqr);
       rd_seq.rd_count=16;
	   rd_seq.start(env.r_agent.sqr);
	   phase.drop_objection(this);
   endtask
endclass



