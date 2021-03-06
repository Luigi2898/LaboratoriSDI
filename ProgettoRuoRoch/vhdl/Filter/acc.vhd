LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ACC IS 
	GENERIC(N_ACC : INTEGER := 14);
	PORT(ACC_IN : IN SIGNED(N_ACC-1 DOWNTO 0);
		 ACC_OUT : OUT SIGNED(N_ACC-1 DOWNTO 0);
		 CLK, RST, EN_ACC: IN STD_LOGIC	
	);
END ENTITY;

ARCHITECTURE BEH OF ACC IS

BEGIN 
PROCESS(CLK, RST)
BEGIN	
	IF(RST = '0') THEN
		ACC_OUT <= (OTHERS => '0');
	 ELSIF(CLK'EVENT AND CLK = '1') THEN
		 IF(EN_ACC = '1') THEN
		 ACC_OUT <= ACC_IN;
		 END IF;
	END  IF;

END PROCESS;
END ARCHITECTURE;