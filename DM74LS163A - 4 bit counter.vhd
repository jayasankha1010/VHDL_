LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;


architecture archi of AAC2M2P1 is  
signal tmp: std_logic_vector(3 downto 0);
begin
	count_proc : process (CP) 
	begin 
		if (rising_edge(CP)) then
			if (SR='0') then   
				   tmp <= "0000";
			elsif (PE='0') then
				   tmp <=P;
			elsif (CEP='1' and CET='1') then 
				   tmp <= tmp + 1;
			end if;  
		end if;	
	end process count_proc; 
	Q <= tmp;
	
	overflow : process (Q)
	begin
		if (Q ="1111") then
			TC<='1';
		else 
			TC<='0';
		end if;
	end process overflow;
 end archi;
			 
