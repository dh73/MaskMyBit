/* Generated by Yosys 0.13 (git sha1 8b1eafc3a, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module dom_mult(clk, rstn, Ax, Ay, Bx, By, Z0, Aq, Bq);
  output Aq;
  input Ax;
  input Ay;
  output Bq;
  input Bx;
  input By;
  input Z0;
  input clk;
  wire cross_AxBy;
  wire cross_BxAy;
  wire inner_AxAy;
  wire inner_BxBy;
  wire integ_Aq;
  wire integ_Bq;
  reg reshare_AxBy_ff;
  reg reshare_BxAy_ff;
  wire reshare_cross_AxBy;
  wire reshare_cross_BxAy;
  input rstn;
  always @(posedge clk, negedge rstn)
    if (!rstn) reshare_AxBy_ff <= 1'h0;
    else reshare_AxBy_ff <= reshare_cross_AxBy;
  always @(posedge clk, negedge rstn)
    if (!rstn) reshare_BxAy_ff <= 1'h0;
    else reshare_BxAy_ff <= reshare_cross_BxAy;
  assign inner_AxAy = Ax & Ay;
  assign inner_BxBy = Bx & By;
  assign cross_AxBy = Ax & By;
  assign cross_BxAy = Bx & Ay;
  assign reshare_cross_AxBy = cross_AxBy ^ Z0;
  assign reshare_cross_BxAy = cross_BxAy ^ Z0;
  assign Aq = reshare_AxBy_ff ^ inner_AxAy;
  assign Bq = reshare_BxAy_ff ^ inner_BxBy;
  assign integ_Aq = Aq;
  assign integ_Bq = Bq;
endmodule
