library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity PC is
    Port ( nCLK 	 : in  STD_LOGIC;
           nCLR 	 : in  STD_LOGIC;
           Cp 		 : in  STD_LOGIC;
           Ep 		 : in  STD_LOGIC;
           BUS_Low : out  STD_LOGIC_VECTOR (3 downto 0);
			  T 		 : out  STD_LOGIC_VECTOR (2 downto 0));
end PC;

architecture Behavioral of PC is
	signal q: STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal sig_T: STD_LOGIC_VECTOR (2 downto 0):="000";
begin
	process(nCLK, nCLR, Cp,Ep)
	begin
		if falling_edge(nCLK) then
			if Cp = '1' then q <= q+1; 		end if;
			if nCLR = '1' then q <= "0000"; 	end if;
			sig_T <= sig_T + 1;
			if sig_T = "110" then sig_T <= "000"; end if;
		end if;
	end process;
	T <= sig_T;
	BUS_Low <= q when Ep='1' else "ZZZZ";
end Behavioral;

