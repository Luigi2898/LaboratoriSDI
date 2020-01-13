library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity adder is
  port (
    in1, in2 : in std_logic_vector(24 downto 0);
    res      : out std_logic_vector(24 downto 0)
  );
end entity;

architecture arch of adder is

begin

  res <= in1 + in2;

end architecture;
