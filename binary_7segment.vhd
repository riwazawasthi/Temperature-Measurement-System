library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity binary_7segment is
port( binary : in std_logic_vector(7 downto 0);-- 7-bit binary input 
seven_seg0,seven_seg1 : out std_logic_vector(6 downto 0) -- 7seg outputs     
); 
end binary_7segment;
architecture structure of binary_7segment is 
component bin7_bcd
	port( bin : in std_logic_vector(7 downto 0); -- 7-bit binary input 
     bcd0 :out std_logic_vector(3 downto 0);-- least significant BCD digit bcd1 : out std_logic_vector(3 downto 0) 
     bcd1 : out std_logic_vector(3 downto 0)); -- most significant BCD digit 
end component; 
component bcd_seven
	port(bcd : in std_logic_vector(3 downto 0); -- 4 bit BCD input 
		 seg_drive : out STD_LOGIC_Vector(6 downto 0)
		 );
end component;	
signal s0,s1: std_logic_vector(3 downto 0);
begin 
	u1:bin7_bcd port map(bin=>binary,bcd0=>s0,bcd1=>s1);
	u2:bcd_seven port map(bcd=>s0,seg_drive=>seven_seg0);
	u3:bcd_seven port map(bcd=>s1,seg_drive=>seven_seg1);
end structure;
