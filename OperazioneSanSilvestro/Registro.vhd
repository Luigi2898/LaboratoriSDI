library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Registro is
  generic(Nbit : integer := 8);
  port (
   DataIn  : in SIGNED(Nbit-1 downto 0);
   DataOut : out SIGNED(Nbit-1 downto 0);
   EN_REGISTRO : IN STD_LOGIC;
   clock   : in std_logic;
   reset   : in std_logic
  );
end entity;

architecture behavioural of  Registro is

begin

process(clock, reset)
begin
  if (reset = '0') then
    DataOut <= (others => '0');
  elsif (clock' event and clock = '1') then
    if (EN_REGISTRO = '1') then
     DataOut <= DataIn;
    end if;

  end if;
end process;



end architecture;
