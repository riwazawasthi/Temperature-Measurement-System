--RIWAZ AWASTHI (110746533)
--ESE 382 Lab 10
--Design description of a typical S-R flip flop with asynchronous reset is provide below. If the reset is low , the flip flop is cleared otherwise at 
--positive edge of the clock the equation Q_next=S+R'Q_present is implemented.
library ieee;
use ieee.std_logic_1164.all;

entity sr_flip_flop is
	port(
	set:in std_logic;  -- synchronous set input
	reset:in std_logic;--synchronous reset input
	clk:in std_logic;  --system clock
	rst_bar_asyn:in std_logic; --asynchronous reset
	q:out std_logic			   --output
	);
end sr_flip_flop;

architecture behavioral of sr_flip_flop is
signal q_sig:std_logic;
begin
	process(rst_bar_asyn, clk)
	begin
		if(rst_bar_asyn='0') then 
			q_sig<='0';
		elsif rising_edge(clk) then 
			q_sig<= set or (not reset and q_sig);
		end if;
	end process;
	q<=q_sig;
end behavioral;
	
	