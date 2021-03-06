LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FF IS
	PORT(FF_IN : IN STD_LOGIC;
		 FF_OUT : OUT STD_LOGIC;
		 CLK, RST, LOAD : IN STD_LOGIC	
	);
END ENTITY;

ARCHITECTURE BEH OF FF IS

BEGIN
REGPROC: PROCESS(CLK, RST)
BEGIN
IF(RST = '0') THEN
	FF_OUT <= '0';
     ELSIF(CLK'EVENT AND CLK = '1') THEN
		 IF(LOAD = '1') THEN
		 FF_OUT <= FF_IN;
		 END IF;
END IF;

END PROCESS;

END ARCHITECTURE;