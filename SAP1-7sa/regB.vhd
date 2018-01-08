library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regB is
    Port ( CLK : in  STD_LOGIC;
           nLb : in  STD_LOGIC;
           inB : in  STD_LOGIC_VECTOR (7 downto 0);
           outB : out  STD_LOGIC_VECTOR (7 downto 0));
end regB;

architecture Behavioral of regB is
begin
	process (CLK)
	begin
		if rising_edge(CLK) then  
			if nLb = '0' then outB <= inB;
			end if;
		end if;
	end process;
end Behavioral;

