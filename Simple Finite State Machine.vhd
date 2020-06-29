library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity FSM is 
	generic(
	A : std_logic_vector(1 downto 0) := "00";
	B : std_logic_vector(1 downto 0) := "01";
	C : std_logic_vector(1 downto 0) := "10");
	
	port (
	In1: in std_logic;
	RST: in std_logic; 
	CLK: in std_logic;
	Out1 : inout std_logic); 
end FSM;

architecture arch of FSM is
	signal CurrentState : std_logic_vector(1 downto 0):= "00";
	signal NextState : std_logic_vector(1 downto 0);
begin 
	comb_proc: process (In1, CurrentState,CLK)
	begin 
		case(CurrentState) is
			when "00" => 
				Out1 <= '0';
				if (In1 = '1') then NextState <= "01";
				else                NextState <= "00";
				end if;
			when "01" =>
				Out1 <= '0';
				if (In1 = '0') then NextState <= "10";
				else                NextState <= "01";
				end if;
			when "10" =>
				Out1 <= '1';
				if (In1 = '1') then NextState <= "00";
				else                NextState <= "10";
				end if;
			when others =>          NextState <= "00";
		end case;
	end process comb_proc;
	
	clk_proc : process (CLK, RST) 
	begin
		if (RST = '1') then CurrentState <= "00";
		elsif (rising_edge(CLK)) then CurrentState<= NextState;
		end if;
	end process clk_proc;
end architecture arch;
	