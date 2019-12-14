library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Multiplier is
  generic(Nbit : integer := 8);
  port (
    In1   : in std_logic_vector(Nbit - 1 downto 0);
    In2   : in std_logic_vector(Nbit - 1 downto 0);
    Mult2 : in std_logic; -- Se '1' multiplica per 2, altrimenti moltiplica i due ingressi
    Res   : out std_logic_vector(2 * Nbit - 2 downto 0)
  );
end entity;

architecture behavioural of Multiplier is

begin
  
end architecture;
