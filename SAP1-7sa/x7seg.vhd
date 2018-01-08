library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity x7seg is
	Port ( clk : in  STD_LOGIC;
			 clr : in  STD_LOGIC;
			 x : in STD_LOGIC_VECTOR (31 downto 0);
          a_to_g : out  STD_LOGIC_VECTOR (6 downto 0);
          an : out  STD_LOGIC_VECTOR (2 downto 0);
          dp : out  STD_LOGIC);
end x7seg;

architecture Behavioral of x7seg is
	signal s : STD_LOGIC_VECTOR (2 downto 0);
	signal digit : STD_LOGIC_VECTOR (3 downto 0);
	signal clkdiv : STD_LOGIC_VECTOR (18 downto 0);
	--signal x : STD_LOGIC_VECTOR (31 downto 0);
begin
	s <= clkdiv(18 downto 16);
	an <= s;
	dp <= '1';
--	x <= x"48ABCDEF";
	
-- Quad 8 to 1 mux
	process(s,x)
	begin
		case s is
			when "000" => digit <=x(3 downto 0);
			when "001" => digit <=x(7 downto 4);
			when "010" => digit <=x(11 downto 8);
			when "011" => digit <=x(15 downto 12);
			when "100" => digit <=x(19 downto 16);
			when "101" => digit <=x(23 downto 20);
			when "110" => digit <=x(27 downto 24);
			when others => digit <=x(31 downto 28);
		end case;	
	end process;

-- 7-segment decoder: hex7seg
	process(digit)
	begin
		case digit is
			when x"0" => a_to_g <= "1111110"; -- "0000001";	--0
			when x"1" => a_to_g <= "0110000"; -- "1001111";	--1
			when x"2" => a_to_g <= "1101101"; -- "0010010";	--2
			when x"3" => a_to_g <= "1111001"; -- "0000110";	--3
			when x"4" => a_to_g <= "0110011"; -- "1001100";	--4
			when x"5" => a_to_g <= "1011011"; -- "0100100";	--5
			when x"6" => a_to_g <= "1011111"; -- "0100000";	--6	
			when x"7" => a_to_g <= "1110000"; -- "0001111";	--7
			when x"8" => a_to_g <= "1111111"; -- "0000000";	--8
			when x"9" => a_to_g <= "1111011"; -- "0000100";	--9
			when x"A" => a_to_g <= "1110111"; -- "0001000"; --a
			when x"B" => a_to_g <= "0011111"; -- "1100000";	--b
			when x"C" => a_to_g <= "1001110"; -- "0110001";	--c
			when x"D" => a_to_g <= "0111101"; -- "1000010";	--d
			when x"E" => a_to_g <= "1001111"; -- "0110000";	--e
			when others => a_to_g <= "1000111"; -- "0111000"; 	--f 
		end case;
	end process;

	process(clk, clr)
	begin
		if clr='0' then
			clkdiv <= (others => '0');
		elsif clk'event and clk='1' then
			clkdiv <= clkdiv+1;
		end if;
	end process;

end Behavioral;

