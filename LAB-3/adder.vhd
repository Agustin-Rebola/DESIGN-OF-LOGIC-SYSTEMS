-- adder.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
    Port (
        a   : in  STD_LOGIC_VECTOR(5 downto 0);
        b   : in  STD_LOGIC_VECTOR(5 downto 0);
        sel : in  STD_LOGIC_VECTOR(1 downto 0);
        r   : out STD_LOGIC_VECTOR(5 downto 0)
    );
end adder;

architecture Behavioral of adder is
    signal result : STD_LOGIC_VECTOR(6 downto 0);
    signal b_comp : STD_LOGIC_VECTOR(5 downto 0);
    signal carry  : STD_LOGIC;
begin
    process(a, b, sel)
    begin
        case sel is
            when "00" => -- a + b
                result <= ('0' & a) + ('0' & b);
                r <= result(5 downto 0);
            when "01" => -- carry of a + b
                result <= ('0' & a) + ('0' & b);
                r <= "00000" & result(6);
            when "10" => -- a - b
                b_comp <= not b + 1;
                result <= ('0' & a) + ('0' & b_comp);
                r <= result(5 downto 0);
            when others => -- borrow of a - b
                b_comp <= not b + 1;
                result <= ('0' & a) + ('0' & b_comp);
                r <= "00000" & result(6);
        end case;
    end process;
end Behavioral;
