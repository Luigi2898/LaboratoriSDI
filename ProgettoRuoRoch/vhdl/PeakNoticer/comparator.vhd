library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity comparator is
  port (
    to_cmp, to_be_cmp : in signed(37 downto 0);
    maj               : out std_logic
  );
end entity;

architecture arch of comparator is

begin

  maj <= '0' when to_cmp < to_be_cmp else '1';

end architecture;
