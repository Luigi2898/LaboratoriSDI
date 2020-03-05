LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL;

ENTITY GENERIC_ROM IS
	GENERIC(INITFILE : STRING := "POLYPHASE.TXT";
          NUM_ADD : integer := 8);
    PORT (
          ADDRESS     : IN UNSIGNED;
          DATAOUT     : OUT SIGNED
  );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF GENERIC_ROM IS

  TYPE ROM_TYPE IS ARRAY (0 TO NUM_ADD) OF SIGNED(DATAOUT'LENGTH-1 DOWNTO 0);

  IMPURE FUNCTION INITROMFROMFILE RETURN ROM_TYPE IS
    FILE DATA_FILE : TEXT OPEN READ_MODE IS INITFILE;
    VARIABLE DATA_LINE : LINE;
	VARIABLE TEMP_BV : BIT_VECTOR(DATAOUT'LENGTH-1 DOWNTO 0);
    VARIABLE ROM_CONTENT : ROM_TYPE;
  BEGIN
    FOR I IN 0 TO NUM_ADD LOOP
    READLINE(DATA_FILE, DATA_LINE);
    READ(DATA_LINE, TEMP_BV);
	ROM_CONTENT(I) := SIGNED(TO_STDLOGICVECTOR(TEMP_BV));
    END LOOP;
    RETURN ROM_CONTENT;
  END FUNCTION;


  SIGNAL ROM : ROM_TYPE := INITROMFROMFILE;

  BEGIN

		 DATAOUT <= ROM(TO_INTEGER(UNSIGNED(ADDRESS)));


 END ARCHITECTURE;