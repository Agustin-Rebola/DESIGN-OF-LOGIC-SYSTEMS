--soda_list.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soda_list is
    port(
        sel         : in  std_logic_vector(3 downto 0);
        reserved    : out std_logic;
        price       : out std_logic_vector(11 downto 0)
    );
end soda_list;

architecture data_flow of soda_list is
begin
    with sel select price <=
        x"037" when "0000",  --55 cents
        x"055" when "0001",  --85 cents
        x"05F" when "0010",  --95 cents
        x"07D" when "0011",  --125 cents
        x"087" when "0100",  --135 cents
        x"096" when "0101",  --150 cents
        x"0E1" when "0110",  --225 cents
        x"0FA" when "0111",  --250 cents
        x"12C" when "1000",  --300 cents
        x"000" when others;  --reserved

    reserved <= '1' when unsigned(sel) > 8 else '0';
end data_flow;

