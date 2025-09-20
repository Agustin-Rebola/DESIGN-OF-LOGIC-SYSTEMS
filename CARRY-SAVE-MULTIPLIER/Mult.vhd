--Agustin Rebola Perricone
--Lab 4
--mult.vhd

library ieee;
use ieee.std_logic_1164.all;

entity mult is
    port(
        clk : in std_logic;
        a   : in std_logic_vector(7 downto 0);
        b   : in std_logic_vector(7 downto 0);
        p   : out std_logic_vector(15 downto 0)
    );
end mult;

architecture structural of mult is
    component carry_save_mult is
        generic(n : integer := 8);
        port(
            a : in std_logic_vector(n-1 downto 0);
            b : in std_logic_vector(n-1 downto 0);
            p : out std_logic_vector(2*n-1 downto 0)
        );
    end component;

    signal a_reg, b_reg : std_logic_vector(7 downto 0);
    signal p_s          : std_logic_vector(15 downto 0);

begin
    inst_csm: carry_save_mult
        port map (a => a_reg, b => b_reg, p => p_s);

    reg_mult : process(clk)
    begin
        if rising_edge(clk) then
            a_reg <= a;
            b_reg <= b;
            p     <= p_s;
        end if;
    end process reg_mult;

end structural;
