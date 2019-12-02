library ieee;
  use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture arch of tb is

  component  RX is
    port (
    clk : in std_logic;
    rst : in std_logic;
    rx : in std_logic;
    rd : in std_logic;
    data : out std_logic_vector(7 downto 0);
    dav : out std_logic
    );
  end component;

  signal clk : std_logic;
  signal rst : std_logic;
  signal rx1 : std_logic;
  signal rd : std_logic;
  signal data : std_logic_vector(7 downto 0);
  signal dav : std_logic;

begin

  ric : RX port map(clk, rst, rx1, rd, data, dav);

  clock : process
  begin

      clk <= '0';
    wait for 20 ns;
      clk <= '1';
    wait for 20 ns;
  end process;


  rest : process
  begin
    rst <= '1';
    wait for 21 ns;
    rst <= '0';
    
  end process;

  rd <= '0';

  trasmission : process
  begin
    rx1 <= '1';
    wait for 50 ns;
    rx1 <= '0';
    wait for 104 us;
    rx1 <= '1';
    wait for 104 us;
    rx1 <= '0';
    wait for 104 us;
    rx1 <= '0';
    wait for 104 us;
    rx1 <= '1';
    wait for 104 us;
    rx1 <= '1';
    wait for 104 us;
    rx1 <= '0';
    wait for 104 us;
    rx1 <= '1';
    wait for 104 us;
    rx1 <= '0';
    wait for 104 us;
    rx1 <= '1';
  end process;
end architecture;
