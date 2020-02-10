LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use std.textio.all;

entity TESTBENCH is
end entity;

ARCHITECTURE BEH OF TESTBENCH IS

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
	WAIT FOR 90 NS;
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

PDM_RATE : PROCESS
BEGIN
CLK_PDM <= '1';
WAIT FOR 500 NS;
CLK_PDM <= '0';
WAIT FOR 500 NS;
END PROCESS;

	
in_p : process(CLK_PDM)
	   
	 	file inFile : text is in "pdm.txt";
		variable l : line;
		variable n : integer;
			
	begin
		
		    IF(CLK_PDM = '1') THEN
			IF(endfile(inFile) = false) THEN
			readline(inFile, l);
			read(l,n);
			IF(N = 1) THEN 
				PDM_IN <= '1';
				ELSE PDM_IN <= '0';
		    END IF;
			END IF;
			END IF;
	
		
	end process;	
	
out_p : process(FILT_VALID)
	
		file posFile : text is out "outfilter.txt";
		variable l : line;
		variable n : integer;
		
	begin
			if(filt_valid = '1') then
			n := to_integer(filtered);
			write(l,n);
			writeline(posFile, l);			
			end if;			
	end process;
		
filt : DECIMATOR_FIR port map(clk, rst, START, pdm_in, filtered, FILT_VALID);

end architecture;	