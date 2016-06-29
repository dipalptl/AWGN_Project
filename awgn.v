`timescale 1 ns / 100ps
`define DATA 320000   
`define SNR 0     // default SNR
module awgn(clock, reset, read, busy, x_in_real, x_in_imagi, y_out_real, y_out_imagi);

input wire clock, reset,read;
input wire signed [15:0] x_in_real;
input wire signed [15:0] x_in_imagi;
output reg busy=0;
output reg [15:0]y_out_real;
output reg [15:0]y_out_imagi;
reg signed [17:0] f_x1;
reg signed [9:0] g_x2_cos; 
reg signed [9:0] g_x2_sin;
reg signed [15:0] temp_x_in_real;
reg signed [15:0] temp_x_in_imagi;
reg signed [27:0] sum_real_n;
reg signed [27:0] sum_imagi_n;
reg signed [34:0] noise_real;
reg signed [34:0] noise_imagi;
wire [1:0] f_xor_out;
wire [1:0] g_xor_out_cos;
wire [1:0] g_xor_out_sin;

integer i=0, j=0, k=0;

real sigma_0=90.50966, sigma_1=80.66683, sigma_2=71.89440, sigma_3=64.07593,
     sigma_4=57.10774, sigma_5=50.89732, sigma_6=45.36229, sigma_7=40.43,
     sigma_8=36.033, sigma_9=32.114, sigma_10=28.622;

always@ (posedge clock)
begin
    if(reset==1'b0 && read==1'b1 && busy==1'b0 && i < `DATA)
    begin
        temp_x_in_real=x_in_real;
        temp_x_in_imagi=x_in_imagi;
        i=i+1;
        busy=1;
    end
end

assign f_xor_out = f_x1[0] + f_x1[7];
assign g_xor_out_cos = g_x2_cos[0]+ g_x2_cos[3];
assign g_xor_out_sin = g_x2_sin[0]+ g_x2_sin[3];

always@ (posedge clock)
begin
    if(reset==1'b1)
    begin
        f_x1 <= 18'h3ffff;
        g_x2_cos <= 10'h3ff;
        g_x2_sin <= 10'b1000000000;
    end
    else
    begin
        if(busy==1'b1 && j<`DATA)
        begin
            f_x1[16:0] <= f_x1[17:1];
            f_x1[17] <= f_xor_out[0];
            g_x2_cos[8:0] <= g_x2_cos[9:1];
            g_x2_cos[9] <= g_xor_out_cos[0];
            g_x2_sin[8:0] <= g_x2_sin[9:1];
            g_x2_sin[9] <= g_xor_out_sin[0];
            sum_real_n = f_x1 * g_x2_cos;
            sum_imagi_n = f_x1 * g_x2_sin;
            
            if(`SNR==0)
            begin
                noise_real = sigma_0 * sum_real_n;
                noise_imagi = sigma_0 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==1)
            begin
                noise_real = sigma_1 * sum_real_n;
                noise_imagi = sigma_1 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==2)
            begin
                noise_real = sigma_2 * sum_real_n;
                noise_imagi = sigma_2 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==3)
            begin
                noise_real = sigma_3 * sum_real_n;
                noise_imagi = sigma_3 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==4)
            begin
                noise_real = sigma_4 * sum_real_n;
                noise_imagi = sigma_4 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==5)
            begin
                noise_real = sigma_5 * sum_real_n;
                noise_imagi = sigma_5 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==6)
            begin
                noise_real = sigma_6 * sum_real_n;
                noise_imagi = sigma_6 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==7)
            begin
                noise_real = sigma_7 * sum_real_n;
                noise_imagi = sigma_7 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
           if(`SNR==8)
            begin
                noise_real = sigma_8 * sum_real_n;
                noise_imagi = sigma_8 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end 
            if(`SNR==9)
            begin
                noise_real = sigma_9 * sum_real_n;
                noise_imagi = sigma_9 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end
            if(`SNR==10)
            begin
                noise_real = sigma_10 * sum_real_n;
                noise_imagi = sigma_10 * sum_imagi_n;
                y_out_real = temp_x_in_real + noise_real[34:25]; 
                y_out_imagi = temp_x_in_imagi + noise_imagi[34:25];
            end             
        end
    end
end
endmodule 

module tausworthe (
  input    clk,
  input    reset,
  output [31:0]  a,
  output reg     temp
);

parameter x0 = 32'hffffffff;
parameter x1 = 32'hcccccccc;
parameter x2 = 32'h00ff00ff;
wire [31:0] b1,b2,b3;
wire [31:0] next_x0, next_x1, next_x2;
reg  [31:0] x0_reg, x1_reg, x2_reg;

assign b1      = (((x0_reg << 13) ^ x0_reg) >> 19);
assign next_x0 = (((x0_reg & 32'hfffffffe) << 12) ^ b1);
assign b2      = (((x1_reg << 2 ) ^ x1_reg) >> 25);
assign next_x1 = (((x1_reg & 32'hfffffff8) << 4 ) ^ b2);
assign b3      = (((x2_reg << 3 ) ^ x2_reg) >> 11);
assign next_x2 = (((x2_reg & 32'hfffffff0) << 17) ^ b3);

assign a = x0_reg ^ x1_reg ^ x2_reg;
assign b = a;
always @(posedge clk or posedge reset)
  if (reset)
  begin
    x0_reg <= x0;
    x1_reg <= x1;
    x2_reg <= x2;
    temp <= 1'b0;
  end
  else
  begin 
    x0_reg <= next_x0;
    x1_reg <= next_x1;
    x2_reg <= next_x2;
    temp <= 1'b1;
  end
endmodule


