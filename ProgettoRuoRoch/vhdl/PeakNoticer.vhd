library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk    : in std_logic; --clock
    rstN   : in std_logic; --reset active-low
    signa  : in std_logic_vector(11 downto 0); --input signal
    peak   : out std_logic; --notifies that the treshold is overcome
    -- debug signals
    energy : out std_logic_vector(16 downto 0); --outputs computed energy
    calc   : out std_logic --notifies that an energy has been computed
  );
end entity;

architecture arch of PeakNoticer is

  component Registro is
    generic(Nbit : integer := 8);
    port (
     DataIn  : in std_logic_vector(Nbit-1 downto 0);
     DataOut : out std_logic_vector(Nbit-1 downto 0);
     clock   : in std_logic;
     reset   : in std_logic
    );
  end component;

  type data is array of std_logic_vector(11 downto 0);
  signal reginputs, regoutputs : data(499 downto 0);

begin

  buffer : for i in 499 to 0 generate
    r : Registro(reginputs(i), regoutputs(i), clk, resetN);
  end generate;

end architecture;
