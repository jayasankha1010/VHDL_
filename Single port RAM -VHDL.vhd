--Single port RAM 
--Write or Read, only one at a time
--using Wren - Write enabled to the address
--otherwise always reads address and outputs


LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

ENTITY RAM128_32 IS
	PORT
	(
		address	    : IN STD_LOGIC_VECTOR (6 DOWNTO 0); --address read or write
		clock		: IN STD_LOGIC  := '1';             --clock for sync
		wren		: IN STD_LOGIC ;                    --enabling writing
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);--input data to the ram
		q		    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)--output from the ram
	);
END RAM128_32;


architecture arch_ram of RAM128_32 is   
  type ram_type is array (127 downto 0)   
        of std_logic_vector (31 downto 0);   
  signal RAM : ram_type;   
begin   
  process (clock)   
  begin   
    if (rising_edge(clock)) then   
      if (wren = '1') then   
        RAM(conv_integer(address)) <= data;   
      end if;   
    end if;   
  end process;   
  q <= RAM(conv_integer(address));   
end arch_ram; 

