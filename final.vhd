library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity final is
  Port (
    button : in STD_LOGIC;
	CLK : in STD_LOGIC;
	RST : in STD_LOGIC;
	anode : out STD_LOGIC_VECTOR (5 downto 0);
	cathode : out STD_LOGIC_VECTOR (7 downto 0));
end final;

architecture Behavioral of final is
  component clocks
    Port (
		CLK : in STD_LOGIC;
		clock : out STD_LOGIC;
		clock_centi : out STD_LOGIC);
  end component;

  component sevenseg
    Port ( 
		button : in STD_LOGIC;
		RST : in STD_LOGIC;
		CLK : in STD_LOGIC;
		clock : in STD_LOGIC;
		clock_centi : in STD_LOGIC;
		anode : out STD_LOGIC_VECTOR (5 downto 0);
		cathode : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal clk1, clk2 : STD_LOGIC;

begin
	comp0 : clocks port map (CLK => CLK, clock => clk1, clock_centi => clk2);
	comp1 : sevenseg port map (CLK => CLK, clock => clk1, clock_centi => clk2, button => button,RST => RST, anode => anode, cathode => cathode);
end Behavioral;


