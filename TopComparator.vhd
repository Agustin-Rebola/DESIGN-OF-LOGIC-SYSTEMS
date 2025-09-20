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
            Z => Z(0)
        );            

end structural;
