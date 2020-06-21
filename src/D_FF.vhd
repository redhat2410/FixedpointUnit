library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
    port(
        D   :   in std_logic_vector(31 downto 0);
        enable: in std_logic;
        clk :   in std_logic;
        Q   :   out std_logic_vector(31 downto 0)
    );
end D_FF;

architecture behavior of D_FF is
signal Q_out, D_in  : std_logic_vector(31 downto 0);
signal enable_32bit : std_logic_vector(31 downto 0);
begin
    enable_32bit <= (others => enable);
    D_in <= (D and enable_32bit) or (Q_out and not(enable_32bit));
    process(D_in, enable_32bit, clk)
    begin
        if rising_edge(clk) then Q_out <= D_in; end if;
    end process;
    Q <= Q_out;
end behavior;