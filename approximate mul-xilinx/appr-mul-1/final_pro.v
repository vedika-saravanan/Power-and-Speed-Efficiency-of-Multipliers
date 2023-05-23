/////////////   final approximate multiplier 8x8   //////////////////////

module final_pro ( 
               input clk,rst,
               input  [7:0] multiplicand, multiplier,
               output [15:0] product 
             );
      
  
  wire [14:0] pp0; 
  wire [12:0] pp1;
  wire [10:0] pp2; 
  wire [8:0]  pp3;
  wire [6:0]  pp4;
  wire [4:0]  pp5;
  wire [2:0]  pp6;
  wire        pp7;
  
  ppgen_loop u0 (  
              .clk         ( clk          ),
              .rst         ( rst          ),       ///  partial product generator ////
              .A           ( multiplicand ), 
              .B           ( multiplier   ),
              .pp0         ( pp0          ) ,
              .pp1         ( pp1          ) ,
              .pp2         ( pp2          ) ,
              .pp3         ( pp3          ) ,
              .pp4         ( pp4          ) ,
              .pp5         ( pp5          ) ,
              .pp6         ( pp6          ) ,
              .pp7         ( pp7          ) 
          
           ); 
   
   pp_adder u1 (    .clk ( clk ),
                    .rst ( rst ),                      /////  compressed adder part //////
                    .p0 ( pp0 ) ,
                    .p1 ( pp1 ) ,
                    .p2 ( pp2 ) ,
                    .p3 ( pp3 ) ,
                    .p4 ( pp4 ) ,
                    .p5 ( pp5 ) ,
                    .p6 ( pp6 ) ,
                    .p7 ( pp7 ) ,
                    
                    .product (product)
                 );
endmodule
