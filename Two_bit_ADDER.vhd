library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity FullAdd is port ( 
A, B, Cin: in std_logic; 
Sum, Cout: out std_logic); 
end FullAdd;

architecture behavioral of FullAdd is
	signal Out2bit : std_logic_vector(1 downto 0);
begin 
	Out2bit <= std_logic_vector(unsigned'('0'&A) +unsigned'('0'&B) + unsigned'('0'&cin));
	Sum <= Out2bit(0); -- last bit
	Cout  <= Out2bit(1); --first bit
end architecture behavioral;
