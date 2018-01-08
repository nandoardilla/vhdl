library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SAP1 is
    Port ( CLK 	: in  STD_LOGIC;
           CLR 	: in  STD_LOGIC;
			  T	 	: out  STD_LOGIC_VECTOR (2 downto 0);
			  outCU 	: out  STD_LOGIC_VECTOR (11 downto 0);
           wbus 	: out  STD_LOGIC_VECTOR (7 downto 0);
			  LED 	: out  STD_LOGIC_VECTOR (7 downto 0)	  );
end SAP1;

architecture Behavioral of SAP1 is
	component PC is
		Port ( nCLK : in  STD_LOGIC;
				 nCLR : in  STD_LOGIC;
             Cp 		: in  STD_LOGIC;
				 Ep 		: in  STD_LOGIC;
				 BUS_Low : out  STD_LOGIC_VECTOR (3 downto 0);
				 T 		 : out  STD_LOGIC_VECTOR (2 downto 0)	);
	end component;
	component MAR is
		Port ( CLK : in  STD_LOGIC;
				 nLm : in  STD_LOGIC;
				 inMAR : in  STD_LOGIC_VECTOR (3 downto 0);
				 outMAR : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	component RAM is
		Port ( nCe : in  STD_LOGIC;
				 inRAM : in  STD_LOGIC_VECTOR (3 downto 0);
				 outRAM : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component IR  is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 nLi : in  STD_LOGIC;
				 nEI : in  STD_LOGIC;
				 inIR : in  STD_LOGIC_VECTOR (7 downto 0);
				 outIRlow : out  STD_LOGIC_VECTOR (3 downto 0);
				 outIRhigh : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	component CU  is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
             opcode : in  STD_LOGIC_VECTOR (3 downto 0);
				 ctrl_bus : out  STD_LOGIC_VECTOR (11 downto 0));
	end component;		  
	component regA is
		Port ( CLK 	: in  STD_LOGIC;
				 nLa 	: in  STD_LOGIC;
				 Ea 	: in  STD_LOGIC;
             inA 	: in   STD_LOGIC_VECTOR (7 downto 0);
             outA : out  STD_LOGIC_VECTOR (7 downto 0);
             regACC : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component ALU is
		Port ( Su : in  STD_LOGIC;
				 Eu : in  STD_LOGIC;
				 inA : in  STD_LOGIC_VECTOR (7 downto 0);
             inB : in  STD_LOGIC_VECTOR (7 downto 0);
             result : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;	
	component regB is
		Port ( CLK : in  STD_LOGIC;
				 nLb : in  STD_LOGIC;
				 inB : in  STD_LOGIC_VECTOR (7 downto 0);
				 outB : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component outReg is
		Port ( CLK : in  STD_LOGIC;
				 nLo : in  STD_LOGIC;
             inReg : in  STD_LOGIC_VECTOR (7 downto 0);
             LED : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	signal sig_bus : STD_LOGIC_VECTOR (7 downto 0):="00000000";
	signal sig_MARtoRAM : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal AtoAlu : STD_LOGIC_VECTOR (7 downto 0):="00000000";
	signal BtoAlu : STD_LOGIC_VECTOR (7 downto 0):="00000000";
	signal IRtoCU : STD_LOGIC_VECTOR (3 downto 0):="0000";
	
	signal ctrl_bus : STD_LOGIC_VECTOR (11 downto 0):="001111100011";
	
begin
	u1: PC port map(
			nCLK 	=> CLK,
			nCLR 	=> CLR,
         Cp  	=> ctrl_bus(11),		--Cp,
			Ep 	=> ctrl_bus(10),		--Ep,
			BUS_Low => sig_bus(3 downto 0),
			T 		  => T							);		-- untuk monitoring State
	u2: MAR port map(
			CLK 	=> CLK,
			nLm 	=> ctrl_bus(9),		--nLm,
			inMAR =>  sig_bus(3 downto 0),
			outMAR => sig_MARtoRAM				);		
	u3: RAM port map(
			nCe 	=> ctrl_bus(8),		--nCe,
			inRAM => sig_MARtoRAM,
			outRAM => sig_bus						);
	u4: IR port map(
			CLK 	=> CLK,
			CLR 	=> CLR,
			nLi 	=> ctrl_bus(7),		--nLi,
			nEi 	=> ctrl_bus(6),		--nEi,
			inIR  => sig_bus,
			outIRlow  => sig_bus(3 downto 0),
			outIRhigh => IRtoCU			);			
	u6: regA port map(
			CLK 	=> CLK,
         nLa 	=> ctrl_bus(5),		--nLa,
         Ea 	=> ctrl_bus(4),		--ea,
         inA   => sig_bus,
         outA 	=> sig_bus,
         regACC => AtoAlu				);
	u7: ALU port map(
			Su 	=> ctrl_bus(3),		--Su,
			Eu 	=> ctrl_bus(2),		--Eu,
			inA 	=> AtoAlu,
         inB 	=> BtoAlu,
         result => sig_bus				);
	u8: regB port map(
			CLK 	=> CLK,
         nLb 	=> ctrl_bus(1),		--nLb,
         inB 	=> sig_bus,
         outB 	=> BtoAlu				);
	u9: outReg port map(		
			CLK 	=> CLK,
         nLo 	=> ctrl_bus(0),		--nLo,
         inReg => sig_bus,
         LED 	=> LED					);
		
	u5: CU port map(
			CLK 	=> CLK,
			CLR 	=> CLR,
         opcode => IRtoCU,
			ctrl_bus => ctrl_bus			);
		
	wbus <= sig_bus;	
	outCU <= ctrl_bus;
end Behavioral;

