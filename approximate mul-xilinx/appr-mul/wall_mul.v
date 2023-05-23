module wall_adder ( 
                    input clk,rst,
                    input [14:0] pp0 ,
                    input [12:0] pp1 ,
                    input [10:0] pp2 ,
                    input [8:0]  pp3 ,
                    input [6:0]  pp4 ,
                    input [4:0]  pp5 ,
                    input [2:0]  pp6 ,
                    input        pp7 ,
                    
                    output reg [15:0] product
                 );
	
    wire [12:4] s,c ;	
    wire [13:2]x ;
	  wire [14:3]y ;
	  wire [11:3] g ;
	  wire [12:0]tc ;
	  wire [15:0] t_product ;
	  
     ///////////////////////  stage 1    ////////////////////////////       	     
		   
		    //column 3
		  
	or_gate or_1   (                      // 2 input or gate
                   .x1  (pp2[1]),
				           .x2  (pp3[0]),
				           .out (g  [3])  
				         );
    
	      //column 4
	approx_ha ha_1 (                      // approx half adder
	                 .x1   (pp0[4] ),
				           .x2   (pp1[3] ),
				           .sum  (  s[4] ),
                   .carry(  c[4] )
	               );
	
	or_gate or_2   (                      // 2 input or gate
                   .x1 (pp3[1]),
				           .x2 (pp4[0]),
				           .out(  g[4])  
				         );
				 
	      //column 5
  approx_fa fa_1 (                     // approx full adder
	                 .x1   (pp0[5]),
				           .x2   (pp1[4]),
					         .x3   (pp2[3]),
				           .sum  (  s[5]),
                   .carry(  c[5])
	               );

  or_gate_3 or_3 (                     // 3 input or gate
                   .x1 (pp3[2]),
	                 .x2 (pp4[1]),
					         .x3 (pp5[0]),
                   .out(  g[5])  
                 );
				   
           //column 6
		   
	approx_comp ap_cm1 ( 
                                       // approx 4:2 compressors 
						          .x1   (pp0[6]),
                    	 .x2   (pp1[5]),
	                    .x3   (pp2[4]),
	                    .x4   (pp3[3]),
                      .sum  (  s[6]),
						          .carry(  c[6])
                     );
						
	or_gate_3 or_4     (                // 3 input or gate
                       .x1 (pp4[2]),
	                     .x2 (pp5[1]),
					             .x3 (pp6[0]),
                       .out(  g[6])  
                       );					
	
           //column 7
		   
	approx_comp ap_cm2 ( 
                                        // approx 4:2 compressors 
						           .x1   (pp0[7]),
                     	 .x2   (pp1[6]),
	                     .x3   (pp2[5]),
	                     .x4   (pp3[4]),
                       .sum  (  s[7]),
						           .carry(  c[7])
                       );
						
	or_gate_4 or_5     (                  // 4 input or gate
                       .x1 (pp4[3]),
	                     .x2 (pp5[2]),
					             .x3 (pp6[1]),
					             .x4 (pp7),
                       .out(  g[7])  
                       );
             
			 //column 8
		   
	approx_comp ap_cm3 ( 
                                      // approx 4:2 compressors 
						          .x1 (pp0[8]),
                    	 .x2 (pp1[7]),
	                    .x3 (pp2[6]),
	                    .x4 (pp3[5]),
                      .sum(  s[8]),
						          .carry(c[8])
                        );
						
	or_gate_3 or_6    (                // 3 input or gate
                      .x1 (pp4[4]),
	                    .x2 (pp5[3]),
					            .x3 (pp6[2]),
                      .out(  g[8])  
                    );

              //column 9
    approx_fa fa_2 (                   // approx full adder
	                   .x1   (pp0[9]),
				             .x2   (pp1[8]),
					           .x3   (pp2[7]),
				             .sum  (  s[9]),
                     .carry(  c[9])
	                 );

    or_gate_3 or_7 (                     // 3 input or gate
                     .x1 (pp3[6]),
	                   .x2 (pp4[5]),
					           .x3 (pp5[4]),
                     .out(  g[9])  
                   );
             
			 //column 10
    approx_fa fa_3 (                    // approx full adder
	                   .x1   (pp0[10]),
				             .x2   (pp1[9] ),
					           .x3   (pp2[8] ),
				             .sum  ( s[10] ),
                     .carry( c[10] )
	                 );

    or_gate   or_8 (                     // 2 input or gate
                     .x1 (pp3[7]),
	                   .x2 (pp4[6]),
					           .out( g[10])  
                   );	

			  //column 11
	approx_ha ha_2   (                     // approx half adder
	                   .x1   (pp0[11]),
				             .x2   (pp1[10]),
				             .sum  (  s[11]),
                     .carry(  c[11])
	                 );
	
	or_gate or_9   (                      // 2 input or gate
                   .x1 (pp2[9]),
				           .x2 (pp3[8]),
				           .out(g[11] )  
				         );	
              
			  //column 12
	approx_ha ha_3 (                       // approx half adder
	                 .x1   (pp0[12]),
				           .x2   (pp1[11]),
				           .sum  (  s[12]),
                   .carry(  c[12])
	               );	
  
