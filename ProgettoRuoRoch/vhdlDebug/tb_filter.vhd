LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use std.textio.all;

entity tb_filter is
end entity;

ARCHITECTURE BEH OF tb_filter IS

COMPONENT DECIMATOR_FIR IS
	PORT(CLK        : IN STD_LOGIC;
		 RST        : IN STD_LOGIC;
		 START      : IN STD_LOGIC;
		 PDM_IN     : IN STD_LOGIC; 
		 FILTER_OUT : OUT SIGNED(27 DOWNTO 0);
		 FILT_VALID : OUT STD_LOGIC	
	);
END COMPONENT;

signal pdm_in : STD_LOGIC;
signal clk, rst: STD_LOGIC;
signal filtered : signed(27 downto 0);
SIGNAL START, FILT_VALID : STD_LOGIC;
signal clk_pdm : std_logic;

BEGIN

RST_PROCESS : PROCESS
BEGIN
	RST <= '0';
	WAIT FOR 100 NS;
	RST <= '1';
	wait for 20 sec;
END PROCESS;

clock : process
begin
     clk <= '1';
	 wait for 5 ns;
	 clk <= '0';
	 wait for 5 ns;
	
end process;
	
start_p : process
begin
   start <= '0';
   wait for 490 ns;
   start <= '1';
   wait for 10 ns;
   start <= '0';
   wait for 490 ns;	
end process;


pdm : process
begin
WAIT FOR 100 NS;
pdm_in <= '1';
WAIT FOR 500 NS;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '0';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;
pdm_in <= '1';
wait for 500 ns;


end process;
	
filt1 : DECIMATOR_FIR port map(clk, rst, START, pdm_in, filtered, FILT_VALID);

end architecture;	