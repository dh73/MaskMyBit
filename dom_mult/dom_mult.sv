`default_nettype none
module dom_mult(input wire clk, rstn,
		input wire Ax, Ay,
		input wire Bx, By,
		input wire Z0,
		output logic Aq, Bq);

   // Calculation
   wire inner_AxAy = Ax & Ay;
   wire	inner_BxBy = Bx & By;
   wire	cross_AxBy = Ax & By;
   wire	cross_BxAy = Bx & Ay;

   //Resharing
   wire	reshare_cross_AxBy = cross_AxBy ^ Z0;
   wire	reshare_cross_BxAy = cross_BxAy ^ Z0;
   logic reshare_AxBy_ff;
   logic reshare_BxAy_ff;
   
   always_ff @(posedge clk, negedge rstn) begin
      if(!rstn) begin
	 reshare_AxBy_ff <= 1'b0;
	 reshare_BxAy_ff <= 1'b0;
      end else begin
	 reshare_AxBy_ff <= reshare_cross_AxBy;
	 reshare_BxAy_ff <= reshare_cross_BxAy;
      end
   end

   // Integration
   wire integ_Aq = reshare_AxBy_ff ^ inner_AxAy;
   wire	integ_Bq = reshare_BxAy_ff ^ inner_BxBy;

   // Output assignment
   assign Aq = integ_Aq;
   assign Bq = integ_Bq;
endmodule // dom_mult
`default_nettype wire
