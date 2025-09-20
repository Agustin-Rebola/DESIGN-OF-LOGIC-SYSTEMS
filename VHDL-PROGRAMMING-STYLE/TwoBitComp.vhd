---------- Two bit comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_then_else is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC
           );
end if_then_else;

architecture behavioral of if_then_else is
begin
    process (X,Y)
    begin
        if(X = Y) then 
            Z <= '1';
        else
            Z <= '0';
        end if;
    end process;   
end behavioral;

---------- Two bit comparator data flow

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

---------- Two bit comparator boolean data flow

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

---------- Two bit comparator LUT

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

---------- Top comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_comparator is
    Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC_VECTOR (3 downto 0) 
           );
end top_comparator;

architecture structural of top_comparator is
    component if_then_else
        Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC 
           );
    end component;
    
    component when_else
        Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC 
           );
    end component;
    
    component boolean_equation
        Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC 
           );
    end component;
    
    component LUT_primitive
        Port ( X : in STD_LOGIC_VECTOR (1 downto 0);
           Y : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC 
           );
    end component;

begin
    if_then_else0 : if_then_else
        port map( 
            X => X,
            Y => Y,
            Z => Z(3)
        );
        
    when_else0 : when_else
        port map( 
            X => X,
            Y => Y,
            Z => Z(2)
        );
        
    boolean_equation0 : boolean_equation
        port map( 
            X => X,
            Y => Y,
            Z => Z(1)
        );
        
    LUT_PRIMITIVE0 : LUT_primitive
        port map( 
            X => X,
            Y => Y,
            Z => Z(3)
        );            

end structural;

---------- Testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity comparator_tb is
end comparator_tb;

architecture behavioral of comparator_tb is

    component top_comparator
    port(
        X : in std_logic_vector(1 downto 0);
        Y : in std_logic_vector(1 downto 0);
        Z : out std_logic_vector(3 downto 0)
    );
    end component;
    
    signal x_in : std_logic_vector(1 downto 0);
    signal y_in : std_logic_vector(1 downto 0);
    signal z_out : std_logic_vector(3 downto 0);
    
begin
    uut: top_comparator
        port map(
            X => x_in,
            Y => y_in,
            z => z_out
        );
    
    tb : process
    begin
        for i in 0 to 3 loop    
            for j in 0  to 3 loop
                x_in <= conv_std_logic_vector(i,2);
                y_in <= conv_std_logic_vector(j,2);
                wait for 100 ns;
            end loop;
        end loop;
        
        wait;
    end process;
            
end behavioral;

---------- Constrains

set_property IOSTANDARD LVCMOS33 [get_ports {X[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {X[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[0]}]
set_property PACKAGE_PIN J15 [get_ports {X[0]}]
set_property PACKAGE_PIN L16 [get_ports {X[1]}]
set_property PACKAGE_PIN M13 [get_ports {Y[0]}]
set_property PACKAGE_PIN R15 [get_ports {Y[1]}]
set_property PACKAGE_PIN H17 [get_ports {Z[0]}]
set_property PACKAGE_PIN K15 [get_ports {Z[1]}]
set_property PACKAGE_PIN J13 [get_ports {Z[2]}]
set_property PACKAGE_PIN N14 [get_ports {Z[3]}]

