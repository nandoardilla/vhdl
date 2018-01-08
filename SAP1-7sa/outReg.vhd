library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity outReg is
    Port ( CLK : in  STD_LOGIC;
           nLo : in  STD_LOGIC;
           inReg : in  STD_LOGIC_VECTOR (7 downto 0);
           LED : out  STD_LOGIC_VECTOR (7 downto 0));
end outReg;

architecture Behavioral of outReg is
begin
	process (CLK)
	begin
		if rising_edge(CLK) then
			if nLo='0' then 
				LED <= inReg;
			end if;	
		end if;
	end process;
end Behavioral;