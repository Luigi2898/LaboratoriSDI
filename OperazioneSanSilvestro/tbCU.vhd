library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tbCU is
end entity;

architecture arch of tbCU is
  component uSequencer is
    port (
      clk     : in std_logic;
      rst     : in std_logic;
      start   : in std_logic;
      done    : out std_logic;
      str_nxt : out std_logic;
      uIR     : out std_logic_vector(6 downto 0)
    );
  end component;

  component DECODER IS
    PORT(
      W : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      Y : OUT STD_LOGIC_VECTOR(45 DOWNTO 0)
    );
  END component;

  signal w       : std_logic_vector(3 downto 0);
  signal y       : std_logic_vector(45 downto 0);
  signal clk     : std_logic;
  signal rst     : std_logic;
  signal start   : std_logic;
  signal done    : std_logic;
  signal str_nxt : std_logic;
  signal uIR     : std_logic_vector(6 downto 0);

begin

  w <= uIR(6 downto 3);
  dec : DECODER port map(W, y);
  useq : uSequencer port map(clk, rst, start, done, str_nxt, uIR);

  clo : process
  begin
    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
  end process;

  res : process
  begin
    rst <= '1';
    wait for 1 ns;
    rst <= '0';
    wait for 22 ns;
    rst <= '1';
    wait;
  end process;

  start <= '0';
end architecture;
