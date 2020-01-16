library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity FilterSerial is
  port (
    sw          : in std_logic_vector(7 downto 0);
    clock_50    : in std_logic;
    hps_uart_tx : out std_logic
  );
end entity;

architecture arch of FilterSerial is

begin

end architecture;
