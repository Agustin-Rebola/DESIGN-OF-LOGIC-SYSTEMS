-- logic_unit.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_unit is
    Port (
        a   : in  STD_LOGIC_VECTOR(5 downto 0);
        b   : in  STD_LOGIC_VECTOR(5 downto 0);
        sel : in  STD_LOGIC_VECTOR(1 downto 0);
        r   : out STD_LOGIC_VECTOR(5 downto 0)
    );
end logic_unit;

architecture Behavioral of logic_unit is
begin
    process(a, b, sel)
    begin
        case sel is
            when "00" => r <= not a;
            when "01" => r <= a and b;
            when "10" => r <= a or b;
            when others => r <= a xor b;
        end case;
    end process;
end Behavioral;
