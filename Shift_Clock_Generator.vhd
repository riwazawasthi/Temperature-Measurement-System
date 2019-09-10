--RIWAZ AWASTHI (110746533)
--ESE 382 Lab 10
--Design description of a shift clock generator is provided below. The shift clock has to 1/8 of the system clock frequency and we require at least 8 cycles. 
--This is acheived by implementing a counter that counts upto 63 and rolls back. The third bit from the right of the count bits is used as the shift clock. 
--This shift clock generator also has an asynchronous reset and an shift clock enable. The flip flops are cleared when reset is low and shift clock pulses 
--are generated only when the enable is high; also the counting is positive edge-triggered. At the end of the last pulse of the shift clock a 1 system wide 
--clock pulse is generated called as 'sclk_dis'.An unsigned signal is used in the architecture body to carry out the counting. 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sclk_gen is
	port(
	sclk_en:in std_logic;  --enable to generate shift clock
	clk:in std_logic;	   --synchronous clock
	rst_bar:in std_logic;  --asynnchronous reset
	sclk_dis:out std_logic;	 --disable pulse
	sclk:out std_logic   --shift clock 1/8 of system clock
	);
end sclk_gen;

architecture behavioral of sclk_gen is
signal count:unsigned(5 downto 0); 
begin
	process(clk,rst_bar)
	begin  
		if(rst_bar='0') then 
			count<=(others=>'0');
			sclk<=std_logic(count(2));
		elsif rising_edge(clk) then 
			
			if(sclk_en='1') then 
				count<=count+1;
				sclk<=std_logic(count(2));
			else
				count<=(others=>'0');
				sclk<=std_logic(count(2));
			end if;
		end if;
		
	end process;
	process(clk)
	begin
		if rising_edge(clk)then 
			if  (count="111111") then
				sclk_dis<='1';
			else
				sclk_dis<='0';
		end if;
		end if;
	end process;
end behavioral;
	
		
		
			
		