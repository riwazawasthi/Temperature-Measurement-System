library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_seven is
	port(
		bcd : in std_logic_vector(3 downto 0); -- 4 bit BCD input
		seg_drive : out std_logic_vector(6 downto 0) -- segments a ...g
);
end bcd_seven;

architecture table of bcd_seven is

type table_type is array (0 to 15) of std_logic_vector(6 downto 0);
constant table_values : table_type := (
"0000001",	 
"1001111",
"0010010",
"0000110",
"1001100", 
"0100100",
"0100000",
"0001111",
"0000000",
"0000100",
"1111111",	
"1111111",
"1111111",
"1111111",
"1111111",
"1111111"
);

begin

seg_drive<=table_values(to_integer(unsigned(bcd)));
	
end table;