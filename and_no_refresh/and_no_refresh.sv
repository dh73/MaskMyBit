`default_nettype none
`ifdef _WITH_FRESH_MASK_
module and_no_refresh(input wire clk, rstn,
		      input wire   a0, a1, // As[0], As[1]
		      input wire   b0, b1, // Bs[0], Bs[1]
		      input wire   r,
		      output logic x0, x1);
   
   // Inner and cross product
   wire				   inner_a0_b0 = a0 & b0; // {As[0], Bs[0]}
   wire	cross_a0_b1 = a0 & b1; // {As[0], Bs[1]}
   wire	inner_a1_b1 = a1 & b1; // {As[1], Bs[1]}
   wire	cross_b0_a1 = a1 & b0; // {As[1], Bs[0]}

   // Refresh
   wire	refresh_a0_b0_r = inner_a0_b0 ^ r; // {As[0], Bs[0], r} -> {r}
   wire	refresh_a1_b1_r = inner_a1_b1 ^ r; // {As[1], Bs[1], r} -> {r}

   // Resharing
   logic reshare_x0; // {r'}
   logic reshare_x1; // {As[0]', Bs[1]'}
   logic reshare_x2; // {As[1]', Bs[0]'}
   logic reshare_x3; // {r'}

   always_ff @(posedge clk, negedge rstn) begin
      if(!rstn) begin
         reshare_x0 <= 1'b0;
         reshare_x1 <= 1'b0;
	 reshare_x2 <= 1'b0;
         reshare_x3 <= 1'b0;
      end else begin
	 reshare_x0 <= refresh_a0_b0_r;
         reshare_x1 <= cross_a0_b1;
	 reshare_x2 <= cross_b0_a1;
	 reshare_x3 <= refresh_a1_b1_r;
      end
   end

   // Compression
   wire integ_x0 = reshare_x0 ^ reshare_x1; // {r', As[0]', Bs[1]'} -> {r}
   wire	integ_x1 = reshare_x2 ^ reshare_x3; // {As[1]', Bs[0]', r'} -> {r}

   assign x0 = integ_x0;
   assign x1 = integ_x1;
endmodule // and_no_refresh
`else // !`ifdef _WITH_FRESH_MASK_
module and_no_refresh(input wire clk, rstn,
		      input wire   a0, a1, // As[0], As[1]
		      input wire   b0, b1, // Bs[0], Bs[1]
		      input wire   r,
		      output logic x0, x1);
   
   // Inner and cross product
   wire				   inner_a0_b0 = a0 & b0; // {As[0], Bs[0]}
   wire	cross_a0_b1 = a0 & b1; // {As[0], Bs[1]}
   wire	inner_a1_b1 = a1 & b1; // {As[1], Bs[1]}
   wire	cross_b0_a1 = a1 & b0; // {As[1], Bs[0]}

   // Refresh
   wire	refresh_a0_b0_r = inner_a0_b0 ^ b0; // {As[0], Bs[0], Bs[0]}
   wire	refresh_a1_b1_r = inner_a1_b1 ^ b1; // {As[1], Bs[1], Bs[1]}

   // Resharing
   logic reshare_x0; // {r'}
   logic reshare_x1; // {As[0]', Bs[1]'}
   logic reshare_x2; // {As[1]', Bs[0]'}
   logic reshare_x3; // {r'}

   always_ff @(posedge clk, negedge rstn) begin
      if(!rstn) begin
         reshare_x0 <= 1'b0;
         reshare_x1 <= 1'b0;
	 reshare_x2 <= 1'b0;
         reshare_x3 <= 1'b0;
      end else begin
	 reshare_x0 <= refresh_a0_b0_r;
         reshare_x1 <= cross_a0_b1;
	 reshare_x2 <= cross_b0_a1;
	 reshare_x3 <= refresh_a1_b1_r;
      end
   end

   // Compression
   wire integ_x0 = reshare_x0 ^ reshare_x1; // {r', As[0]', Bs[1]'} -> {r}
   wire	integ_x1 = reshare_x2 ^ reshare_x3; // {As[1]', Bs[0]', r'} -> {r}

   assign x0 = integ_x0;
   assign x1 = integ_x1;
endmodule // and_no_refresh
`endif // !`ifdef _WITH_FRESH_MASK_
`default_nettype wire
