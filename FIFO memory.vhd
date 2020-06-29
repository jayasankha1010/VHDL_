library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIFO8x9 is
port(
	clk, rst: in std_logic;
	RdPtrClr, WrPtrClr: in std_logic;
	RdInc, WrInc: in std_logic;
	DataIn: in std_logic_vector(8 downto 0);
	DataOut: out std_logic_vector(8 downto 0);
	rden, wren: in std_logic);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
--signal declarations
type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0); -- makes use of VHDL’s enumerated type
signal fifo: fifo_array;
signal wrptr, rdptr: std_logic_vector (2 downto 0);
signal en: std_logic_vector(7 downto 0);
signal dmuxout: std_logic_vector(8 downto 0);

begin
-- fifo register_array :
	process (rst, clk)
	begin
		if (rst = '1') then
			for i in 7 downto 0 loop
				fifo(i) <= (others => '0');
			end loop;
		elsif (clk'event and clk = '1') then
			if (wren = '1') then
				for i in 7 downto 0 loop
					if (en(i) = '1') then
						fifo(i) <= datain;
					else
						fifo(i) <= fifo(i);
					end if;
				end loop;
			end if;
		end if;
	end process;

-- read pointer :

process (rst, clk)
begin
	if (rst = '1') then
		rdptr <= (others => '0');
	elsif (clk'event and clk = '1') then
		if (rdptrclr = '1') then
			rdptr <= (others => '0');
		elsif (rdinc = '1' ) then
			rdptr <= rdptr + 1;
		else
			rdptr <= rdptr;
		end if;
	end if;
end process;
-- write pointer :

process (rst, clk)
begin
	if (rst = '1') then
		wrptr <= (others => '0');
	elsif (clk'event and clk = '1') then
		if (wrptrclr = '1') then
			wrptr <= (others => '0');
		elsif (wrinc = '1') then
			wrptr <= wrptr + 1;
		else
			wrptr <= wrptr;
		end if;
	end if;
end process;

-- 8 : 1 out put data mux :

dmuxout <= fifo(0) when rdptr = "000" else
fifo(1) when rdptr = "001" else
fifo(2) when rdptr = "010" else
fifo(3) when rdptr = "011" else
fifo(4) when rdptr = "100" else
fifo(5) when rdptr = "101" else
fifo(6) when rdptr = "110" else
fifo(7) when rdptr = "111" else
(others => 'Z');

-- fifo register select decoder:
en <= "00000001" when wrptr = "000" else
"00000010" when wrptr = "001" else
"00000100" when wrptr = "010" else
"00001000" when wrptr = "011" else
"00010000" when wrptr = "100" else
"00100000" when wrptr = "101" else
"01000000" when wrptr = "110" else
"10000000" when wrptr = "111" else
(others => 'Z');

-- three_state control of outputs :
process (rst, dmuxout)
begin
	if (rden = '1') then
		dataout <= dmuxout;
	else
		dataout <= (others => 'Z');
	end if;
end process;
end RTL;

