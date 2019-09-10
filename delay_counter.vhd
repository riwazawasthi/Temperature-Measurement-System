--RIWAZ AWASTHI (110746533)
--ESE 382 Lab 10
--Design description of a delay counter is provided whose function is to provide a delay of 35us. This is acheived by implementing a counter that counts
--upto 36 and rolls back. Counting takes place only when 'enable_count'='1' and at the end of the delay a pulse eod of 1 system clock wide is generated.
--The counter also has synchronous clear and an asynchronous reset button. The counter is positve-edge  triggered.An unsigned signal is used in the architecture body to carry out the counting.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay_counter is
	port(
	clear_count:in std_logic; --synchronously clear count
	enable_count:in std_logic; --enables counter to count
	clk:in std_logic;	       --system clock
	rst_bar:in std_logic;	   --asynchronous reset
	eod:out std_logic		   --end of delay pulse
	);
end delay_counter;	  

architecture behavioral of delay_counter is
signal count:unsigned(5 downto 0);
begin
	process(clk,rst_bar)
	begin 
		
		if(rst_bar='0') then 
			count<=(others=>'0');
		elsif rising_edge(clk) then 
			if(clear_count='1') then 
				count<=(others=>'0'); 
		    
			elsif(count="100100") then 
				count<=(others=>'0');
			
			elsif(enable_count='1') then 
				count<= count+1;
			
			end if;
		end if;
	end process;
	process(clk)
	begin 
		if rising_edge(clk) then 
		if(count="100011") then 
			eod<='1';
		else 
			eod<='0';
		end if;
		end if;
	end process;
		
end behavioral;
	
		
			
			
			
