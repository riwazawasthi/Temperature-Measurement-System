library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
entity bin7_bcd is 
	port(
	 bin : in std_logic_vector(7 downto 0); -- 7-bit binary input 
     bcd0 :out std_logic_vector(3 downto 0);-- least significant BCD digit bcd1 : out std_logic_vector(3 downto 0) 
     bcd1 : out std_logic_vector(3 downto 0)); -- most significant BCD digit 
end bin7_bcd; 
architecture behaviour of bin7_bcd is
begin
	process(bin)
	variable bcd:unsigned(7 downto 0); 
	variable temp:std_logic_vector(7 downto 0);
	begin  
		bcd:=(others=>'0');
		temp(7 downto 0):=bin;
		for i in 7 downto 0 loop
			bcd(7 downto 1):= bcd(6 downto 0);--shifting the bits
			bcd(0):=temp(i);
			if (i>0 and bcd(3 downto 0)>"0100") then
				bcd(3 downto 0):=bcd(3 downto 0)+ "0011";
			end if;	 
			if (i>0 and bcd(7 downto 4) > "0100") then
				bcd(7 downto 4) := bcd(7 downto 4) + "0011" ;
            end if ;

		end loop;
		bcd0<=std_logic_vector(bcd(3 downto 0));
		bcd1<=std_logic_vector(bcd(7 downto 4));
	end process;
end behaviour;

			

