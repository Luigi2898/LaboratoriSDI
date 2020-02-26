library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Butterfly is
  port (
  clk : in std_logic;
  rst : in std_logic;
  Ai, Ar    : IN SIGNED(23 DOWNTO 0);
  Bi, Br    : IN SIGNED(23 DOWNTO 0);
  Wi, Wr    : IN SIGNED(23 DOWNTO 0);
  start : in std_logic;
  Aip, Arp : out signed(23 downto 0);
  Bip, Brp : out signed(23 downto 0);
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
    uIR     : buffer std_logic_vector(28 downto 0)
  );
  end component uSequencer;

  component DATAPATH
  port (
    CLOCK    : IN  STD_LOGIC;
    Ai, Ar    : IN SIGNED(23 DOWNTO 0);
    Bi, Br    : IN SIGNED(23 DOWNTO 0);
    Wi, Wr    : IN SIGNED(23 DOWNTO 0);
    CONTROLS : IN  STD_LOGIC_VECTOR(24 DOWNTO 0);
    EXT      : OUT SIGNED(46 DOWNTO 0)
  );
  end component DATAPATH;

  component Registro
generic (
  Nbit : integer := 8
);
port (
  DataIn      : in  SIGNED(Nbit-1 downto 0);
  DataOut     : out SIGNED(Nbit-1 downto 0);
  EN_REGISTRO : IN  STD_LOGIC;
  clock       : in  std_logic;
  reset       : in  std_logic
);
end component Registro;


  signal ist : std_logic_vector(28 downto 0);
  signal outlong : signed(46 downto 0);
  signal out_rom : signed(23 downto 0);

begin

  uS : uSequencer port map(clk, rst, start, done, start_next, Ist);

  dp : DATAPATH port map(clk, Ai, Ar, Bi, Br, Wi, Wr, Ist(28 downto 4), outlong);

  out_rom <= outlong(46 downto 23);

  Aip_reg : Registro generic map(24)
                     port map(out_rom, Aip, Ist(0), clk, rst);
  Arp_reg : Registro generic map(24)
                     port map(out_rom, Arp, Ist(1), clk, rst);
  Bip_reg : Registro generic map(24)
                     port map(out_rom, Bip, Ist(2), clk, rst);
  Brp_reg : Registro generic map(24)
                     port map(out_rom, Brp, Ist(3), clk, rst);

end architecture;
