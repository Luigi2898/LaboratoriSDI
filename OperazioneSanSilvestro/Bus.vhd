library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Bus is
  generic(
    Parallelism : integer := 8;
    Ninput      : integer := 3;
    Noutput     : integer := 2
  );
  port (
    inputEnable  : in std_logic_vector(Ninput - 1 downto 0);
    outputEnable : in std_logic_vector(Noutput - 1 downto 0);
    ins          : in std_logic_vector((Ninput * Parallelism) - 1 downto 0);
    outs         : out std_logic_vector((Noutput * Parallelism) - 1 downto 0)
  );
end entity;

architecture behavioural of Bus is

  signal internalBus : std_logic_vector(Parallelism - 1 downto 0);

begin

  for i in 0 to Ninput - 1 loop
    if (inputEnable(i) = '1') then
      internalBus <= ins(Parallelism * (i + 1) downto Parallelism * i);
    end if;
  end loop;

  for i in 0 to Noutput - 1 loop
    if (outputEnable(i) = '1') then
      outs(Parallelism * (i + 1) downto Parallelism * i) <= internalBus;
    else
      outs(Parallelism * (i + 1) downto Parallelism * i) <= (others => 'Z');
    end if;
  end loop;

end architecture;
