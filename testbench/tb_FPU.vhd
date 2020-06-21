library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_FPU is
end tb_FPU;

architecture behavior of tb_FPU is
    component FPU is
        port(
            A, B    : in std_logic_vector(31 downto 0);
            op      : in std_logic_vector(1 downto 0);
            result  : out std_logic_vector(31 downto 0)
        );
    end component;
signal t_A, t_B, t_result : std_logic_vector(31 downto 0);
signal t_sel : std_logic_vector(1 downto 0);
begin
    fixPU : FPU
        port map(
            A => t_A,
            B => t_B,
            op => t_sel,
            result => t_result
        );
    process
    begin
        t_A <= X"38000000";--3.5
        t_B <= X"48000000";--4.5
        t_sel <= "00";
        wait for 10 ns;
        t_sel <= "01";
        wait for 10 ns;
        t_sel <= "10";
        wait for 10 ns;
        t_sel <= "11";
        wait for 10 ns;
        wait;
    end process;
end behavior;