LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY STARTBITFINDER IS
  PORT (
    FRAME : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    STARTBIT : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF STARTBITFINDER IS

  BEGIN

  STARTBIT <= FRAME(3) AND FRAME(2) AND FRAME(1) AND FRAME(0) AND NOT(FRAME(7)) AND NOT(FRAME(6)) AND NOT(FRAME(5)) AND NOT(FRAME(4));

END ARCHITECTURE;
