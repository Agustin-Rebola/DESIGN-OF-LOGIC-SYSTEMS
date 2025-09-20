--carry_save_mult.vhd
library ieee;
use ieee.std_logic_1164.all;

entity carry_save_mult is
    generic (n : integer := 8);
    port(
        a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        p : out std_logic_vector(2*n-1 downto 0)
    );
end carry_save_mult;

architecture structural of carry_save_mult is

    component full_adder is
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            sum  : out std_logic;
            cout : out std_logic
        );
    end component;

    type arr2d is array (integer range <>) of std_logic_vector(n-1 downto 0);

    signal ab      : arr2d(0 to n-1);
    signal FA_a    : arr2d(0 to n-2);
    signal FA_b    : arr2d(0 to n-2);
    signal FA_cin  : arr2d(0 to n-2);
    signal FA_sum  : arr2d(0 to n-2);
    signal FA_cout : arr2d(0 to n-2);

begin
    -- Assign ab matrix
    gen_ab: for i in 0 to n-1 generate
        gen_ab_j: for j in 0 to n-1 generate
            ab(i)(j) <= a(i) and b(j);
        end generate;
    end generate;

    -- Input assignment for FAs
    FA_a(0)    <= '0' & ab(0)(n-1 downto 1);
    FA_b(0)    <= ab(1);
    FA_cin(0)  <= ab(2)(n-2 downto 0) & '0';

    row_gen: for i in 1 to n-3 generate
        FA_a(i)    <= ab(i+1)(n-1) & FA_sum(i-1)(n-1 downto 1);
        FA_b(i)    <= FA_cout(i-1);
        FA_cin(i)  <= ab(i+2)(n-2 downto 0) & '0';
    end generate;

    FA_a(n-2)    <= ab(n-1)(n-1) & FA_sum(n-3)(n-1 downto 1);
    FA_b(n-2)    <= FA_cout(n-3);
    FA_cin(n-2)  <= FA_cout(n-2)(n-2 downto 0) & '0';

    gen_fa_rows: for i in 0 to n-2 generate
        gen_fa_cols: for j in 0 to n-1 generate
            fa_inst: full_adder
                port map (
                    a    => FA_a(i)(j),
                    b    => FA_b(i)(j),
                    cin  => FA_cin(i)(j),
                    sum  => FA_sum(i)(j),
                    cout => FA_cout(i)(j)
                );
        end generate;
    end generate;
                         
    p(0) <= ab(0)(0);
    gen_p1: for i in 1 to n-2 generate
        p(i) <= FA_sum(i-1)(0);
    end generate;

    gen_p2: for i in 0 to n-2 generate
        p(n + i - 1) <= FA_sum(n-2)(i);
    end generate;

    p(2*n-2) <= FA_sum(n-2)(n-1);
    p(2*n-1) <= FA_cout(n-2)(n-1);

end structural;
