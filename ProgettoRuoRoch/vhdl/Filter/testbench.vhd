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
		 FILTER_OUT : OUT SIGNED(23 DOWNTO 0);
		 FILT_VALID : OUT STD_LOGIC	
	);
END COMPONENT;

signal pdm_in : STD_LOGIC;
signal clk, rst: STD_LOGIC;
signal filtered : signed(23 downto 0);
SIGNAL START, FILT_VALID : STD_LOGIC;

BEGIN

RST_PROCESS : PROCESS
BEGIN
	RST <= '0';
	WAIT FOR 5 NS;
	RST <= '1';
	wait for 20 sec;
END PROCESS;

clock : process
	begin
	
		clk <= '1';
		wait for 500 ns;
		clk <= '0';
		wait for 500 ns;
	
	end process;
	
in_p : process
	   
	 	file inFile : text is in "pdm.txt";
		variable l : line;
		variable n : integer;
			
	begin
		wait for 5 ns;
		while (endfile(inFile) = false) loop
			readline(inFile, l);
			read(l,n);
			IF(N = 1) THEN 
				PDM_IN <= '1';
				ELSE PDM_IN <= '0';
		    END IF;
			wait for 1 us;
		end loop;
		wait for 5 ns;
	end process;	
	
out_p : process
	
		file posFile : text is out "outfilter.txt";
		variable l : line;
		variable n : integer ;
		
	begin
			n := to_integer(filtered);
			write(l,n);
			writeline(posFile, l);
		wait for 1 us;
	end process;
		
	
filt : DECIMATOR_FIR port map(clk, rst, START, pdm_in, filtered, FILT_VALID);

end architecture;	