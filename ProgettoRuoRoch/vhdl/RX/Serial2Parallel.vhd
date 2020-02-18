LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SERIAL2PARALLEL IS
	GENERIC(N : integer);
	PORT(CLK        : IN STD_LOGIC;
		 RST        : IN STD_LOGIC;
		 EN         : IN STD_LOGIC;
		 SERIAL_D   : IN STD_LOGIC;
		 PARALLEL_D : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF SERIAL2PARALLEL IS

BEGIN

SERIALEPARALLELO: PROCESS(CLK)
BEGIN
IF(CLK'EVENT AND CLK = '1') THEN
	 IF(RST = '0') THEN
         PARALLEL_D <= (OTHERS => '1');
	 ELSIF(EN = '1') THEN
         FOR I IN N-1 DOWNTO 1 LOOP
          PARALLEL_D(I-1) <= PARALLEL_D(I);
          END LOOP;
          PARALLEL_D(N-1) <= SERIAL_D;	
	 END IF;
END IF;
END PROCESS;

END ARCHITECTURE;