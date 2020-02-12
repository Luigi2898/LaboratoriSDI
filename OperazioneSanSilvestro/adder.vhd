library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity adder is
  generic (Nbit : integer :=8);
  port (

  data_1 : in std_logic_vector(Nbit-1 downto 0);
  data_2 : in std_logic_vector(Nbit-1 downto 0);
  add    : out std_logic_vector(Nbit-1 downto 0)

  );
end entity;

architecture behavioural of adder is
--signal zeta: std_logic_vector(Nbit-1 downto 0) := (others => 'Z');
begin

process (data_1, data_2)
begin
--if ((not(data_1= zeta)) and (not(data_2= zeta))) then
  add <= data_1+data_2;
--end if;
end process;



end architecture;
