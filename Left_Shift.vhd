--RIWAZ AWASTHI (110746533)
--ESE 382 Lab 10
--Design Description of a left shift register is provided below. The left shift register deserializes the serial data at its serial_in input. 
--The deserialized result is output in parallel on q.It also has an asynchronous reset which is active low. The left shift is implemented using 
--slices and concatenation.



library ieee;
use ieee.std_logic_1164.all;

entity left_shift_reg is
	port(
	serial_in:in std_logic;
	shift_en:in std_logic;
	clk:in std_logic;
	rst_bar:in std_logic;
	q:out std_logic_vector(7 downto 0)
	);
end left_shift_reg;

architecture behavioral of left_shift_reg is
begin
	process(clk, rst_bar)
	variable d:std_logic_vector(7 downto 0);
	begin
		if(rst_bar='0') then
			d:=(others=>'0');
		elsif rising_edge(clk)then 
			if shift_en='1' then 
				d:=d(6 downto 0) & serial_in;
			else
				null;
			end if;
			q<=d;
		end if;
	end process;
end behavioral;
	
		
		
			
			
