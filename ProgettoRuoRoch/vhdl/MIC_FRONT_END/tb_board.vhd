library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;

entity tb_board is
end entity;

architecture arch of tb_board is
  component board
port (
  clock_mic : in  std_logic;
  rst       : in  std_logic;
  pdm_mic   : in  std_logic;
  clock_10n : in  std_logic;
  clock_25n : in  std_logic;
  clock_40n : in  std_logic;
  filter_outdx : buffer signed(27 downto 0);
  filter_outsx : buffer signed(27 downto 0);
  filt_validdx : buffer std_logic;
  filt_validsx : buffer std_logic;
  tx        : out std_logic
);
end component board;

signal clock_mic : std_logic;
signal rst       : std_logic;
signal pdm_mic   : std_logic;
signal clock_10n : std_logic;
signal clock_25n : std_logic;
signal clock_40n : std_logic;
signal tx        : std_logic;
signal filter_outdx : signed(27 downto 0);
signal filter_outsx : signed(27 downto 0);
signal filt_validdx : std_logic;
signal filt_validsx : std_logic;
begin

  board_i : board
  port map (
    clock_mic => clock_mic,
    rst       => rst,
    pdm_mic   => pdm_mic,
    clock_10n => clock_10n,
    clock_25n => clock_25n,
    clock_40n => clock_40n,
	filter_outdx => filter_outdx,
	filter_outsx => filter_outsx,
	filt_validdx => filt_validdx,
	filt_validsx => filt_validsx,
    tx        => tx
  );

  rst_pro : process
  begin
    rst <= '1';
    wait for 1 ns;
    rst <= '0';
    wait for 70 ns;
    rst <= '1';
    wait;
  end process;

  --FILTRI
  clk_fil_pro : process
  begin
    clock_10n <= '0';
    wait for 5 ns;
    clock_10n <= '1';
    wait for 5 ns;
  end process;

  clock_mic_pro : process
  begin
    clock_mic <= '1';
    wait for 0.5 us;
    clock_mic <= '0';
    wait for 0.5 us;

  end process;

  in_p : process

      file inFile : text is in "PDM_50_new.txt";
      variable l : line;
      variable n : std_logic;

    begin
      wait for 70 ns;
      while (endfile(inFile) = false) loop
        readline(inFile, l);
        read(l,n);
        pdm_mic <= n;
        wait for 500 ns;
      end loop;
      wait;
    end process;

	out_p_dx : process(FILT_VALIDdx)
	
		file posFile : text is out "outfilterdx.txt";
		variable l : line;
		variable n : integer;
		
	begin
			if(FILT_VALIDdx = '1') then
			n := to_integer(filter_outsx);
			write(l,n);
			writeline(posFile, l);			
			end if;			
	end process;
		
	out_p_sx : process(FILT_VALIDsx)
	
		file posFile : text is out "outfilter_sx.txt";
		variable l : line;
		variable n : integer;
		
	begin
			if(FILT_VALIDsx = '1') then
			n := to_integer(filter_outsx);
			write(l,n);
			writeline(posFile, l);			
			end if;			
	end process;
			

    clk_10n_pro : process
    begin
      clock_10n <= '0';
      wait for 5 ns;
      clock_10n <= '1';
      wait for 5 ns;
    end process;

    clk_25n_pro : process
    begin
      clock_25n <= '0';
      wait for 12.5 ns;
      clock_25n <= '1';
      wait for 12.5 ns;
    end process;

    clk_40n_pro : process
    begin
      clock_40n <= '0';
      wait for 20 ns;
      clock_40n <= '1';
      wait for 20 ns;
    end process;

end architecture;
