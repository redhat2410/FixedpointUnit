library ieee;
use IEEE.std_logic_1164.all;

entity Core_2 is
    port(
        dataIn_1, dataIn_2 : in std_logic_vector(63 downto 0);
        clk : in std_logic;
        load : in std_logic_vector(1 downto 0);
        op : in std_logic_vector(3 downto 0);
        dataOut_1, dataOut_2 : out std_logic_vector(31 downto 0);
        isDone : out std_logic_vector(1 downto 0)
    );
end Core_2;

architecture behavior of Core_2 is
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
begin
    Core_0 : Core
        port map(
            dataIn => dataIn_1,
            clk => clk,
            load => load(0),
            op => op(1 downto 0),
            dataOut => dataOut_1,
            isDone => isDone(0)
        );
    Core_1 : Core
        port map(
            dataIn => dataIn_2,
            clk => clk,
            load => load(1),
            op => op(3 downto 2),
            dataOut => dataOut_2,
            isDone => isDone(1)
        );
end behavior;