library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;

entity testbench_PeakNoticer is
end entity;

architecture arch of testbench_PeakNoticer is

  component PeakNoticer
  port (
    clk    : in  std_logic;
    rstN   : in  std_logic;
    signa  : in  std_logic_vector(15 downto 0);
    start  : in  std_logic;
    peak   : out std_logic;
    energy : out std_logic_vector(31 downto 0);
    calc   : out std_logic
  );
  end component PeakNoticer;

  signal clk    : std_logic;
  signal rstN   : std_logic;
  signal data_i : std_logic_vector(15 downto 0);
  signal start  : std_logic;
  signal peak   : std_logic;
  signal energy : std_logic_vector(31 downto 0);
  signal calc   : std_logic;

begin

  start_p : process
	begin
			start <= '0';
		wait for 27 ns;
		start <= '1';
    wait for 10 ns;
    start <= '0';
		wait;
	end process;

  RST_PROCESS : PROCESS
  BEGIN
  	RSTN <= '0';
  	WAIT FOR 25 NS;
  	RSTN <= '1';
  	wait;
  END PROCESS;

  clock : process
  begin

    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;

  end process;

  in_p : process

    file inFile : text is in "input.txt";
    variable l : line;
    variable n : integer;

  begin
    wait for 27 ns;
    while (endfile(inFile) = false) loop
      readline(inFile, l);
      read(l,n);
      data_i <= std_logic_vector(to_unsigned(n, 16));
      wait for 10 ns;
    end loop;
    wait;
  end process;

  pn : PeakNoticer port map(clk, rstN, data_i, start, peak, energy, calc);

end architecture;
