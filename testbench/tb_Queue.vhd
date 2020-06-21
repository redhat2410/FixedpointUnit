library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_Queue is
end tb_Queue;

architecture behavior of tb_Queue is
    component Queue is
        generic (
            depth : integer := 6;
            D_WIDTH : integer := 32
        );
        port(
            clk : in std_logic;
            reset : in std_logic;
            enRead : in std_logic;
            enWrite : in std_logic;
            dataIn : in std_logic_vector(D_WIDTH - 1 downto 0);
            dataOut : out std_logic_vector(D_WIDTH - 1 downto 0);
            isEmpty : out std_logic;
            isFull : out std_logic
        );
    end component;
begin
end behavior;