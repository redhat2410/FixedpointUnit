library ieee;
use IEEE.std_logic_1164.all;

entity Core_4 is
    port(
        dataIn_1, dataIn_2, dataIn_3, dataIn_4 : in std_logic_vector(63 downto 0);
        clk : in std_logic;
        load : in std_logic_vector(3 downto 0);
        op : in std_logic_vector(7 downto 0);
        dataOut_1, dataOut_2, dataOut_3, dataOut_4 : out std_logic_vector(31 downto 0);
        isDone : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behavior of Core_4 is
    component Core_2 is
        port(
            dataIn_1, dataIn_2 : in std_logic_vector(63 downto 0);
            clk : in std_logic;
            load : in std_logic_vector(1 downto 0);
            op : in std_logic_vector(3 downto 0);
            dataOut_1, dataOut_2 : out std_logic_vector(31 downto 0);
            isDone : out std_logic_vector(1 downto 0)
        );
    end component;
begin
    Core2_0 : Core_2 
        port map(
            dataIn_1 => dataIn_1,
            dataIn_2 => dataIn_2,
            clk => clk,
            load => load(1 downto 0),
            op => op(3 downto 0),
            dataOut_1 => dataOut_1,
            dataOut_2 => dataOut_2,
            isDone => isDone(1 downto 0)
        );
    Core2_1 : Core_2
        port map(
            dataIn_1 => dataIn_3,
            dataIn_2 => dataIn_4,
            clk => clk,
            load => load(3 downto 2),
            op => op(7 downto 4),
            dataOut_1 => dataOut_3,
            dataOut_2 => dataOut_4,
            isDone => isDone(3 downto 2)
        );
end behavior;