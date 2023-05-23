module approx_fa ( input x1, x2, x3, output sum, carry );
  
  wire w ;
  
    assign
         w     = x1| x2 , // temp value
         sum   = w ^ x3 , //sum calculation
         carry = w & x3 ; //carry calculation
    
endmodule