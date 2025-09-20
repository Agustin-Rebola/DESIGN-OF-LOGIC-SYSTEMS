library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity when_else is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC
           );
end when_else;

architecture dataflow of when_else is
begin
    Z <= '1' when (X = Y) else '0';      
end DataFlow;
