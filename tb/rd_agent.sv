class rd_agent extends uvm_agent;
   `uvm_component_utils(rd_agent)
   `NEW_CMP
   rd_sqr sqr;
   rd_dvr dvr;
   function void build_phase(uvm_phase phase);
      sqr=rd_sqr::type_id::create("sqr",this);
      dvr=rd_dvr::type_id::create("dvr",this);
   endfunction
   
     function void connect_phase(uvm_phase phase);
         dvr.seq_item_port.connect(sqr.seq_item_export);
     endfunction
 
endclass
