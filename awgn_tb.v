`define Bit_w 16   //INPUT WIDTH  
`define DATA 320000  // TOTAL INPUT DATA
`timescale 1ns / 100ps

module awgn_tb;

reg     clk1;
reg     reset1;
reg     read1;
reg     signed[`Bit_w-1:0]x_in1_real;
reg     signed[`Bit_w-1:0]x_in1_imagi;
wire    busy1;
wire    [`Bit_w-1:0]y_out1_real;
wire    [`Bit_w-1:0]y_out1_imagi;

integer data_real_in, data_imagi_in, data_real_out, data_imagi_out, num, k;
integer y_out1_real_temp, y_out1_imagi_temp, temp_real, temp_imagi;
integer data_noise_real_n_out;

awgn abc(.clock(clk1),
     .reset(reset1),
     .read(read1),
     .busy(busy1),
     .x_in_real(x_in1_real),
     .x_in_imagi(x_in1_imagi),
     .y_out_real(y_out1_real),
     .y_out_imagi(y_out1_imagi));
              

initial                                                        
begin
    data_real_in = $fopen("input_real_data_320000.txt","r");
    data_imagi_in = $fopen("input_imag_data_320000.txt","r");
    data_real_out = $fopen("real_signal_with_awgn_output_8dB.txt");
    data_imagi_out = $fopen("imag_signal_with_awgn_output_8dB.txt");
    data_noise_real_n_out = $fopen("data_noise_real_n_out.txt");
    #0  clk1 = 0;
    #0   num = 0;
    #0     k = 0;
    #0 reset1 = 1'b1;
    #15 reset1 = 1'b0;
    #20 read1 = 1'b1;
    #3300000 
    $finish;
end
   
always
begin
    #5 clk1 = 1'b1;
    #5 clk1 = 1'b0;
end
     
always@(posedge clk1)
begin
    if(read1==1 && num < `DATA)
    begin
        temp_real = $fscanf(data_real_in,"%d",x_in1_real);
        temp_imagi = $fscanf(data_imagi_in,"%d",x_in1_imagi);
        num=num+1;                               
    end
    else                 
    begin                                                                  
        x_in1_real <= x_in1_real; 
        x_in1_imagi <= x_in1_imagi;                                                                           
    end
end      

always@(posedge clk1)
begin
    if(busy1==1 && k < `DATA)
    begin
        y_out1_real_temp = y_out1_real;
        y_out1_imagi_temp = y_out1_imagi;
    
        $fdisplay(data_real_out, "%d",(y_out1_real_temp < 32768?y_out1_real_temp:y_out1_real_temp-65536) );
        $fdisplay(data_imagi_out, "%d",(y_out1_imagi_temp < 32768?y_out1_imagi_temp:y_out1_imagi_temp-65536) );
      
        k = k+1;
    end
end                                                                             
 	                                   
endmodule
