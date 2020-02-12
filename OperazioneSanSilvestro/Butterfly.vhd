library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Butterfly is
  port (
  clk : in std_logic;
  rst : in std_logic;
  In1, In2 : in signed(23 downto 0);
  start : in std_logic;
  out1 : out signed(46 downto 0);
  start_next : out std_logic;
  done : out std_logic
  );
end entity;

architecture arch of Butterfly is
  component uSequencer
  port (
    clk     : in  std_logic;
    rst     : in  std_logic;
    start   : in  std_logic;
    done    : out std_logic;
    str_nxt : out std_logic;
    uIR     : buffer std_logic_vector(24 downto 0)
  );
  end component uSequencer;

  component DATAPATH
  port (
    CLOCK    : IN  STD_LOGIC;
    EXT1     : IN  SIGNED(23 DOWNTO 0);
    EXT2     : IN  SIGNED(23 DOWNTO 0);
    CONTROLS : IN  STD_LOGIC_VECTOR(24 DOWNTO 0);
    EXT      : OUT SIGNED(46 DOWNTO 0)
  );
  end component DATAPATH;

  signal ist : std_logic_vector(24 downto 0);

begin

  uS : uSequencer port map(clk, rst, start, done, start_next, Ist);

  dp : DATAPATH port map(clk, in1, in2, Ist, out1);
  
end architecture;
