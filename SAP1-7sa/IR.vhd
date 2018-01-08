library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IR is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           nLi : in  STD_LOGIC;
           nEi : in  STD_LOGIC;
           inIR : in  STD_LOGIC_VECTOR (7 downto 0);
           outIRlow : out  STD_LOGIC_VECTOR (3 downto 0);
           outIRhigh : out  STD_LOGIC_VECTOR (3 downto 0));
end IR;

architecture Behavioral of IR is
	signal regBuff : STD_LOGIC_VECTOR (7 downto 0);
begin
	process (CLK,CLR)
	begin
		if rising_edge(CLK) then  
			if CLR = '1' then
				regBuff <="00000000";
				outIRlow <="ZZZZ";
			elsif nLi='0' then 	
				regBuff <= inIR;
				outIRlow <= "ZZZZ";
			end if;
		end if;	
	end process;
	outIRlow <= regBuff(3 downto 0) when nEi='0' else "ZZZZ";
	outIRhigh <= regBuff(7 downto 4); 
end Behavioral;

