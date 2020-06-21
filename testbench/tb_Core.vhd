library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity tb_Core is
end tb_Core;

architecture behavior of tb_Core is
    component Core is
        port(
            dataIn : in std_logic_vector(63 downto 0);
            clk : in std_logic;
            load : in std_logic;
            op : in std_logic_vector(1 downto 0);
            dataOut : out std_logic_vector(31 downto 0);
            isDone : out std_logic
        );
    end component;
signal t_dataIn_0, t_dataIn_1, t_dataOut : std_logic_vector(31 downto 0);
signal t_clk, t_load, t_isDone : std_logic;
signal t_op : std_logic_vector(1 downto 0) := "00";
signal t_dataIn : std_logic_vector(63 downto 0);
begin 
    t_dataIn <= t_dataIn_0 & t_dataIn_1;
    tbCore : Core
        port map(
            dataIn => t_dataIn,
            clk => t_clk,
            load => t_load,
            op => t_op,
            dataOut => t_dataOut,
            isDone => t_isDone
        );
    process
    begin
        t_clk <= '0';
        wait for 1 ns;
        t_clk <= '1';
        wait for 1 ns;
    end process;

    process
    begin
        wait for 20 ns;
        t_op <= t_op + 1;
        wait for 20 ns;
    end process;

    process
    begin
        t_load <= '0';
        wait for 10 ns;
        t_load <= '1';
        wait for 10 ns;
    end process;

    process
    begin
        t_dataIn_0 <= X"13AE147A"; --1.23
        t_dataIn_1 <= X"01C8C932"; --0.11152
        wait for 40 ns;
        t_dataIn_0 <= X"00333333"; --0.0125
        t_dataIn_1 <= X"1067A0F9"; --1.0253
        wait for 40 ns;
    end process;
end behavior;