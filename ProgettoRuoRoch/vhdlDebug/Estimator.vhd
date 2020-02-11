library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;

entity Estimator is
end entity;

architecture arch of Estimator is
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

  signal clkfil, clkN     : std_logic;
  signal rst        : std_logic;
  signal startfilsx   : std_logic;
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


begin

sx_fil : DECIMATOR_FIR port map(clkfil, rst, startfilsx, pdm_in, FILTER_OUTsx, FILT_VALIDsx);

dx_fil : DECIMATOR_FIR port map(clkfil, rst, startfildx, pdm_in, FILTER_OUTdx, FILT_VALIDdx);

pnsx : PeakNoticer port map(clkpeak, rst, FILTER_OUTsx, FILT_VALIDsx, restart, peaksx, energysx, calcsx);

pndx : PeakNoticer port map(clkpeak, rst, FILTER_OUTdx, FILT_VALIDdx, restart, peakdx, energydx, calcdx);

del : compute_delay port map(clkdelay, rst, delay, msb, peakdx, peaksx, restart, SIMULTANEOUS, done);


--GENERALE
rst_pro : process
begin
  rst <= '1';
  wait for 1 ns;
  rst <= '0';
  wait for 60 ns;
  rst <= '1';
  wait;
end process;

--FILTRI
clk_fil_pro : process
begin
  clkfil <= '0';
  wait for 5 ns;
  clkfil <= '1';
  wait for 5 ns;
end process;

start_fil_pro : process
begin
  startfilsx <= '0';
  startfildx <= '1';
  wait for 0.5 us;
  startfildx <= '0';
  startfilsx <= '1';
  wait for 0.5 us;

end process;

in_p : process

    file inFile : text is in "PDM.txt";
    variable l : line;
    variable n : std_logic;

  begin
    wait for 70 ns;
    while (endfile(inFile) = false) loop
      readline(inFile, l);
      read(l,n);
      pdm_in <= n;
      wait for 500 ns;
    end loop;
    wait;
  end process;

  out_p_sx : process(FILT_VALIDsx)

  		file posFile : text is out "outfiltersx.txt";
  		variable l : line;
  		variable n : integer;

  	begin
  			if(filt_validsx = '1') then
  			n := to_integer(FILTER_OUTsx);
  			write(l,n);
  			writeline(posFile, l);
  			end if;
  	end process;

    out_p_dx : process(FILT_VALIDdx)

    		file posFile : text is out "outfilterdx.txt";
    		variable l : line;
    		variable n : integer;

    	begin
    			if(filt_validdx = '1') then
    			n := to_integer(FILTER_OUTdx);
    			write(l,n);
    			writeline(posFile, l);
    			end if;
    	end process;
--PEAK
clk_peak_pro : process
begin
  clkpeak <= '0';
  wait for 5 ns;
  clkpeak <= '1';
  wait for 5 ns;
end process;

--DELAY
clk_delay_pro : process
begin
  clkdelay <= '0';
  wait for 12.5 ns;
  clkdelay <= '1';
  wait for 12.5 ns;
end process;
end architecture;
