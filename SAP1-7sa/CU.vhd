library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           ctrl_bus : out  STD_LOGIC_VECTOR (11 downto 0):="001111100011"
			 );
end CU;

architecture Behavioral of CU is
	type state_type is (t1,t2,t3,t4,t5,t6);
	signal t_state: state_type;
	
begin
	process(CLK,CLR)
	begin
		if CLR ='1' then t_state <=t1;
		elsif rising_edge(CLK) then 
			case t_state is
				when t1 => t_state <=t2;
				when t2 => t_state <=t3;
				when t3 => t_state <=t4;
				when t4 => t_state <=t5;
				when t5 => t_state <=t6;
				when t6 => t_state <=t1;
			end case;
		end if;
	end process;
	process(clk)
	begin
		if falling_edge(CLK) then -- Cp, Ep, nLm, nCe, nLi, nEi, nLa, Ea, Su, Eu, nLb, nLo
			case opcode is
				when "0000" =>			-- LD A
					case t_state is
						when t1 => ctrl_bus <="010111100011";	
						when t2 => ctrl_bus <="101111100011";	
						when t3 => ctrl_bus <="001001100011";	
						when t4 => ctrl_bus <="000110100011";	
						when t5 => ctrl_bus <="001011000011";	
						when t6 => ctrl_bus <="001111100011";	--No Operation
					end case;
				when "0001" =>			-- ADD
					case t_state is
						when t1 => ctrl_bus <="010111100011";	
						when t2 => ctrl_bus <="101111100011";	
						when t3 => ctrl_bus <="001001100011";	
						when t4 => ctrl_bus <="000110100011";	
						when t5 => ctrl_bus <="001011100001";	
						when t6 => ctrl_bus <="001111000111";	
					end case;
				when "0010" =>			-- SUBB
					case t_state is
						when t1 => ctrl_bus <="010111100011";	
						when t2 => ctrl_bus <="101111100011";	
						when t3 => ctrl_bus <="001001100011";	
						when t4 => ctrl_bus <="000110100011";	
						when t5 => ctrl_bus <="001011100001";	
						when t6 => ctrl_bus <="001111001111";	
					end case;	
				when "1110" =>			-- OUT
					case t_state is
						when t1 => ctrl_bus <="010111100011";	
						when t2 => ctrl_bus <="101111100011";	
						when t3 => ctrl_bus <="001001100011";	
						when t4 => ctrl_bus <="001111110010";	
						when t5 => ctrl_bus <="001111100011";	
						when t6 => ctrl_bus <="001111100011";	
					end case;		
				when "1111" =>			-- OUT
					case t_state is
						when t1 => ctrl_bus <="010111100011";	
						when t2 => ctrl_bus <="101111100011";	
						when t3 => ctrl_bus <="001001100011";	
						when t4 => ctrl_bus <="001111100011";	
						when t5 => ctrl_bus <="001111100011";	
						when t6 => ctrl_bus <="001111100011";	
					end case;			
				when others => ctrl_bus <="001111100011";
				end case;	
		end if;
	end process;
end Behavioral;

