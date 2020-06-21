library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.fixedPt.all;

entity Core is
    port(
        dataIn : in std_logic_vector(63 downto 0);
        clk : in std_logic;
        load : in std_logic;
        op : in std_logic_vector(1 downto 0);
        dataOut : out std_logic_vector(31 downto 0);
        isDone : out std_logic
    );
end Core;

architecture behavior of Core is
    component FPU is
        port(
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            op  : in std_logic_vector(1 downto 0);
            result : out std_logic_vector(31 downto 0)
        );
    end component;
    component D_FF is
        port(
            D   : in std_logic_vector(31 downto 0);
            clk : in std_logic;
            enable : in std_logic;
            Q : out std_logic_vector(31 downto 0)
        );
    end component;
signal t_A, t_B : std_logic_vector(31 downto 0);
signal t_R : std_logic_vector(31 downto 0);
signal Q_A, Q_B, Q_R : std_logic_vector(31 downto 0);
signal t_done : std_logic := '0';
begin
    t_A <= dataIn(31 downto 0);
    t_B <= dataIn(63 downto 32);
    isDone <= t_done;
    dataOut <= t_R;
    DFF_A : D_FF
        port map(
            D => t_A,
            clk => clk,
            enable => load,
            Q => Q_A
        );
    DFF_B : D_FF
        port map(
            D => t_B,
            clk => clk,
            enable => load,
            Q => Q_B
        );
    DFF_R : D_FF
        port map(
            D => t_R,
            clk => clk,
            enable => load,
            Q => Q_R
        );

    FPUcore : FPU
        port map(
            A => Q_A,
            B => Q_B,
            op => op,
            result => t_R
        );
    
    process(t_R, Q_R, clk)
    begin
        if ( t_R /= Q_R ) then
            t_done <= '1';
        else 
            t_done <= '0';
        end if;
    end process;
end behavior;