-- shifter.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shifter is
    Port (
        a   : in  STD_LOGIC_VECTOR(5 downto 0);
        b   : in  STD_LOGIC_VECTOR(2 downto 0);
        sel : in  STD_LOGIC_VECTOR(1 downto 0);
        r   : out STD_LOGIC_VECTOR(5 downto 0)
    );
end shifter;

architecture Behavioral of shifter is
begin
    process(a, b, sel)
    begin
        case sel is
            when "00" | "01" => -- logical left
                r <= a sll to_integer(unsigned(b));
            when "10" => -- logical right
                r <= a srl to_integer(unsigned(b));
            when others => -- arithmetic right
                r <= std_logic_vector(shift_right(signed(a), to_integer(unsigned(b))));
        end case;
    end process;
end Behavioral;
