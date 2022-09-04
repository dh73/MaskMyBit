`default_nettype none
 `timescale 1ns/1ps
module tb_circuit;
   reg clk, rstn;
   reg  Ax, Ay, Bx, By, Z0;
   wire	Aq, Bq;
   integer idx;

   initial begin
      $dumpfile("trace.vcd");
      $dumpvars(0, tb_circuit);
   end
   
   initial begin
      #0 {Ax, Ay, Bx, By, rstn, clk, Z0} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
      #25 rstn = 1'b1;
      #25 {Ax, Ay, Bx, By} = {1'b0, 1'b1, 1'b0, 1'b1};
      #50 $finish();
   end
   
   always #5 clk++;
   dom_and uut (Ax, Ay, Bx, By, Z0, clk, rstn, Aq, Bq);   
endmodule // tb_curcuit
 `default_nettype wire
