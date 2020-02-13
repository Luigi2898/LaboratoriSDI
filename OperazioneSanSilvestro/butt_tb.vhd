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
    In1, In2 : in signed(23 downto 0);
    start : in std_logic;
    out1 : out signed(46 downto 0);
    start_next : out std_logic;
    done : out std_logic
    );
  end component;

  signal clk : std_logic;
  signal rst :  std_logic;
  signal In1, In2 : signed(23 downto 0);
  signal start : std_logic;
  signal out1 : signed(46 downto 0);
  signal start_next :  std_logic;
  signal done : std_logic;
  signal cinque : integer := 5;
  signal sei : integer := 6;
  signal sette : integer := 7;
  signal otto : integer := 8;
  signal nove : integer := 9;
  signal dieci : integer := 10;
  signal zero : integer := 0;

begin

  butt : Butterfly port map(clk, rst, In1, In2, start, out1, start_next, done);

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
  in1 <= to_signed(zero, 24);
  in2 <= to_signed(zero, 24);
  wait for 40 ns;
  in1 <= to_signed(cinque, 24);
  in2 <= to_signed(zero, 24);
  wait for 10 ns;
  in1 <= to_signed(sette, 24);
  in2 <= to_signed(nove, 24);
  wait for 10 ns;
  in1 <= to_signed(sei, 24);
  in2 <= to_signed(nove, 24);
  wait for 10 ns;
  in1 <= to_signed(otto, 24);
  in2 <= to_signed(dieci, 24);
  wait for 50 ns;
  in1 <= to_signed(sei, 24);
  in2 <= to_signed(zero, 24);
  wait for 10 ns;
  in1 <= to_signed(otto, 24);
  in2 <= to_signed(dieci, 24);
  wait for 10 ns;
  in1 <= to_signed(nove, 24);
  in2 <= to_signed(dieci, 24);
  wait for 10 ns;
  in1 <= to_signed(cinque, 24);
  in2 <= to_signed(sette, 24);
  wait;
end process;

end architecture;
