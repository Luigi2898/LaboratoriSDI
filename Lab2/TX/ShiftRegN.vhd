LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SHIFTREGN IS
  GENERIC(
    N : INTEGER := 10
  );
  PORT (
    CLOCK    : IN STD_LOGIC;
    SHIFT_EN : IN STD_LOGIC;
    LOAD_EN  : IN STD_LOGIC;
    RSTN     : IN STD_LOGIC;
    D_IN     : IN STD_LOGIC_VECTOR(N-3 DOWNTO 0);
    D_OUT    : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF SHIFTREGN IS

  SIGNAL REG : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN

  SHIFT : PROCESS(CLOCK)
  BEGIN
    IF (CLOCK'EVENT AND CLOCK = '1') THEN
      IF (RSTN = '0') THEN
        REG <= (OTHERS => '1');
      ELSIF (LOAD_EN = '1') THEN
          REG(N-1)         <= '1';
          REG(0)           <= '0';
          REG(N-2 DOWNTO 1) <= D_IN;
        ELSIF (SHIFT_EN = '1') THEN
          D_OUT <= REG(0);
          FOR I IN 0 TO N-2 LOOP
            REG(I) <= REG(I+1);
          END LOOP;
        END IF;
      END IF;
  END PROCESS;

END ARCHITECTURE;
