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

  startbit <= frame(3) and frame(2) and frame(1) and frame(0) and not(frame(7)) and not(frame(6)) and not(frame(5)) and not(frame(4));

end architecture;
