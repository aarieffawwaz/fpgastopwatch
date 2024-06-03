library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clocks is
Port(
	CLK : in STD_LOGIC;
	clock : out STD_LOGIC;
	clock_centi : out STD_LOGIC
);
end clocks;

architecture Behavioral of clocks is

  signal clk1, clk2 : STD_LOGIC;

begin
  clk : process (CLK) 
variable count1 : unsigned (15 downto 0):="00000000000000000";
begin
	if (rising_edge(CLK)) then
		if count1 = "10000111100011011" then --counting to 69443 or 720 Hz / 120 FPS
			clk1 <= not clk1;
			count1 := "00000000000000000";
		end if;
		count1 := count1 + 1;
	end if;
end process;
	clk_centi : process (CLK) --clock that runs at 0.5MHz to count in centiseconds
variable count2 : unsigned (18 downto 0):="0000000000000000000";
begin
	if (rising_edge(CLK)) then
		if count2 = "1111010000100100000" then --counting to 499999
			clk2 <= not clk2;
			count2 := "0000000000000000000";
		end if;
		count2 := count2 + 1;
	end if;
end process;
	clock <= clk1; --setting this clock to a signal to make input for display module
	clock_centi <= clk2; --setting this clock to a signal to make input for display module
end Behavioral;
