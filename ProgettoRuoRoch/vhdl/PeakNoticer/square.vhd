library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;

entity square is
  port (
    in1 : in signed(13 downto 0);
    sq  : out signed(27 downto 0)
  );
end entity;

architecture arch of square is

begin

  sq <= in1 * in1;

end architecture;
