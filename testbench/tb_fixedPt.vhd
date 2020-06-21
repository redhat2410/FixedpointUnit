library ieee;
use ieee.std_logic_1164.all;
use work.fixedPt.all;

entity tb_fixedPt is
end tb_fixedPt;

architecture behavior of tb_fixedPt is
    component FPP_MUL is
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(31 downto 0)
        );
    end component;
    component FPP_DIV is
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(63 downto 0)
        );
    end component;
signal t_A, t_B : std_logic_vector(31 downto 0);
signal t_result : std_logic_vector(63 downto 0);
signal t_sel : std_logic;
begin
    div : FPP_DIV
        port map(
            A => t_A,
            B => t_B,
            sel => t_sel,
            result => t_result
        );
    SIM : process
    begin
        t_sel <= '1';
        wait for 1 ns;
        t_A <= X"48000000";
        t_B <= X"59999999";
        t_sel <= '0';
        wait for 10 ns;
        wait;
    end process SIM;
end behavior;