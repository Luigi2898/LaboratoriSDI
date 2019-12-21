library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity uSequencer is
  port (
    clk   : in std_logic;
    rst   : in std_logic;
    start : in std_logic;
    done  : out std_logic
  );
end entity;

architecture behavioural of uSequencer is

signal uAR : std_logic_vector(3 downto 0);
signal uIR : std_logic_vector(6 downto 0);

begin
  seq : process(clk)
    begin
      
  end process;
end architecture;
