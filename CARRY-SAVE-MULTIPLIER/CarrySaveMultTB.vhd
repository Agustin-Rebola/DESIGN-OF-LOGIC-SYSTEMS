--carry_save_mult_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity mult_tb is
end mult_tb;

architecture behavioral of mult_tb is

    component mult
        port(
            clk : in std_logic;
            a   : in std_logic_vector(7 downto 0);
            b   : in std_logic_vector(7 downto 0);
            p   : out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal a, b : std_logic_vector(7 downto 0);
    signal p    : std_logic_vector(15 downto 0);

    file MULT_FILE : text open read_mode is "mult8x8.dat";
    
    constant clk_period : time := 1 ns;

begin
    -- Instantiate multiplier
    uut: mult port map (
        clk => clk,
        a   => a,
        b   => b,
        p   => p
    );

    -- Clock generation
    clk_process: process
begin
    while true loop
        clk <= '0'; wait for clk_period / 2;
        clk <= '1'; wait for clk_period / 2;
    end loop;
end process;

    -- Stimulus process
    stim_proc: process
        variable v_line   : line;
        variable v_a      : std_logic_vector(7 downto 0);
        variable v_b      : std_logic_vector(7 downto 0);
        variable v_p_exp  : std_logic_vector(15 downto 0);
    begin
        while not endfile(MULT_FILE) loop
            readline(MULT_FILE, v_line);
            hread(v_line, v_a);
            hread(v_line, v_b);
            hread(v_line, v_p_exp);

            a <= v_a;
            b <= v_b;
            wait for 20 ns;
            
        end loop;

        wait;
    end process;

end behavioral;
