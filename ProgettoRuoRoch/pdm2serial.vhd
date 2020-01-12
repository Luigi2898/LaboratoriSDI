library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity pdm2serial is
  port (
    sw          : in std_logic_vector(7 downto 0);
    key         : in std_logic_vector(1 downto 0);
    clock_50    : in std_logic;
    ledr        : out std_logic_vector(8 downto 0);
    hps_uart_tx : out std_logic;
  );
end entity;

architecture arch of pdm2serial is

  component pll is
    port (
      refclk   : in  std_logic := '0'; --  refclk.clk
      rst      : in  std_logic := '0'; --  reset.reset
      outclk_0 : out std_logic;        --  outclk0.clk
      locked   : out std_logic         --  locked.export
    );
  end component pll;

  component TX IS
    PORT(
      CLOCK       : IN STD_LOGIC;
      RST         : IN STD_LOGIC;
      DATA_IN     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      TX          : OUT STD_LOGIC;
      DATA_VALID  : IN STD_LOGIC;
      TXREADY     : OUT STD_LOGIC
    );
  END component;

  signal lock, clock_25 : std_logic;
  signal pardata        : std_logic_vector(7 downto 0);

begin

  plll : pll port map(clock_50, key(0), clock_25, lock);
  txx  : tx port map(clock_25, key(0), pardata, hps_uart_tx, key(1), ledr(8));
  ledr(7 downto 0) <= sw;
  pardata <= sw;

end architecture;
