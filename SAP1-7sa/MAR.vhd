library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR is
    Port ( CLK : in  STD_LOGIC;
           nLm : in  STD_LOGIC;
           inMAR : in  STD_LOGIC_VECTOR (3 downto 0);
           outMAR : out  STD_LOGIC_VECTOR (3 downto 0));
end MAR;

architecture Behavioral of MAR is
	signal mar : STD_LOGIC_VECTOR (3 downto 0);
begin
	process(CLK, nLm)
	begin
		if rising_edge(CLK) then
			if nLm = '0' then outMAR <= inMAR; end if;
		end if;
	end process;
end Behavioral;

