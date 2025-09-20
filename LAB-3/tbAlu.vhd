-- tb_alu.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_alu is
end tb_alu;

architecture behavior of tb_alu is
    signal sel : STD_LOGIC_VECTOR(3 downto 0);
    signal a, b, r : STD_LOGIC_VECTOR(5 downto 0);

    component alu
        Port (
            sel : in  STD_LOGIC_VECTOR(3 downto 0);
            a   : in  STD_LOGIC_VECTOR(5 downto 0);
            b   : in  STD_LOGIC_VECTOR(5 downto 0);
            r   : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

begin
    uut: alu port map (sel => sel, a => a, b => b, r => r);

    process
    begin
        for i in 0 to 15 loop
            sel <= std_logic_vector(to_unsigned(i, 4));

            a <= "000100"; b <= "000010"; wait for 10 ns;
            a <= "110001"; b <= "110010"; wait for 10 ns;
            a <= "111111"; b <= "111111"; wait for 10 ns;
        end loop;
        wait;
    end process;
end behavior;
