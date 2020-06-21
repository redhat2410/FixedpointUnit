----------------------------------------------------------------
-- FPU.vhd is Fixed point unit
----------------------------------------------------------------

library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fixedPt.all;

entity FPU is
    port(
        A, B    : in std_logic_vector(31 downto 0);
        op      : in std_logic_vector(1 downto 0);
        result  : out std_logic_vector(31 downto 0)
    );
end FPU;

architecture behavior of FPU is
    component FPP_ADD is
        port(
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            sel : in std_logic;
            result  : out std_logic_vector(31 downto 0)
        );
    end component;

    component FPP_SUB is
        port(
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            sel : in std_logic;
            result  : out std_logic_vector(31 downto 0)
        );
    end component;

    component FPP_MUL is
        generic ( SCALE : integer := 28 );
        port(
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            sel : in std_logic;
            result  : out std_logic_vector(31 downto 0)
        );
    end component;

    component FPP_DIV is
        generic ( SCALE : integer := 28 );
        port(
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            sel : in std_logic;
            result  : out std_logic_vector(31 downto 0)
        );
    end component;
    
signal t_A, t_B : std_logic_vector(31 downto 0);
signal t_result_add : std_logic_vector(31 downto 0);
signal t_result_sub : std_logic_vector(31 downto 0);
signal t_result_div : std_logic_vector(31 downto 0);
signal t_result_mul : std_logic_vector(31 downto 0);
signal t_sel : std_logic_vector(3 downto 0);
begin
    t_A <= A;
    t_B <= B;

    t_sel(0) <= op(0) or op(1);
    t_sel(1) <= not op(0) or op(1);
    t_sel(2) <= op(0) or not op(1);
    t_sel(3) <= not op(0) or not op(1);

    add : FPP_ADD
        port map(
            A => t_A,
            B => t_B,
            sel => t_sel(0),
            result => t_result_add
        );
    sub : FPP_SUB
        port map(
            A => t_A,
            B => t_B,
            sel => t_sel(1),
            result => t_result_sub
        );
    mul : FPP_MUL
        port map(
            A => t_A,
            B => t_B,
            sel => t_sel(2),
            result => t_result_mul
        );
    div : FPP_DIV
        port map(
            A => t_A,
            B => t_B,
            sel => t_sel(3),
            result => t_result_div
        );
    result <= t_result_add when t_sel = "1110" else
        t_result_sub when t_sel = "1101" else
        t_result_mul when t_sel = "1011" else
        t_result_div when t_sel = "0111" else 
        (others => 'Z'); 
end behavior;