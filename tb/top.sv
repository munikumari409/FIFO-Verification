`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "fifo_cmn.sv"
`include "fifo.v"
`include "fifo_intrf.sv"
`include "fifo_tx.sv"
`include "wr_dvr.sv"
`include "rd_dvr.sv"
`include "wr_sqr.sv"
`include "rd_sqr.sv"
`include "fifo_mon.sv"
`include "fifo_cov.sv"
`include "fifo_sbd.sv"
`include "wr_agent.sv"
`include "rd_agent.sv"
`include "fifo_env.sv"
`include "seq_lib.sv"
`include "test_lib.sv"
module top;
  bit wr_clk,rd_clk,rst;
initial begin
  wr_clk=0;
  forever #5 wr_clk=~wr_clk;
end
initial begin
  rd_clk=0;
  forever #7 rd_clk=~rd_clk;
end

  fifo_intrf pif(wr_clk,rd_clk,rst);

  async_fifo dut(.wr_clk(pif.wr_clk),
                 .rd_clk(pif.rd_clk),
				 .rst(pif.rst),
				 .wr_en(pif.wr_en),
				 .rd_en(pif.rd_en),
				 .wdata(pif.wdata),
				 .rdata(pif.rdata),
				 .full(pif.full),
				 .overflow(pif.overflow),
				 .empty(pif.empty),
				 .underflow(pif.underflow));

  initial begin
    rst=1;
	repeat(2)@(posedge wr_clk);
    pif.wr_en=0;
	pif.rd_en=0;
	pif.wdata=0;
	rst=0;
  end
 initial begin
  uvm_config_db#(virtual fifo_intrf)::set(null, "*", "vif", pif);
end
  initial begin
     run_test("fifo_wr_rd_dly_test");
  end
  initial begin
     $dumpfile("fifo.vcd");
	 $dumpvars;
  end
endmodule
