LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY N_COUNTER IS
		GENERIC(N : INTEGER:= 12; MODULE : INTEGER:= 2604);
		PORT(CLK : IN STD_LOGIC;
			 EN  : IN STD_LOGIC;
			 RST : IN STD_LOGIC;
			 CNT_END : OUT STD_LOGIC;
			 CNT_OUT : BUFFER UNSIGNED(N-1 DOWNTO 0)		
		);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF N_COUNTER IS

	BEGIN
	
	 CNT:PROCESS(CLK)
	 BEGIN
		IF(CLK'EVENT AND CLK = '1') THEN
			IF(RST = '0') THEN
			 CNT_END <= '0';
			 CNT_OUT <= (OTHERS => '0');	
			    ELSIF(EN = '1') THEN
				 CNT_END <= '0';
				 CNT_OUT <= CNT_OUT + 1;
			    END IF;	
		    IF(CNT_OUT = TO_UNSIGNED(MODULE-1, N) AND EN = '1') THEN
			 CNT_END <= '1';
			 CNT_OUT <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;

END ARCHITECTURE;