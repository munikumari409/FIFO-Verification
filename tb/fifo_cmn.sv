`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)

`define NEW_CMP\
function new(string name="",uvm_component parent);\
    super.new(name,parent);\
endfunction

`define NEW_OBJ\
function new(string name="");\
    super.new(name);\
endfunction

