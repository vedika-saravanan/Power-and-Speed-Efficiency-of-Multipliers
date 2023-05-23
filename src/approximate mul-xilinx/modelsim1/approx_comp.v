module approx_comp ( input x1, x2, x3,x4, output sum, carry );
  
  wire w1,w2 ;
  
    assign
         w1    = x1 & x2 ,                          // temp value1
         w2    = x3 & x4 ,                          // temp value1
         sum   = (x1 ^ x2) | (x3 ^ x4) | (w1 & w2) ,//sum calculation
         carry = w1 | w2  ;                         //carry calculation
  
endmodule