--deposit_register.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deposit_register is
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        incr      : in  std_logic;
        incr_amt  : in  std_logic_vector(11 downto 0);
        decr      : in  std_logic;
        decr_amt  : in  std_logic_vector(11 downto 0);
        amt       : out std_logic_vector(11 downto 0) 
    );
end deposit_register;

architecture behavioral of deposit_register is
    signal amt_reg : std_logic_vector(11 downto 0);
begin
    DEPOSIT_REG : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                amt_reg <= x"000";
            elsif incr = '1' then
                amt_reg <= std_logic_vector(unsigned(amt_reg) + unsigned(incr_amt));
            elsif decr = '1' then
                amt_reg <= std_logic_vector(unsigned(amt_reg) - unsigned(decr_amt));
            end if;
        end if;
    end process;

    amt <= amt_reg;
end behavioral;
