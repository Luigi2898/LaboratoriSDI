library ieee;
use ieee.std_logic_1164.all;

entity StartBitFinder is
  port (
    frame : in std_logic_vector(7 downto 0);
    startbit : out std_logic
  );
end entity;

architecture behavioural of StartBitFinder is

  begin

  startbit <= frame(7) and frame(6) and frame(5) and frame(4) and not(frame(3)) and not(frame(2)) and not(frame(1)) and not(frame(0));

end architecture;
