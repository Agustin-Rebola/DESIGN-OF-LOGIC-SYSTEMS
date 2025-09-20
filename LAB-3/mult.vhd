-- mult.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mult is
    Port (
        a   : in  STD_LOGIC_VECTOR(5 downto 0);
        b   : in  STD_LOGIC_VECTOR(5 downto 0);
        sel : in  STD_LOGIC;
        r   : out STD_LOGIC_VECTOR(5 downto 0)
    );
end mult;

architecture Behavioral of mult is
    signal product : STD_LOGIC_VECTOR(11 downto 0);
begin
    product <= a * b;
    process(sel, product)
    begin
        if sel = '0' then
            r <= product(5 downto 0);
        else
            r <= product(11 downto 6);
        end if;
    end process;
end Behavioral;
