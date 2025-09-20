--Agustin Rebola Perricone
--LAB 5
--vending_machine_subsystem.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vending_machine_subsystem is
    port(
        clk             : in  std_logic;
        rst             : in  std_logic;
        lock            : in  std_logic;
        soda_sel        : in  std_logic_vector(3 downto 0);
        soda_req        : in  std_logic;
        coin_push       : in  std_logic;
        coin_sel        : in  std_logic_vector(1 downto 0);
        coin_reject     : out std_logic;
        soda_reserved   : out std_logic;
        soda_price      : out std_logic_vector(11 downto 0);
        soda_drop       : out std_logic;
        deposit_amt     : out std_logic_vector(11 downto 0);
        error_amt       : out std_logic;
        error_reserved  : out std_logic
    );
end vending_machine_subsystem;

architecture structural of vending_machine_subsystem is

--vending machin controller component, serves as controller for machine
    component vending_machine_ctrl is
        port(
            clk               : in  std_logic;
            rst               : in  std_logic;
            lock              : in  std_logic;
            soda_reserved     : in  std_logic;
            soda_price        : in  std_logic_vector(11 downto 0);
            soda_req          : in  std_logic;
            soda_drop         : out std_logic;
            deposit_amt       : in  std_logic_vector(11 downto 0);
            deposit_incr      : out std_logic;
            deposit_decr      : out std_logic;
            coin_push         : in  std_logic;
            coin_amt          : in  std_logic_vector(11 downto 0);
            coin_reject       : out std_logic;
            error_amt         : out std_logic;
            error_reserved    : out std_logic
        );
    end component;

--soda list component, keeps price of sodas
    component soda_list is
        port(
            sel         : in  std_logic_vector(3 downto 0);
            reserved    : out std_logic;
            price       : out std_logic_vector(11 downto 0)
        );
    end component;

--coin list component,  keeps track of amount of coins and total
    component coin_list is
        port(
            sel         : in  std_logic_vector(1 downto 0);
            amt         : out std_logic_vector(11 downto 0)
        );
    end component;

--deposit register component, keeps track of credit
    component deposit_register is
        port(
            clk         : in  std_logic;
            rst         : in  std_logic;
            incr        : in  std_logic;
            incr_amt    : in  std_logic_vector(11 downto 0);
            decr        : in  std_logic;
            decr_amt    : in  std_logic_vector(11 downto 0);
            amt         : out std_logic_vector(11 downto 0)
        );
    end component;

    signal soda_reserved_s : std_logic;
    signal soda_price_s    : std_logic_vector(11 downto 0);

    signal deposit_amt_s   : std_logic_vector(11 downto 0);
    signal deposit_incr_s  : std_logic;
    signal deposit_decr_s  : std_logic;

    signal coin_amt_s      : std_logic_vector(11 downto 0);

begin

    u_vending_machine_ctrl: vending_machine_ctrl
    port map (
        clk            => clk,
        rst            => rst,
        lock           => lock,
        soda_reserved  => soda_reserved_s,
        soda_price     => soda_price_s,
        soda_req       => soda_req,
        soda_drop      => soda_drop,
        deposit_amt    => deposit_amt_s,
        deposit_incr   => deposit_incr_s,
        deposit_decr   => deposit_decr_s,
        coin_push      => coin_push,
        coin_amt       => coin_amt_s,
        coin_reject    => coin_reject,
        error_amt      => error_amt,
        error_reserved => error_reserved
    );

    u_soda_list: soda_list
    port map (
        sel       => soda_sel,
        reserved  => soda_reserved_s,
        price     => soda_price_s
    );

    u_coin_list: coin_list
    port map (
        sel => coin_sel,
        amt => coin_amt_s
    );

    u_deposit_register: deposit_register
    port map (
        clk       => clk,
        rst       => rst,
        incr      => deposit_incr_s,
        incr_amt  => coin_amt_s,
        decr      => deposit_decr_s,
        decr_amt  => soda_price_s,
        amt       => deposit_amt_s
    );

    -- Output connections
    soda_reserved <= soda_reserved_s;
    soda_price    <= soda_price_s;
    deposit_amt   <= deposit_amt_s;

end structural;
