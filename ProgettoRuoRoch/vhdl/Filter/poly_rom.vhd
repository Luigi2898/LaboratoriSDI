LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY POLY_ROM IS
	GENERIC(INITFILE : STRING := "POLYPHASE.TXT";
	ADDR_N : INTEGER := 15; DATA_WIDTH : INTEGER := 20);
	PORT (CLK : IN STD_LOGIC;
		  ADDRESS : IN UNSIGNED(ADDR_N-1 DOWNTO 0);
		  DATAOUT : OUT SIGNED(DATA_WIDTH-1 DOWNTO 0)
	);
END ENTITY; 
 

ARCHITECTURE BEH OF POLY_ROM IS 

COMPONENT GENERIC_ROM IS
	GENERIC(INITFILE : STRING := "POLYPHASE.TXT");
    PORT (CLK	      : IN STD_LOGIC;
          ADDRESS     : IN UNSIGNED; 
          DATAOUT     : OUT SIGNED
  );
END COMPONENT;
BEGIN
  P0 : GENERIC_ROM
  GENERIC MAP (INITFILE => INITFILE)
  PORT MAP (CLK => CLK, ADDRESS => ADDRESS, DATAOUT => DATAOUT);

END ARCHITECTURE; 