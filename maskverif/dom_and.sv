`default_nettype none
module dom_and(input wire Ax, Ay,
	       input wire Bx, By,
	       output logic Aq, Bq);

   wire mul_AxAy = Ax & Ay;
   wire	mul_AxBy = Ax & By;
   wire	mul_BxAy = Bx & Ay;
   wire	mul_BxBy = Bx & By;

   wire	add_AxAy_AxBy = mul_AxAy ^ mul_AxBy;
   wire	add_BxAy_BxBy = mul_BxAy ^ mul_BxBy;

   assign Aq = add_AxAy_AxBy ^ add_BxAy_BxBy;
endmodule // dom_and
`default_nettype wire
