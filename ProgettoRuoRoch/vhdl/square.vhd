library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity square is
  port (
    in1 : in std_logic_vector(11 downto 0);
    sq  : out std_logic_vector(23 downto 0)
  );
end entity;

architecture arch of square is

begin

  sq <= to_intger(signed(in1)) * to_intger(signed(in1));

end architecture;
