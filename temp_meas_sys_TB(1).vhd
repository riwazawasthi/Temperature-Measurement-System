-------------------------------------------------------------------------------
--
-- Title       : temp_meas_sys_tb
-- Design      : temp_meas_sys
-- Author      : Ken Short
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : temp_meas_sys_TB.vhd
-- Generated   : 04/22/17
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is an exhaustive self-checking sequential testbench for
-- the temparature measuring system of Laboratory 11.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity temp_meas_sys_tb is
end temp_meas_sys_tb;

architecture tb_architecture of temp_meas_sys_tb is
	
	-- Stimulus signals
	signal convst : std_logic := '0';
	signal adc_out : std_logic := '0';
	signal clk : std_logic := '0';
	signal rst_bar : std_logic;
	-- Observed signals
	signal sclk : std_logic;
	signal seven_seg0 : std_logic_vector(6 downto 0);
	signal seven_seg1 : std_logic_vector(6 downto 0);
	
	signal end_sim : boolean := false;
	constant period :time := 1us;
	
begin
	
	-- Unit Under Test port map
	UUT : entity temp_meas_sys
	port map (
		convst => convst,
		adc_out => adc_out,
		clk => clk,
		rst_bar => rst_bar,
		sclk => sclk,
		seven_seg0 => seven_seg0,
		seven_seg1 => seven_seg1
		);
	
	-- Generate system clock until end end_sim is true
	-- clock has 50% duty cycle
	sys_clk: process
	begin
		wait for period/2;
		loop
			clk <= not clk;
			wait for period/2;
			exit when end_sim = true;
		end loop;
		wait;
	end process;
	
	-- reset signal is low for four clocks
	rst_bar <= '0', '1' after 4 * period;
	
	-- generate convst signal to start conversion
	-- positive pulse 5 clocks wide
	soc: process
	begin
		wait for 10 * period;
		loop
			exit when end_sim = true;
			convst <= '1';
			wait for 5 * period;
			convst <= '0';
			wait for 125 * period;
		end loop;
		wait;
	end process;
	 
	adc_sim: process
		variable adc : std_logic_vector(7 downto 0) := "00000000";
		variable seven_seg1_exp, seven_seg0_exp : std_logic_vector(6 downto 0) := "0000000";
		
		type bcd_7_table is array (natural range <>) of std_logic_vector(6 downto 0);
		constant bcd_vals : bcd_7_table := ("1111110", "0110000", "1101101",
		"1111001", "0110011", "1011011", "1011111", "1110000", "1111111", "1111011");
		
	begin
		for i in 0 to 99 loop	-- generate adc result values from 0 to 99
			adc := std_logic_vector(to_unsigned(i, 8));
			adc_out <= adc(7);	-- value shifted out of adc
			wait until falling_edge(clk);	-- suspend process to update adc_out
			
			for j in 7 downto 0 loop	-- shift result bits out
				wait until falling_edge(sclk);	-- on falling edge of sclk				
				adc := adc(6 downto 0) & '0';		-- shift next adc bit out
				adc_out <= adc(7);
				wait until falling_edge(clk);	-- suspend process to update adc_out								
			end loop;
			
			wait for 4 * period;
			
			seven_seg1_exp := not bcd_vals(i/10);	-- compute expected values
			seven_seg0_exp := not bcd_vals(i mod 10);
			assert (seven_seg1 = seven_seg1_exp) and (seven_seg0 = seven_seg0_exp)
			report "Error for i = " & integer'image(i) &
			" seven_seg1 = " & to_string(seven_seg1) & " expected " & to_string(seven_seg1_exp) &
			" seven_seg0 = " & to_string(seven_seg0) & " expected " & to_string(seven_seg0_exp)
			severity error;			
		end loop;
		
		end_sim <= true;	-- stop system clock to stop simulation
	end process;
		
end tb_architecture;



