library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SAP1_7sTop is
    Port ( mclk 	: in  STD_LOGIC;
           clr 	: in  STD_LOGIC;
           a_to_g : out  STD_LOGIC_VECTOR (6 downto 0);
           an 		: out  STD_LOGIC_VECTOR (2 downto 0);
           dp 		: out  STD_LOGIC);
end SAP1_7sTop;

architecture Behavioral of SAP1_7sTop is
	component SAP1 is
		Port ( CLK 	: in  STD_LOGIC;
				 CLR 	: in  STD_LOGIC;
			    T	 	: out  STD_LOGIC_VECTOR (2 downto 0);
				 outCU: out  STD_LOGIC_VECTOR (11 downto 0);
				 wbus : out  STD_LOGIC_VECTOR (7 downto 0);
				 LED 	: out  STD_LOGIC_VECTOR (7 downto 0)	  );
	end component;		
	component x7seg is
		Port ( clk 	: in  STD_LOGIC;
				 clr 	: in  STD_LOGIC;
				 x 	: in STD_LOGIC_VECTOR (31 downto 0);
				 a_to_g : out  STD_LOGIC_VECTOR (6 downto 0);
				 an : out  STD_LOGIC_VECTOR (2 downto 0);
				 dp : out  STD_LOGIC		);
	end component;	
	
	signal x : STD_LOGIC_VECTOR (31 downto 0);
		
begin
	u1: SAP1 port map(
			CLK 	=> mclk,
			CLR	=> clr,
			T	 	=> x(30 downto 28), 
			outCU => x(27 downto 16),	
			wbus 	=> x(15 downto 8),	
			LED 	=> x(7 downto 0)		);

	u2: x7seg port map(
			x 		=> x,	--"12345678",
			clk   => mclk,
			clr 	=> clr,
			a_to_g => a_to_g,
			an 	=> an,
			dp 	=> dp			);
			
	x(31) <= '0';
end Behavioral;

