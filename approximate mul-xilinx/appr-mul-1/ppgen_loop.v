module ppgen_loop( 
                   input             clk,rst,
                   input       [7:0] A,B,
                   output reg [14:0] pp0, 
                   output reg [12:0] pp1,
                   output reg [10:0] pp2, 
                   output reg [8:0]  pp3,
                   output reg [6:0]  pp4,
                   output reg [4:0]  pp5,
                   output reg [2:0]  pp6,
                   output reg        pp7);


wire [7:0]  p0, p1, p2, p3, p4, p5, p6, p7;


 wire [7:0] AB [0:7];


   genvar i,j;
     generate
      for(j=0; j<8; j=j+1)
        begin : ab_bit
          for(i=0; i<8; i=i+1)
            begin : ab_row

              assign AB[i][j] = A[i] & B[j];
              
            end
        end 
     endgenerate
    
     assign p0 = AB[0][7:0] ;
     assign p1 = AB[1][7:0] ;
     assign p2 = AB[2][7:0] ;
     assign p3 = AB[3][7:0] ;
     assign p4 = AB[4][7:0] ;
     assign p5 = AB[5][7:0] ;
     assign p6 = AB[6][7:0] ;
     assign p7 = AB[7][7:0] ;
     
     
  always@( posedge clk or posedge rst)
   begin  
     if (rst==1'b1)
      begin
        pp0 = 15'b0 ;
        pp1 = 13'b0 ;
        pp2 = 11'b0 ;
        pp3 = 9'b0 ;
        pp4 = 7'b0 ;
        pp5 = 5'b0 ;
        pp6 = 3'b0 ;
        pp7 = 1'b0 ;
      end
   else
      begin
    
       pp0 = {p7[7] , p6[7] , p5[7] , p4[7] , p3[7] , p2[7] , p1[7] , p0[7] , p0[6] , p0[5] , p0[4] , p0[3] , p0[2] , p0[1] , p0[0]};
       pp1 =        { p7[6] , p6[6] , p5[6] , p4[6] , p3[6] , p2[6] , p1[6] , p1[5] , p1[4] , p1[3] , p1[2] , p1[1] , p1[0] };
       pp2 =                { p7[5] , p6[5] , p5[5] , p4[5] , p3[5] , p2[5] , p2[4] , p2[3] , p2[2] , p2[1] , p2[0] };
       pp3 =                        { p7[4] , p6[4] , p5[4] , p4[4] , p3[4] , p3[3] , p3[2] , p3[1] , p3[0] };
       pp4 =                                { p7[3] , p6[3] , p5[3] , p4[3] , p4[2] , p4[1] , p4[0] };
       pp5 =                                        { p7[2] , p6[2] , p5[2] , p5[1] , p5[0] };
       pp6 =                                                { p7[1] , p6[1] , p6[0] }; 
       pp7 =                                                          p7[0];
 
   
     end
  end  
endmodule