//////////////////////////  stage 2  /////////////////////////////  
               
			   //column 2
	approx_ha ha_4 (                      // approx half adder
	                 .x1   ( pp0[2])  ,
				           .x2   ( pp1[1])  ,
				           .sum  (   x[2])  ,
                   .carry(   y[3])
	               );		   
               
			   //column 3
	approx_fa fa_4 (                          // approx full adder
	                 .x1   ( pp0[3])  ,
				           .x2   ( pp1[2])  ,
					         .x3   (   g[3])  ,
				           .sum  (   x[3])  ,
                   .carry(   y[4])
	               );
			   
			   //column 4
	approx_fa fa_5 (                          // approx full adder
	                 .x1   (   s[4])  ,
				           .x2   ( pp2[2])  ,
					         .x3   (   g[4])  ,
				           .sum  (   x[4])  ,
                   .carry(   y[5])
	               );
			   
			   //column 5
	approx_fa fa_6 (                          // approx full adder
	                 .x1   (   s[5])  ,
				           .x2   (   g[5])  ,
					         .x3   (   c[4])  ,
				           .sum  (   x[5])  ,
                   .carry(   y[6])
	               );          
			   
			   
			  //column 6
	approx_fa fa_7 (                          // approx full adder
	                 .x1   (   s[6])  ,
				           .x2   (   g[6])  ,
				         	 .x3   (   c[5])  ,
				           .sum  (   x[6])  ,
                   .carry(   y[7])
	               );
			  
			  //column 7
	approx_fa fa_8 (                          // approx full adder
	                 .x1   (   s[7])  ,
				           .x2   (   g[7])  ,
					         .x3   (   c[6])  ,
				           .sum  (   x[7])  ,
                   .carry(   y[8])
	               );
			  
			  //column 8
	approx_fa fa_9 (                          // approx full adder
	                 .x1   (   s[8])  ,
				           .x2   (   g[8])  ,
					         .x3   (   c[7])  ,
				           .sum  (   x[8])  ,
                   .carry(   y[9])
	                );
			  
			  //column 9
	approx_fa fa_10 (                        // approx full adder
	                 .x1   (   s[9]  )  ,
				           .x2   (   g[9]  )  ,
					         .x3   (   c[8]  )  ,
				           .sum  (   x[9]  )  ,
                   .carry(   y[10] )
	                );
			  
			  //column 10
	approx_fa fa_11 (                       // approx full adder
	                 .x1   (   s[10] ),
				           .x2   (   g[10] ),
					         .x3   (   c[ 9] ),
				           .sum  (   x[10] ),
                   .carry(   y[11] )
	                );       
			                 
			  //column 11    
	approx_fa fa_12 (                        // approx full adder
	                 .x1   (   s[11] ),
				           .x2   (   g[11] ),
					         .x3   (   c[10] ),
				           .sum  (   x[11] ),
                   .carry(   y[12] )
	                );       
			                 
			  //column 12    
	approx_fa fa_13 (                         // approx full adder
	                 .x1   (   s[12] ),
				           .x2   ( pp2[10] ),
					         .x3   (   c[11] ),
				           .sum  (   x[12] ),
                   .carry(   y[13] )
	                );       
			  
			  //column 13
	approx_fa fa_14 (                         // approx full adder
	                 .x1   ( pp0[13] ),
				           .x2   ( pp1[12] ),
					         .x3   (   c[12] ),
				           .sum  (   x[13] ),
                   .carry(   y[14] )
	                );       
	                           
    
	
	//////////////////////////   stage 3  /////////////////////////////         
			                   
                //column 0     
    assign t_product[0] = pp0[0]  ;
	                           
				//column 1     
	approx_ha ha_5  (                         // approx full adder
	                 .x1   (   	 pp0 [ 1] ),
				           .x2   (      pp1[ 0] ),
					         .sum  (  t_product[ 1] ),
                   .carry(   	  tc [ 0] )
	                );                    
				                          
				//column 2                
    approx_fa fa_15 (                      // approx full adder
	                   .x1   (      x  [ 2] ),
				             .x2   (   	 pp2 [ 0] ),
				             .x3   (      tc [ 0] ),
					           .sum  (  t_product[ 2] ),
                     .carry(       tc[ 1] )
	                );                    
			                             
				//column 3               
    approx_fa fa_16 (                          // approx full adder
	                   .x1   (        x[ 3] ),
				             .x2   (        y[ 3] ),
				             .x3   (   	  tc [ 1] ),
					           .sum  (  t_product[ 3] ),
                     .carry(       tc[ 2] )
	                );                   
				                         
				//column 4               
    approx_fa fa_17 (                        // approx full adder
	                   .x1   (       x[ 4] ),
				             .x2   (       y[ 4] ),
				             .x3   ( 	    tc[ 2] ),
					           .sum  ( t_product[ 4] ),
                     .carry(      tc[ 3] )
	                );                   
				                         
				//column 5               
    approx_fa fa_18 (                         // approx full adder
	                   .x1   (       x[ 5] ),
				             .x2   (       y[ 5] ),
				             .x3   ( 	    tc[ 3] ),
				           	 .sum  ( t_product[ 5] ),
                     .carry(      tc[ 4] )
	                );                   
				                         
				//column 6               
    approx_fa fa_19 (                           // approx full adder
	                   .x1   (       x[ 6] ),
				             .x2   (       y[ 6] ),
				             .x3   (   	  tc[ 4] ),
					           .sum  ( t_product[ 6] ),
                     .carry(      tc[ 5] )
	                );                   
				                         
				//column 7               
    approx_fa fa_20 (                           // approx full adder
	                   .x1   (       x[ 7] ),
				             .x2   (       y[ 7] ),
				             .x3   ( 	    tc[ 5] ),
					           .sum  ( t_product[ 7] ),
                     .carry(      tc[ 6] )
	                );                   
				
				//column 8
    approx_fa fa_21 (                           // approx full adder
	                   .x1   (       x[ 8] ),
				             .x2   (       y[ 8] ),
				             .x3   ( 	    tc[ 6] ),
					           .sum  ( t_product[ 8] ),
                     .carry(      tc[ 7] )
	                );                   
				                         
				//column 9               
    approx_fa fa_22 (                           // approx full adder
	                   .x1   (       x[ 9] ),
				             .x2   (       y[ 9] ),
				             .x3   ( 	    tc[ 7] ),
					           .sum  ( t_product[ 9] ),
                     .carry(      tc[ 8] )
	                );                   
				                         
				//column 10              
    approx_fa fa_23 (                           // approx full adder
	                   .x1   (       x[10] ),
				             .x2   (       y[10] ),
				             .x3   ( 	    tc[ 8] ),
					           .sum  ( t_product[10] ),
                     .carry(      tc[ 9] )
	                );                   
				                         
				//column 11              
    approx_fa fa_24 (                           // approx full adder
	                   .x1   (       x[11] ),
				             .x2   (       y[11] ),
				             .x3   ( 	    tc[ 9] ),
					           .sum  ( t_product[11] ),
                     .carry(      tc[10] )
	                );                   
				
				//column 12
    approx_fa fa_25 (                           // approx full adder
	                   .x1   (       x[12] ),
				             .x2   (       y[12] ),
				             .x3   ( 	    tc[10] ),
					           .sum  ( t_product[12] ),
                     .carry(      tc[11] )
	                );                   
				                         
				//column 13              
    approx_fa fa_26 (                           // approx full adder
	                   .x1   (       x[13] ),
				             .x2   (       y[13] ),
				             .x3   ( 	    tc[11] ),
					           .sum  ( t_product[13] ),
                     .carry(      tc[12] )
	                );                   
				                         
				//column 14              
    approx_fa fa_27 (                           // approx full adder
	                   .x1   (     pp0[14] ),
				             .x2   (       y[14] ),
				             .x3   ( 	    tc[12] ),
					           .sum  ( t_product[14] ),
                     .carry( t_product[15] )
	                );
	                
	  always @ (posedge clk or posedge rst)
	   begin
	    if(rst)
	       product = 16'b0 ;
	    else
	       product = t_product ;
	   end
endmodule
					
					
					