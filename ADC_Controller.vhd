--RIWAZ AWASTHI (110746533) 
--ESE 382 Lab 10
--Structural design description of an ADC controller is given which is formed by combining all the previously designed entities.

library ieee;
use ieee.std_logic_1164.all;

entity sh_adc_cntrl is
	port(
	convst:in std_logic;  --pulse to start a MAX1106 conversion
	adc_out:in std_logic; --serial result from MAX1106
	clk:in std_logic;	  --system clock
	rst_bar:in std_logic; --system reset, active low
	sclk:out std_logic;	  --serial clock
	adc_result:out std_logic_vector(7 downto 0) --parallel result
	);	
end sh_adc_cntrl;
architecture structural of sh_adc_cntrl is
signal sig_edge1,sig_edge2,eod,q1,q2,sclk_dis,sclk1:std_logic;
begin 
	u1:entity edge_det port map(rst_bar=>rst_bar,clk=>clk, sig=>convst, pos=>'0',sig_edge=>sig_edge1);
	u2:entity sr_flip_flop port map(set=>sig_edge1,reset=>eod,clk=>clk,rst_bar_asyn=>rst_bar,q=>q1);
	u3:entity delay_counter port map(clear_count=>'0',enable_count=>q1,clk=>clk,rst_bar=>rst_bar,eod=>eod);
	u4:entity sr_flip_flop port map(set=>eod,reset=>sclk_dis,clk=>clk,rst_bar_asyn=>rst_bar,q=>q2);
	u5:entity sclk_gen port map(sclk_en=>q2,clk=>clk, rst_bar=>rst_bar,sclk_dis=>sclk_dis,sclk=>sclk1);
	u6:entity edge_det port map(rst_bar=>rst_bar, clk=>clk, sig=>sclk1,pos=>'1',sig_edge=>sig_edge2);
	u7:entity left_shift_reg port map(serial_in=>adc_out,shift_en=>sig_edge2,clk=>clk,rst_bar=>rst_bar,q=>adc_result);
	sclk<=sclk1;
end structural;

	