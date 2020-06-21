library ieee;
use ieee.std_logic_1164.all;

entity tb_D_FF is
end tb_D_FF;

architecture behavior of tb_D_FF is
    component D_FF is
        port(
            D   :   in std_logic_vector(31 downto 0);
            enable : in std_logic;
            clk : in std_logic;
            Q   : out std_logic_vector(31 downto 0)
        );
    end component;
signal t_D, t_Q : std_logic_vector(31 downto 0);
signal t_clk, t_enable : std_logic;
begin
    DFF : D_FF
        port map(
            D => t_D,
            enable => t_enable,
            clk => t_clk,
            Q => t_Q
        );
    
    SIM_CLK : process
    begin
        t_clk <= '0';
        wait for 1 ns;
        t_clk <= '1';
        wait for 1 ns;
    end process SIM_CLK;

    process
    begin
        t_enable <= '0';
        wait for 10 ns;
        t_enable <= '1';
        wait for 10 ns;
    end process;

    process
    begin
        t_D <= X"0A0A0A0A";
        wait for 5 ns;
        t_D <= X"0B0B0B0B";
        wait for 5 ns;
    end process;
end behavior;