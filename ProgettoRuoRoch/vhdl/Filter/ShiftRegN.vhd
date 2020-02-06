LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SHIFTREGN IS
  GENERIC(
    N : INTEGER := 10
  );
  PORT (
    CLOCK    : IN STD_LOGIC;
    LOAD_EN  : IN STD_LOGIC;
	SHIFT_EN : IN STD_LOGIC;
    RSTN     : IN STD_LOGIC;    
	D_IN     : IN STD_LOGIC;
    D_OUT    : OUT STD_LOGIC;
	REG_OUT  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF SHIFTREGN IS

SIGNAL REG : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN

  SHIFT : PROCESS(CLOCK, RSTN)
  BEGIN
  IF (RSTN = '0') THEN
        REG <= (OTHERS => '0');
		D_OUT <= '0';
    ELSIF (CLOCK'EVENT AND CLOCK = '1') THEN      
        IF (LOAD_EN = '1') THEN
          D_OUT <= REG(N-1);
          FOR I IN N-1 DOWNTO 1 LOOP
            REG(I) <= REG(I-1);
          END LOOP;
		  REG(0) <= D_IN;
		 ELSIF(SHIFT_EN = '1') THEN
		     D_OUT <= REG(N-1);
			 FOR I IN N-2 DOWNTO 0 LOOP
             REG(I+1) <= REG(I);
             END LOOP;
		 END IF;		
      END IF;
	  
  END PROCESS;
  REG_OUT <= REG;

END ARCHITECTURE;
