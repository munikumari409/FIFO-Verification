class wr_agent extends uvm_agent;
   `uvm_component_utils(wr_agent)
   `NEW_CMP
   wr_sqr sqr;
   wr_dvr dvr;
   function void build_phase(uvm_phase phase);
      sqr=wr_sqr::type_id::create("sqr",this);
      dvr=wr_dvr::type_id::create("dvr",this);
   endfunction
   
     function void connect_phase(uvm_phase phase);
         dvr.seq_item_port.connect(sqr.seq_item_export);
     endfunction
 
endclass
