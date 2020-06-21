library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fixedPt is
    component FPP_ADD is
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(31 downto 0)
        );
    end component;
    
    component FPP_SUB is
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(31 downto 0)
        );
    end component;

    component FPP_MUL is
        generic(SCALE : integer := 28);
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(31 downto 0)
        );
    end component;

    component FPP_DIV is
        generic(SCALE : integer := 28);
        port(
            A   :   in std_logic_vector(31 downto 0);
            B   :   in std_logic_vector(31 downto 0);
            sel :   in std_logic;
            result  :   out std_logic_vector(63 downto 0)
        );
    end component;
end package fixedPt;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPP_ADD is
    port(
        A   :   in std_logic_vector(31 downto 0);
        B   :   in std_logic_vector(31 downto 0);
        sel :   in std_logic;
        result  :   out std_logic_vector(31 downto 0)
    );
end FPP_ADD;

architecture behavior of FPP_ADD is
signal t_result :   std_logic_vector(31 downto 0);
begin
    t_result <= std_logic_vector( signed(A) + signed(B)) when (sel = '0') else
        (others => 'Z');
    result <= t_result when (sel = '0') else
        (others => 'Z');
end behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPP_SUB is
    port(
        A   :   in std_logic_vector(31 downto 0);
        B   :   in std_logic_vector(31 downto 0);
        sel :   in std_logic;
        result  :   out std_logic_vector(31 downto 0)
    );
end FPP_SUB;

architecture behavior of FPP_SUB is
signal t_result : std_logic_vector(31 downto 0);
begin
    t_result <= std_logic_vector( unsigned(A) - unsigned(B) ) when ( sel = '0' ) else
        (others => 'Z');
    result <= t_result when (sel = '0') else 
        (others => 'Z');
end behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPP_MUL is
    generic ( SCALE : integer := 28 );
    port(
        A   :   in std_logic_vector(31 downto 0);
        B   :   in std_logic_vector(31 downto 0);
        sel :   in std_logic;
        result  :   out std_logic_vector(31 downto 0)
    );
end FPP_MUL;

architecture behavior of FPP_MUL is
signal t_result, t_mul : std_logic_vector(63 downto 0);
begin
    t_mul <= std_logic_vector( unsigned(A) * unsigned(B) ) when (sel = '0' ) else 
        (others=>'Z');
    t_result <= std_logic_vector( shift_right( unsigned(t_mul), SCALE ) ) when (sel = '0') else
        (others=>'Z'); 
    result <= t_result(31 downto 0) when (sel = '0') else
        (others=>'Z');
end behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPP_DIV is
    generic ( SCALE : integer := 28 );
    port(
        A   :   in std_logic_vector(31 downto 0);
        B   :   in std_logic_vector(31 downto 0);
        sel :   in std_logic;
        result  :   out std_logic_vector(31 downto 0)
    );
end FPP_DIV;

architecture behavior of FPP_DIV is
signal t_A : std_logic_vector(63 downto 0);
signal t_B : std_logic_vector(63 downto 0);
signal t_div, t_result : std_logic_vector(63 downto 0);
begin
    t_A <= "0000" & A & X"0000000" when (sel = '0') else 
        (others => 'Z');
    t_B <= X"00000000" & B when (sel = '0') else 
        (others => 'Z');
    t_div <= std_logic_vector( unsigned(t_A) / unsigned(t_B) ) when (sel = '0') else
        (others=>'Z');
    result <= t_div(31 downto 0) when (sel = '0') else
        (others => 'Z');
end behavior;