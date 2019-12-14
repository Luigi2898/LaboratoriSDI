library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Registro is
  generic(Nbit : integer := 8);
  port (
   DataIn  : in std_logic_vector(Nbit-1 downto 0);
   DataOut : out std_logic_vector(Nbit-1 downto 0);
   clock   : in std_logic;
   reset   : in std_logic
  );
end entity;

architecture behavioural of  Registro is

signal zeta: std_logic_vector(Nbit-1 downto 0) := (others => 'Z');


begin

process(clock, reset)
begin
  if (reset = '0') then
    DataOut <= (others => '0');
  elsif (clock' event and clock = '1') then
    if (not(DataIn = zeta)) then
     DataOut <= DataIn;
    end if;
  end if;

end process;



end architecture;
