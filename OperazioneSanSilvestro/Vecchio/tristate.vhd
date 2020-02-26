LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

ENTITY TRISTATE IS
	GENERIC(N : INTEGER := 1);
	PORT(D_IN : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 D_OUT : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 EN : IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE BEH OF TRISTATE IS

BEGIN
D_PROCESS: PROCESS(EN)
BEGIN
IF(EN = '0') THEN
	D_OUT <= (others => 'Z');
	ELSE D_OUT <= D_IN;
END IF;
END PROCESS;

END ARCHITECTURE;