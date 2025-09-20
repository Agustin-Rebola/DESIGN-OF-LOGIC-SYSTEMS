library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity boolean_equation is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC
           );
end boolean_equation;

architecture dataflow of boolean_equation is
    signal temp : std_logic_vector (3 downto 0);
begin 
    temp(3) <= not X(1) and not X(0) and not Y(1) and not Y(0);
    temp(2) <= not X(1) and     X(0) and not Y(1) and     Y(0);
    temp(1) <=     X(1) and not X(0) and     Y(1) and not Y(0);
    temp(0) <=     X(1) and     X(0) and     Y(1) and     Y(0);
    Z <= temp(3) or temp(2) or temp(1) or temp (0);
end dataflow;
