library ieee;
use ieee.std_logic_1164.all;

entity fsm_adc_cntrl is
	port(
	convst:in std_logic;  --pulse to start a conversion
	adc_out:in std_logic; --serial result
	clk:in std_logic;	  --system clock
	rst_bar:in std_logic; --system reset, active low
	sclk:out std_logic;	  --serial clock
	adc_result:out std_logic_vector(7 downto 0) --parallel result
	);	
end fsm_adc_cntrl;
architecture structural of fsm_adc_cntrl is
signal sig_edge1,sig_edge2,eod,u4,u2,sclk_dis,sclk1:std_logic;
begin 
	u1:entity edge_det port map(rst_bar=>rst_bar,clk=>clk, sig=>convst, pos=>'0',sig_edge=>sig_edge1);
	u3:entity delay_counter port map(clear_count=>'0',enable_count=>u2,clk=>clk,rst_bar=>rst_bar,eod=>eod);
	u5:entity sclk_gen port map(sclk_en=>u4,clk=>clk, rst_bar=>rst_bar,sclk_dis=>sclk_dis,sclk=>sclk1);
	u6:entity edge_det port map(rst_bar=>rst_bar, clk=>clk, sig=>sclk1,pos=>'1',sig_edge=>sig_edge2);
	u7:entity left_shift_reg port map(serial_in=>adc_out,shift_en=>sig_edge2,clk=>clk,rst_bar=>rst_bar,q=>adc_result); 
	fsm:entity adc_fsm port map(set4=>eod,reset4=>sclk_dis,set2=>sig_edge1,reset2=>eod,rst_bar_asyn=>rst_bar,clk=>clk,u4=>u4,u2=>u2);
	sclk<=sclk1;
end structural;
	