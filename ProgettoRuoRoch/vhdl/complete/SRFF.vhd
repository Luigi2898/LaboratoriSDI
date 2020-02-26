library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity SRFF is
  port (
    clk : in std_logic;
    S   : in std_logic;
    r   : in std_logic;
    q   : buffer std_logic
  );
end entity;

architecture beh of SRFF is

  signal nq : std_logic := '0';

begin

beha : process(clk)
begin
  if clk'event and clk = '1' then
    if s = '1' and r = '0' then
      nq <= '1';
    elsif s = '0' and r = '1' then
      nq <= '0';
    elsif (s = '0' and r = '0') or (s = '1' and r = '1') then
      nq <= q;
    end if;
    q <= nq;
  end if;
end process;

end architecture;
