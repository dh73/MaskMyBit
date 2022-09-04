`default_nettype none
module dom_and(input wire Ax, Ay,
	       input wire Bx, By,
	       input wire Z0,
	       input wire clk, rstn,
	       output logic Aq, Bq);
   
   wire mul_AxAy = Ax & Ay; // reshare
   wire	mul_AxBy = Ax & By; // internal
   wire	mul_BxAy = Bx & Ay; // internal
   wire	mul_BxBy = Bx & By; // reshare

   wire	mul_AxBy_share = mul_AxBy ^ Z0;
   wire	mul_BxAy_share = mul_BxAy ^ Z0;

   reg	mul_AxBy_share_ff, mul_BxAy_share_ff;
   always @(posedge clk, negedge rstn) begin
      if(!rstn) begin 
	 {mul_AxBy_share_ff, 
	  mul_BxAy_share_ff} <= {1'b0, 1'b0};
      end else begin
	 mul_AxBy_share_ff <= mul_AxBy_share;
	 mul_BxAy_share_ff <= mul_BxAy_share;
      end
   end

   assign Aq = mul_BxAy_share_ff ^ mul_BxBy;
   assign Bq = mul_AxBy_share_ff ^ mul_AxAy;
endmodule // dom_and
`default_nettype wire
