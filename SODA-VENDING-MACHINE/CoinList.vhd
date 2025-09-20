--coin_list.vhd
library ieee;
use ieee.std_logic_1164.all;

entity coin_list is
    port(
        sel         : in  std_logic_vector(1 downto 0);
        amt         : out std_logic_vector(11 downto 0)
    );
end coin_list;

architecture data_flow of coin_list is
begin
    with sel select amt <=
        x"001" when "00",
        x"005" when "01",
        x"00A" when "10",
        x"019" when "11",
        x"000" when others;
end data_flow;
