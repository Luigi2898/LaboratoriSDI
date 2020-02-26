library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use IEEE.STD_LOGIC_SIGNED.ALL;

entity sub is
  generic (Nbit : integer :=8);
  port (

  data_1 : in signed(Nbit-1 downto 0);
  data_2 : in signed(Nbit-1 downto 0);
  sub   : out signed(Nbit-1 downto 0)

  );
end entity;

architecture behavioural of sub is
--signal zeta: signed(Nbit-1 downto 0) := (others => 'Z');
begin

process (data_1, data_2)
begin
--if ((not(data_1= zeta)) and (not(data_2= zeta))) then
  sub <= data_1-data_2;
--end if;
end process;



end architecture;
