LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

ENTITY DECODER IS
	PORT(W  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Y  : OUT STD_LOGIC_VECTOR(45 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF DECODER IS

BEGIN

DEC : PROCESS(W)
  BEGIN
    CASE W IS
      WHEN "0000" => Y <= "0000000000000000000000000000000000000000000000";
      WHEN "0001" => Y <= "0000110000000000000000000000000000000000000000";
      WHEN "0010" => Y <= "1100100100000000000000000000010010100100000001";
      WHEN "0011" => Y <= "1010000010000100000100100000000000001100000000";
      WHEN "0100" => Y <= "1010101010001000000010000001010000000000000010";
      WHEN "0101" => Y <= "0000000000000000000001100000010100100100000000";
      WHEN "0110" => Y <= "0000000000000000000100100000000000010100000000";
      WHEN "0111" => Y <= "0000000000011001010000000000001001000000110000";
      WHEN "1000" => Y <= "0000000000101010101001010000000000000000001100";
      WHEN "1001" => Y <= "0000000000010101010001011010010100000000000000";
      WHEN "1010" => Y <= "0000000000000010100000000000010101000001100000";
      WHEN "1011" => Y <= "0000000000000011110010010110001000000000000000";
      WHEN "1100" => Y <= "0000000000000000100000000000000000000000000000";
      WHEN OTHERS => Y <= "0000000000000000000000000000000000000000000000";
    END CASE;
END PROCESS;
END ARCHITECTURE;
