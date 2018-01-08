library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity ALU is
    Port ( Su : in  STD_LOGIC;
           Eu : in  STD_LOGIC;
           inA : in  STD_LOGIC_VECTOR (7 downto 0);
           inB : in  STD_LOGIC_VECTOR (7 downto 0);
           result : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is
	signal hasil: STD_LOGIC_VECTOR (7 downto 0);
begin
	hasil <= inA+inB when Su='0' else inA-inB;
	result <= hasil when Eu='1' else "ZZZZZZZZ";
end Behavioral;

