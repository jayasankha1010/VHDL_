LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT( 
	Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
	A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
END ALU;

architecture arch_ALU of ALU is

begin 
	alu_proc : process(Op_code, A,B)
	begin
		case(Op_code) is
			when "000" =>           -- Output A
				Y <= A;
			when "001" =>           -- Output A+B
				Y <= A+B;
			when "010" =>           -- Output A-B
				Y <= A-B;
			when "011" =>           -- Output A and B
				Y <= A and B;
			when "100" =>           -- Output A or B
				Y <= A or B;
			when "101" =>           -- Output A+1
				Y <= A+1;
			when "110" =>           -- Output A-1
				Y <= A-1;
			when "111" =>           -- Output B
				Y <= B;
			when others => 
				
		end case;
	end process alu_proc;
end architecture arch_ALU;
