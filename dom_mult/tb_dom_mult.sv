`timescale 1ns/1ps
`default_nettype none
module tb_dom_mult;
   logic clk, rstn;
   logic Ax, Ay;
   logic Bx, By;
   logic Z0;
   logic Aq, Bq;
   
   logic [3:0] idx;

   initial begin
      $dumpfile("trace.vcd");
      $dumpvars(0, tb_dom_mult);
      {clk, rstn, Ax, Ay, Bx, By, Z0} = 7'h0;
      #15 rstn = 1'b1;
      for(idx = 0; idx <= 4'hf; idx++) begin
	      #5 {Ax, Ay, Bx, By} = idx;
      end
      #100 $finish();
   end

   always #5 clk++;
   dom_mult uut (clk, rstn, Ax, Ay, Bx, By, Z0, Aq, Bq);
endmodule // tb_dom_mult
`default_nettype wire
