library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Bas is
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

architecture behavioural of Bas is

  component TRISTATE IS
  	GENERIC(N : INTEGER := 1);
  	PORT(
      D_IN  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
  		D_OUT : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
  		EN    : IN STD_LOGIC
  	);
  END component;

  signal internalBus : std_logic_vector(Parallelism - 1 downto 0);

begin

  ingen : for i in 0 to Ninput - 1 generate
    intri : TRISTATE generic map(Parallelism) port map(ins(Parallelism * (i + 1) - 1 downto Parallelism * i), internalBus, inputEnable(i));
  end generate;

  outgen : for i in 0 to Noutput - 1 generate
    outtri : TRISTATE generic map(Parallelism) port map(internalBus, outs(Parallelism * (i + 1) - 1 downto Parallelism * i), outputEnable(i));
  end generate;

end architecture;
