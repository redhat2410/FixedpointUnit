library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Queue is
    generic ( 
        depth : integer := 6;
        D_WIDTH : integer := 32 );
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
end Queue;

architecture behavior of Queue is
type memory_type is array (0 to depth - 1) of std_logic_vector(D_WIDTH-1 downto 0);
signal memory : memory_type := ( others => (others=>'0') );
signal readptr, writeptr : integer := 0; --read write pointer
signal empty, full : std_logic := '0';
begin
    isEmpty <= empty;
    isFull <= full;
    process(clk, reset)
    variable num_elem : integer := 0;
    begin
        if(reset = '1') then
            dataOut <= (others=>'0');
            empty <= '0';
            full <= '0';
            readptr <= 0;
            writeptr <= 0;
            num_elem := 0;
        elsif( rising_edge(clk) ) then
            if (enRead = '1' and empty = '0') then
                dataOut <= memory(readptr);
                readptr <= readptr + 1;
                num_elem := num_elem - 1;
            end if;
            if (enWrite = '1' and full = '0') then
                memory(writeptr) <= dataIn;
                writeptr <= writeptr + 1;
                num_elem := num_elem + 1;
            end if;

            if (readptr = depth - 1 ) then
                readptr <= 0;
            end if;
            if (writeptr = depth - 1) then
                writeptr <= 0;
            end if;

            if(num_elem = 0) then
                empty <= '1';
            else
                empty <= '0';
            end if;

            if(num_elem = depth) then
                full <= '1';
            else 
                full <= '0';
            end if;
        end if;
    end process;
end behavior;