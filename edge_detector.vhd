--RIWAZ AWASTHI (110746533)
--ESE 382 Lab 10
--Following is the design description of an edge detector which can detect both positive and negative edges of an input signal based 
--on the value of "pos". If the value is '1' it's an positive edge detector, otherwise it's an negative edge detector. The design description is based
--use of two flip flops and a logic gate but described in a behavioral manner. The incoming signal is delayed through a flip flop and the delayed signal 
--and the original signal are passed through an and gate and through another flip flop. This generates a pulse 1 system clock wide every time an edge is
--detected.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_det is
	port( 
	rst_bar:in std_logic; --asynchronous system reset
	clk:in std_logic;     --system clock
	sig:in std_logic;     --input signal
	pos:in std_logic;	  --'1' for positive edge, '0' for negative
	sig_edge:out std_logic	 --high for one system clock after edge detected
	);
end edge_det;

architecture behavioral of edge_det  is
signal delayed:std_logic;
begin
	edge:process(clk,rst_bar)
	begin
		if(rst_bar='0') then 
			sig_edge<='0';
			delayed<='0';
		elsif rising_edge(clk) then
			if (pos='1') then
				delayed<=sig;
				sig_edge<=not delayed and sig;
			else
				delayed<=sig;
				sig_edge<=delayed and not sig;
			end if;
		end if;
	end process;
end behavioral;
	
		
			
				

	