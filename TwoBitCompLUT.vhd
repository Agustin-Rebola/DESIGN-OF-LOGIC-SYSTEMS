

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.vcomponents.all;

entity LUT_primitive is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC
           );
end LUT_primitive;

architecture primitive of LUT_primitive is
    signal temp : std_logic_vector (3 downto 0);
begin 
    LUT4_inst : LUT4
    generic map (
        INIT => X"8421")
    port map (
        O => z,
        I0 => x(0),
        I1 => x(1),
        I2 => y(0),
        I3 => y(1)
        );
        
end primitive;