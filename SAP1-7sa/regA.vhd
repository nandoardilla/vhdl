library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regA is
    Port ( CLK 	: in  STD_LOGIC;
           nLa 	: in  STD_LOGIC;
           Ea 		: in  STD_LOGIC;
           inA 	: in   STD_LOGIC_VECTOR (7 downto 0);
           outA 	: out  STD_LOGIC_VECTOR (7 downto 0);
           regACC : out  STD_LOGIC_VECTOR (7 downto 0));
end regA;

architecture Behavioral of regA is
	signal sigA : STD_LOGIC_VECTOR (7 downto 0);
begin
	process (CLK)
	begin
		if rising_edge(CLK) then
			if nLa='0' then
				sigA 	 <= inA;
			end if;
		end if;
	end process;
	outA <= sigA when Ea='1' else "ZZZZZZZZ";
	regACC <= sigA; 
end Behavioral;

