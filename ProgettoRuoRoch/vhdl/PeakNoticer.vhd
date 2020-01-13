library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk  : in std_logic; --
    sign : in std_logic_vector(11 downto 0);
    peak : out std_logic;
  );
end entity;

architecture arch of PeakNoticer is

begin

end architecture;
