library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity Multiplier is
  generic(Nbit : integer := 8);
  port (
    In1   : in signed(Nbit - 1 downto 0);
    In2   : in signed(Nbit - 1 downto 0);
    Mult2 : in std_logic; -- Se '1' multiplica In1 per 2, altrimenti moltiplica i due ingressi
    clk   : in std_logic;
    Res   : out signed(2 * Nbit - 2 downto 0)
  );
end entity;

architecture behavioural of Multiplier is

  signal mult, mult_f, mult_s, shift : signed(2 * Nbit - 1 downto 0);

begin
--FIXME AGGIUNGERE RESET!!!!!!!!
  mult <= In1 * In2;
  shift(2 * Nbit - 1 downto Nbit) <= In1(Nbit - 1 downto 0);
  sihft(Nbit - 1 downto 0) <= (others => '0');
  --shift(0) <= '0';
  --shift(Nbit downto 1) <= In1;
  --shift(2 * Nbit - 1 downto Nbit + 1) <= (others => In1(Nbit - 1));

  mult_proc : process(clk)
  begin
    if (clk'event and clk = '1') then
      mult_f <= mult;
      mult_s <= mult_f;
    end if;
  end process;

  Res <= mult_s(Nbit*2 - 2 downto 0) when Mult2 = '0' else shift(Nbit*2 - 2 downto 0) when Mult2 = '1';
end architecture;
