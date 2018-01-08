library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM is
    Port ( nCe : in  STD_LOGIC;
           inRAM : in  STD_LOGIC_VECTOR (3 downto 0);
           outRAM : out  STD_LOGIC_VECTOR (7 downto 0));
end RAM;

architecture Behavioral of RAM is
	signal ROM : STD_LOGIC_VECTOR (7 downto 0);
begin
	process(inRAM)
	begin
		case inRAM is
			when "0000" => ROM <= "00001001";		-- LDA	9h
			when "0001" => ROM <= "00011010";		-- ADD	10h
			when "0010" => ROM <= "00101011";		-- SUBB  11h
			when "0011" => ROM <= "11100000";		-- OUT
			when "0100" => ROM <= "11110000";		-- Halt";		
			when "0101" => ROM <= "00000000";   
			when "0110" => ROM <= "00000001";
			when "0111" => ROM <= "00000010";
			when "1000" => ROM <= "00000011";
			when "1001" => ROM <= "00000111";	--	1
			when "1010" => ROM <= "00000010";	-- 2
			when "1011" => ROM <= "00000101";	-- 3
			when "1100" => ROM <= "00000010";	-- 2	
			when "1101" => ROM <= "00000000";
			when "1110" => ROM <= "00000000";
			when "1111" => ROM <= "11110000";
			when others	=> ROM <= "00000000";
		end case;	
	end process;
	outRAM <= ROM when nCe='0' else "ZZZZZZZZ";
end Behavioral;

