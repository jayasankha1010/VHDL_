--VHDL code for a two bit Comparator
--returns 0 when two inputs A, B are different
--Return 1 when two inputs are similar
--Used Architecture BOOL

library ieee;                                	
use ieee.std_logic_1164.all;           	
                                             		
entity comparator2 is port (                 	
    A, B: in std_logic_vector(1 downto 0); 
    Equals: out std_logic);            		
end comparator2;                             	

architecture bool of comparator2 is 
begin
	Equals <= not(A(1) xor B(1)) and not(A(0) xor B(0));
end bool;