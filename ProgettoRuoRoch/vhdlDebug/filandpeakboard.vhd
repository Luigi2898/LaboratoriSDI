library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity filandpeakboard is
  port (
    clock_50 : in std_logic;
    gpio_0   : in std_logic_vector(7 downto 0);
    gpio_0   : out std_logic_vector(15 downto 8);
    ledr     : out std_logic_vector(2 downto 0);
    sw       : in std_logic_vector(3 downto 0)
  );
end entity;

architecture arch of filandpeakboard is

  component FILTER_BLOCK
    port (
      clk, RST : IN  STD_LOGIC;
      PDM      : IN  STD_LOGIC;
      FILTERED : OUT SIGNED(13 DOWNTO 0)
    );
  end component FILTER_BLOCK;

  component PeakNoticer
    port (
      clk    : in  std_logic;
      rstN   : in  std_logic;
      signa  : in  signed(13 downto 0);
      start  : in  std_logic;
      peak   : out std_logic;
      energy : out signed(37 downto 0);
      calc   : out std_logic
    );
  end component PeakNoticer;

  component N_COUNTER
    generic (
      N      : INTEGER := 12;
      MODULE : INTEGER := 2604
    );
    port (
      CLK     : IN  STD_LOGIC;
      EN      : IN  STD_LOGIC;
      RST     : IN  STD_LOGIC;
      CNT_END : OUT STD_LOGIC;
      CNT_OUT : BUFFER UNSIGNED(N-1 DOWNTO 0)
    );
  end component N_COUNTER;

  signal data : signed(13 downto 0);
  signal ed   : signed(37 downto 0);
  signal cnt_out : unsigned(10 downto 0);
  signal cnt_end : std_logic;

begin

  fil : FILTER_BLOCK port map(clk_48k, sw(0), gpio_0(5), data);

  pn  : PeakNoticer port map(clk_48k, sw(1), data, sw(2), ledr(0), ed, ledr(2));

  nc  : generic map(11, 1042)
        port map(clock_50, sw(2), sw(3), cnt_end, cnt_out);

end architecture;
