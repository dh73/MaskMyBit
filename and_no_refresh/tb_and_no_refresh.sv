`timescale 1ns/1ps
`default_nettype none
module tb_and_no_refresh;
   logic clk, rstn;
   logic a0, a1;
   logic b0, b1;
   logic r;
   logic x0, x1;

   logic [3:0] idx;

   initial begin
      $dumpfile("trace.vcd");
      $dumpvars(0, tb_and_no_refresh);
      {clk, rstn, a0, a1, b0, b1, r} = 7'h0;
      #15 rstn = 1'b1;
      for(idx = 0; idx <= 4'he; idx++) begin
	 {a0, a1, b0, b1} = idx;
	 #5;
      end
      #100 $finish();
   end

   always #5 clk++;
   and_no_refresh uut (clk, rstn, a0, a1, b0, b1, r, x0, x1);
endmodule // tb_and_no_refresh
`default_nettype wire
