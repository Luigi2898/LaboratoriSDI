library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity FilterSerial is
  port (
    sw          : in  std_logic_vector(7 downto 0);
    clock_50    : in  std_logic;
    gpio_0      : in  std_logic_vector(2 downto 0);
    sw          : in  std_logic_vector(2 downto 0);
    ledr        : in  std_logic_vector(2 downto 0);
    hps_uart_tx : out std_logic
  );
end entity;

architecture arch of FilterSerial is

  component FILTER_BLOCK
    port (
      clk      : in  std_logic;
      RST      : IN  STD_LOGIC;
      PDM      : IN  STD_LOGIC;
      FILTERED : OUT SIGNED(13 DOWNTO 0)
    );
  end component FILTER_BLOCK;

  component pll is
    port (
      refclk   : in  std_logic := '0'; --  refclk.clk
      rst      : in  std_logic := '0'; --  reset.reset
      outclk_0 : out std_logic;        --  outclk0.clk
      locked   : out std_logic         --  locked.export
    );
  end component pll;

  component TX
    port (
      CLOCK      : IN  STD_LOGIC;
      RST        : IN  STD_LOGIC;
      DATA_IN    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
      TX         : OUT STD_LOGIC;
      DATA_VALID : IN  STD_LOGIC;
      TXREADY    : OUT STD_LOGIC
    );
  end component TX;

  signal data         : signed(13 downto 0);
  signal clock_25, lk : std_logic;
  signal send         : std_logic_vector(7 downto 0);

begin

  --TODO CAPIRE CLOCK FILTRO

  FILTER_BLOCK_i : FILTER_BLOCK port map (clock_50, sw(0), gpio_0(0), data);

  plll : pll port map (clock_50, not(sw(0)), clock_25, lk);

  send <= data(7 downto 0) when ctr = '1' else "00" & data(13 downto 8);

  txx : tx port map(clock_25, sw(0), send, hps_uart_tx, dav, ledr(0));

end architecture;
