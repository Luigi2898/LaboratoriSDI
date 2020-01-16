library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_signed.all;

entity adder is
  port (
    in1, in2 : in signed(31 downto 0);
    res      : out signed(31 downto 0)
  );
end entity;

architecture arch of adder is

begin

  res <= in1 + in2;

end architecture;
