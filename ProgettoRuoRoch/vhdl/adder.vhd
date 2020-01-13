library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity adder is
  port (
    in1, in2 : in std_logic_vector(24 downto 0);
    res      : out std_logic_vector(25 downto 0)
  );
end entity;

architecture arch of adder is

begin

  res <= to_intger(signed(in1)) + to_intger(signed(in2));

end architecture;
