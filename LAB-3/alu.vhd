-- alu.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port (
        sel : in  STD_LOGIC_VECTOR(3 downto 0);
        a   : in  STD_LOGIC_VECTOR(5 downto 0);
        b   : in  STD_LOGIC_VECTOR(5 downto 0);
        r   : out STD_LOGIC_VECTOR(5 downto 0)
    );
end alu;

architecture Behavioral of alu is
    component adder
        Port ( a, b : in STD_LOGIC_VECTOR(5 downto 0);
               sel  : in STD_LOGIC_VECTOR(1 downto 0);
               r    : out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    component mult
        Port ( a, b : in STD_LOGIC_VECTOR(5 downto 0);
               sel  : in STD_LOGIC;
               r    : out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    component logic_unit
        Port ( a, b : in STD_LOGIC_VECTOR(5 downto 0);
               sel  : in STD_LOGIC_VECTOR(1 downto 0);
               r    : out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    component shifter
        Port ( a : in STD_LOGIC_VECTOR(5 downto 0);
               b : in STD_LOGIC_VECTOR(2 downto 0);
               sel : in STD_LOGIC_VECTOR(1 downto 0);
               r : out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    signal r_adder, r_mult, r_logic, r_shift : STD_LOGIC_VECTOR(5 downto 0);

begin
    U1: adder port map (a => a, b => b, sel => sel(1 downto 0), r => r_adder);
    U2: mult port map (a => a, b => b, sel => sel(0), r => r_mult);
    U3: logic_unit port map (a => a, b => b, sel => sel(1 downto 0), r => r_logic);
    U4: shifter port map (a => a, b => b(2 downto 0), sel => sel(1 downto 0), r => r_shift);

    process(sel, r_adder, r_mult, r_logic, r_shift)
    begin
        case sel(3 downto 2) is
            when "00" => r <= r_adder;
            when "01" => r <= r_mult;
            when "10" => r <= r_logic;
            when others => r <= r_shift;
        end case;
    end process;
end Behavioral;
