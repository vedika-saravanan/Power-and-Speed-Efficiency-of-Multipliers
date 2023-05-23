module approx_ha ( input x1, x2, output sum, carry );
  
  assign
      sum   = x1 | x2 , //sum calculation
      carry = x1 & x2 ; //carry calculation
    
endmodule