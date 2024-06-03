library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sevenseg is
    Port (
        button      : in STD_LOGIC;
        RST         : in STD_LOGIC;
        CLK         : in STD_LOGIC;
        clock   	: in STD_LOGIC;
        clock_centi : in STD_LOGIC;
        anode       : out STD_LOGIC_VECTOR (5 downto 0);
        cathode     : out STD_LOGIC_VECTOR (7 downto 0)
    );
end sevenseg;

architecture Behavioral of sevenseg is
    signal a, b, c, d, x, y   : integer := 0; -- for the 6 LEDs on the seven-segment display
    signal PS, NS              : STD_LOGIC_VECTOR (1 downto 0) := "00"; -- present state/next state
    signal ss1, ss2, en       : STD_LOGIC := '0';

begin
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process;

    adding : process (button, RST, clock_centi, PS, NS, ss1, ss2)
    begin
        if RST = '1' then
            a <= 0;
            b <= 0;
            c <= 0;
            d <= 0;
            x <= 0;
            y <= 0;
        else
            if (rising_edge(clock_centi)) then
                if button = '1' then
                    ss1 <= '1';
                elsif button = '0' then
                    ss1 <= '0';
                end if;
                ss2 <= ss1;
                if ss2 = '0' and ss1 = '1' then
                    en <= not en;
                end if;
                case PS is
                    when "11" =>
                        if en = '1' then
                            NS <= "11";
                            y <= y + 1;
                            if y = 9 then
                                x <= x + 1;
                                y <= 0;
                                if x = 9 then
                                    d <= d + 1;
                                    x <= 0;
                                    if d = 9 then
                                        c <= c + 1;
                                        d <= 0;
                                        if c = 5 then
                                            b <= b + 1;
                                            c <= 0;
                                            if b = 9 then
                                                a <= a + 1;
                                                b <= 0;
                                                if a = 5 then
                                                    a <= 0;
                                                    b <= 0;
                                                    c <= 0;
                                                    d <= 0;
                                                    x <= 0;
                                                    y <= 0;
                                                end if;
                                            end if;
                                        end if;
                                    end if;
                                end if;
                            end if;
                        end if;
                    when others =>
                        if en = '0' then
                            NS <= "00";
                            a <= a;
                            b <= b;
                            c <= c;
                            d <= d;
                            x <= x;
                            y <= y;
                        elsif en = '1' then
                            NS <= "11";
                        end if;
                end case;
            end if;
        end if;
    end process;

    led : process (clock)
        variable digit1, digit2 : unsigned (2 downto 0) := "000";
    begin
        if (rising_edge(clock)) then
            case to_integer(digit1) is
                when 0 =>
                    anode <= "011111";
                when 1 =>
                    anode <= "101111";
                when 2 =>
                    anode <= "110111";
                when 3 =>
                    anode <= "111011";
                when 4 =>
                    anode <= "111101";
                when 5 =>
                    anode <= "111110";
                    when 6 =>
                    anode <= "111111";
                    when 7 =>
                    anode <= "111111";
                when others =>
                    anode <= "111111";
            end case;

            case digit2 is
                when "000" =>
                    case a is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                            cathode <= "10011111";
                        when 2 =>
                            cathode <= "00100101";
                        when 3 =>
                            cathode <= "00001101";
                        when 4 =>
                            cathode <= "10011001";
                        when 5 =>
                            cathode <= "01001001";
                        when 6 =>
                            cathode <= "01000001";
                        when 7 =>
                            cathode <= "00011111";
                        when 8 =>
                            cathode <= "00000001";
                        when 9 =>
                            cathode <= "00011001";
                        when others =>
                            cathode <= "11111111";
                    end case;

                when "001" =>
                    case b is
                        when 0 =>
                            cathode <= "00000010";
                        when 1 =>
                            cathode <= "10011110";
                        when 2 =>
                            cathode <= "00100100";
                        when 3 =>
                            cathode <= "00001100";
                        when 4 =>
                            cathode <= "10011000";
                        when 5 =>
                            cathode <= "01001000";
                        when 6 =>
                            cathode <= "01000000";
                        when 7 =>
                            cathode <= "00011110";
                        when 8 =>
                            cathode <= "00000000";
                        when 9 =>
                            cathode <= "00011000";
                        when others =>
                            cathode <= "11111110";
                    end case;

                when "010" =>
                    case c is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                            cathode <= "10011111";
                        when 2 =>
                            cathode <= "00100101";
                        when 3 =>
                            cathode <= "00001101";
                        when 4 =>
                            cathode <= "10011001";
                        when 5 =>
                            cathode <= "01001001";
                        when 6 =>
                            cathode <= "01000001";
                        when 7 =>
                            cathode <= "00011111";
                        when 8 =>
                            cathode <= "00000001";
                        when 9 =>
                            cathode <= "00011001";
                        when others =>
                            cathode <= "11111111";
                    end case;

                when "011" =>
                    case d is
                        when 0 =>
                            cathode <= "00000010";
                        when 1 =>
                            cathode <= "10011110";
                        when 2 =>
                            cathode <= "00100100";
                        when 3 =>
                            cathode <= "00001100";
                        when 4 =>
                            cathode <= "10011000";
                        when 5 =>
                            cathode <= "01001000";
                        when 6 =>
                            cathode <= "01000000";
                        when 7 =>
                            cathode <= "00011110";
                        when 8 =>
                            cathode <= "00000000";
                        when 9 =>
                            cathode <= "00011000";
                        when others =>
                            cathode <= "11111110";
                    end case;

                when "100" =>
                    case x is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                            cathode <= "10011111";
                        when 2 =>
                            cathode <= "00100101";
                        when 3 =>
                            cathode <= "00001101";
                        when 4 =>
                            cathode <= "10011001";
                        when 5 =>
                            cathode <= "01001001";
                        when 6 =>
                            cathode <= "01000001";
                        when 7 =>
                            cathode <= "00011111";
                        when 8 =>
                            cathode <= "00000001";
                        when 9 =>
                            cathode <= "00011001";
                        when others =>
                            cathode <= "11111111";
                    end case;

                when "101" =>
                    case y is
                        when 0 =>
                            cathode <= "00000011";
                        when 1 =>
                            cathode <= "10011111";
                        when 2 =>
                            cathode <= "00100101";
                        when 3 =>
                            cathode <= "00001101";
                        when 4 =>
                            cathode <= "10011001";
                        when 5 =>
                            cathode <= "01001001";
                        when 6 =>
                            cathode <= "01000001";
                        when 7 =>
                            cathode <= "00011111";
                        when 8 =>
                            cathode <= "00000001";
                        when 9 =>
                            cathode <= "00011001";
                        when others =>
                            cathode <= "11111111";
                    end case;

                when others =>
                    null;
            end case;

            digit1 := digit1 + 1;
            digit2 := digit2 + 1;
        end if;
    end process;

end Behavioral;
