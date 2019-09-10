library ieee;
use ieee.std_logic_1164.all;

entity adc_fsm is 
	port(
	set4,reset4:in std_logic;
	set2,reset2:in std_logic;
	clk:in std_logic;
	rst_bar_asyn:in std_logic;
	u4, u2:out std_logic
	);
end adc_fsm;
architecture three_process of adc_fsm is
type state is (idle, delay,read);
signal present_state, next_state:state;
begin
	state_reg:process(clk,rst_bar_asyn)
	begin 
		if(rst_bar_asyn='0') then 
			present_state<=idle;
		elsif rising_edge(clk) then 
			present_state<=next_state;
		end if;
	end process;
	
	outputs:process(present_state)
	begin 
		case present_state is
			when idle=>
			u4<='0';
			u2<='0';
			when delay=>
			u4<='0';
			u2<='1';
			when read=>
			u4<='1';
			u2<='0';
		end case;
	end process;
	nxt_state:process(present_state,set4,set2,reset4,reset2)
	begin
		case present_state is
			when idle=>
			if set2='1'then 
				next_state<=delay;
			else
				next_state<=idle;
			end if;
			
			when delay=>
			if set4='1'  then 
				next_state<=read;
			else
				next_state<=delay;
			end if;
			
			when read=>
			if set4='0' and reset4='1' and set2='0' then 
				next_state<=idle;
			elsif reset4='1' and set4='0' and set2='1' then 
				next_state<=delay;
			else 
				next_state<=read;
			end if;
		end case;
	end process;
end three_process;
	
		
			
		
		