library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity board is
  port (
  clock_mic : in std_logic;
  rst : in std_logic;
  pdm_mic : in std_logic;
  clock_10n : in std_logic;
  clock_25n : in std_logic;
  clock_40n : in std_logic;
  tx : out std_logic
  );
end entity;

architecture arch of board is

    component compute_delay
    port (
      clk          : in  std_logic;
      rst          : in  std_logic;
      DELAY_OUT    : BUFFER SIGNED(11 DOWNTO 0);
      MSB          : OUT STD_LOGIC;
      PEAK1        : IN  STD_LOGIC;
      PEAK2        : IN  STD_LOGIC;
      RESTART      : OUT STD_LOGIC;
      SIMULTANEOUS : buffer STD_LOGIC;
      DONE         : OUT STD_LOGIC
    );
    end component compute_delay;

    component DECIMATOR_FIR
    port (
      CLK        : IN  STD_LOGIC;
      RST        : IN  STD_LOGIC;
      START      : IN  STD_LOGIC;
      PDM_IN     : IN  STD_LOGIC;
      FILTER_OUT : OUT SIGNED(27 DOWNTO 0);
      FILT_VALID : OUT STD_LOGIC
    );
    end component DECIMATOR_FIR;


    component PeakNoticer
    port (
      clk     : in  std_logic;
      rstN    : in  std_logic;
      signa   : in  signed(27 downto 0);
      DAV     : in  std_logic;
      restart : in  std_logic;
      peak    : out std_logic;
      energy  : out signed(66 downto 0);
      calc    : out std_logic
    );
    end component PeakNoticer;

    component UART
port (
  data_in  : in  std_logic_vector (7 downto 0);
  tx_pin   : out std_logic;
  tx_ready : out std_logic;
  wr       : in  std_logic;
  data_out : out std_logic_vector (7 downto 0);
  rx_pin   : in  std_logic;
  rd       : in  std_logic;
  dav      : out std_logic;
  clock    : in  std_logic;
  resetN   : in  std_logic
);
end component UART;

component RisingEdge_DFlipFlop_reset
port (
  Q   : out std_logic;
  Clk : in  std_logic;
  D   : in  std_logic;
  reset : in std_logic
);
end component RisingEdge_DFlipFlop_reset;

component GENERICS_MUX
generic (
  INPUTS : INTEGER := 15;
  SIZE   : INTEGER := 1
);
port (
  INS     : IN  std_logic_vector((INPUTS*SIZE)-1 DOWNTO 0);
  SEL     : IN  INTEGER;
  OUT_MUX : OUT std_logic_VECTOR(SIZE-1 DOWNTO 0)
);
end component GENERICS_MUX;

    signal pdm_in     : std_logic;
    signal FILTER_OUTsx : signed(27 downto 0);
    signal FILT_VALIDsx : std_logic;
    signal startfildx   : std_logic;
    signal FILTER_OUTdx : signed(27 downto 0);
    signal FILT_VALIDdx : std_logic;
    signal clkpeak : std_logic;
    signal restart : std_logic;
    signal peaksx : std_logic;
    signal energysx : signed(66 downto 0);
    signal calcsx : std_logic;
    signal peakdx : std_logic;
    signal energydx : signed(66 downto 0);
    signal calcdx : std_logic;
    signal clkdelay : std_logic;
    signal delay : signed(11 downto 0);
    signal msb : std_logic;
    signal SIMULTANEOUS : std_logic;
    signal done : std_logic;
    signal data_out : std_logic_vector (7 downto 0);
    signal rx_pin   : std_logic;
    signal rd       : std_logic;
    signal dav      :  std_logic;
    signal done_long : std_logic;
    signal reset_ff1 : std_logic;
    signal reset_ff2 : std_logic;
    signal msb_long : std_logic;
    signal ins : std_logic_vector(23 downto 0);
    signal direction_sy : std_logic_vector(7 downto 0);
    signal symbol_mux : std_logic_VECTOR(1 DOWNTO 0);
    signal wr : std_logic;
    signal tx_rdy : std_logic;
    signal clk_mic_N : std_logic;
    signal int_sel : integer := 0;
    signal SIMULTANEOUS_long, reset_ff3 : std_logic;

  begin

  clk_mic_N <= not(clock_mic);

  sx_fil : DECIMATOR_FIR port map(clock_10n, rst, clk_mic_N, pdm_mic, FILTER_OUTsx, FILT_VALIDsx);

  dx_fil : DECIMATOR_FIR port map(clock_10n, rst, clock_mic, pdm_mic, FILTER_OUTdx, FILT_VALIDdx);

  pnsx : PeakNoticer port map(clock_10n, rst, FILTER_OUTsx, FILT_VALIDsx, restart, peaksx, energysx, calcsx);

  pndx : PeakNoticer port map(clock_10n, rst, FILTER_OUTdx, FILT_VALIDdx, restart, peakdx, energydx, calcdx);

  del : compute_delay port map(clock_25n, rst, delay, msb, peakdx, peaksx, restart, SIMULTANEOUS, done);

  DFF1 : RisingEdge_DFlipFlop_reset port map(done_long, clock_25n, done, reset_ff1);

  DFF2 : RisingEdge_DFlipFlop_reset port map(msb_long, clock_25n, msb, reset_ff2);

  DFF3 : RisingEdge_DFlipFlop_reset port map(SIMULTANEOUS_long, clock_25n, SIMULTANEOUS, reset_ff3);

  INS <= "01011000" &"01000100" & "01010011"; --X D S

  int_sel <= to_integer(unsigned(symbol_mux));

  sy_mux : generics_mux generic map(3, 8)
                        port map(ins, int_sel, direction_sy);

  UART_cmd : process(clock_40n)
  begin
    if (clock_40n'event and clock_40n = '1') then
      reset_ff1 <= '0';
      reset_ff2 <= '0';
      reset_ff3 <= '1';
      wr <= '0';
      symbol_mux <= "00";
    if (done_long = '1') then
      reset_ff1 <= '1';
      if (tx_rdy = '1') then
        wr <= '1';
        symbol_mux <= SIMULTANEOUS_long & msb_long;
        reset_ff2 <= '1';
        reset_ff3 <= '1';
      end if;
    end if;
  end if;
  end process;

  UART_I : UART port map(direction_sy, tx, tx_rdy, wr, data_out, rx_pin, rd, dav, clock_40n, rst);

end architecture;
