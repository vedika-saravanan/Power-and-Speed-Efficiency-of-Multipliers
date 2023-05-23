module pp_adder ( 
                    input clk,rst,
                    input [14:0] p0 ,
                    input [12:0] p1 ,
                    input [10:0] p2 ,
                    input [8:0]  p3 ,
                    input [6:0]  p4 ,
                    input [4:0]  p5 ,
                    input [2:0]  p6 ,
                    input        p7 ,
                    
                    output reg [15:0] product
                 );
					  
reg r1,r2,r3,r;
reg [9:0] pp_add;	

  
always@( posedge clk)
   begin  
     
       
      product[0] = p0[0];
      product[1] = p0[1] | p1[0]; 
      product[2] = p0[2] | p1[1] | p2[0];
      product[3] = p0[3] | p1[2] | p2[1] | p3[0];
      r1 = p0[4] | p1[3] | p2[2] | p3[1] | p4[0];
      r2 = p0[5] | p1[4] | p2[3]; 
      r3 = p3[2] | p4[1] | p5[0];
      product[4] = r1;
      product[5] = r2 | r3;
      
      r = (r1 & r2) | (r1 & r3);
      
      
      pp_add = {1'b0,p0[14:6]} + {2'b0,p1[12:5]} + {3'b0,p2[10:4]} + {4'b0,p3[8:3]} + {5'b0,p4[6:2]} + {6'b0,p5[4:1]} + 
                {7'b0,p6[2:0]} + {8'b0,p7,r};
      
      
      product[15:6] = pp_add;//{ pp_add,product[5],product[4],product[3],product[2],product[1],product[0]};
                 
   
 end
   
  
   
endmodule
					
					
					
