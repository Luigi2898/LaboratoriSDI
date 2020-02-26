library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity butt_tb is
end entity;

architecture arch of butt_tb is

  component Butterfly is
    port (
    clk : in std_logic;
    rst : in std_logic;
    Ai, Ar    : IN SIGNED(23 DOWNTO 0);
    Bi, Br    : IN SIGNED(23 DOWNTO 0);
    Wi, Wr    : IN SIGNED(23 DOWNTO 0);
    start : in std_logic;
    Aip, Arp : out signed(46 downto 0);
    Bip, Brp : out signed(46 downto 0);
    start_next : out std_logic;
    done : out std_logic
    );
  end component;

  signal clk : std_logic;
  signal rst :  std_logic;
  signal start : std_logic;
  signal start_next :  std_logic;
  signal done : std_logic;
  signal cinque : integer := 5;
  signal sei : integer := 6;
  signal sette : integer := 7;
  signal otto : integer := 8;
  signal nove : integer := 9;
  signal dieci : integer := 10;
  signal zero : integer := 0;
  signal Ai, Ar, Bi, Br, Wi, Wr : signed(23 downto 0);
  signal Aip, Arp, Bip, Brp : signed(46 downto 0);

begin

  butt : Butterfly port map(clk, rst, Ai, Ar, Bi, Br, Wi, Wr, start, Aip, Arp, Bip, Brp, start_next, done);

  clk_p : process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

rst_p : process
begin
  rst <= '0';
  wait for 30 ns;
  rst <= '1';
  wait;
end process;

start_p : process
begin
  start <= '0';
  wait for 30 ns;
  start <= '1';
  wait for 10 ns;
  start <= '0';
  wait for 70 ns;
  start <= '1';
  wait for 10 ns;
  start <= '0';
  wait;
end process;

in_p : process
begin
  Ar <= to_signed(cinque, 24);
  Ai <= to_signed(sei, 24);
  Br <= to_signed(sette, 24);
  Bi <= to_signed(otto, 24);
  Wr <= to_signed(nove, 24);
  Wi <= to_signed(dieci, 24);
  wait for 120 ns;
  Ar <= to_signed(sei, 24);
  Ai <= to_signed(nove, 24);
  Br <= to_signed(otto, 24);
  Bi <= to_signed(cinque, 24);
  Wr <= to_signed(dieci, 24);
  Wi <= to_signed(sette, 24);
  wait;
end process;

end architecture;
