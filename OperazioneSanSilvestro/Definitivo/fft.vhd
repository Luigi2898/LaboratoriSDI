library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity fft is
  port (
  clk      : in std_logic;
  rst      : in std_logic;
  start    : in std_logic;

  Xr0_in   : in signed(23 downto 0);
  Xi0_in   : in signed(23 downto 0);
  Xr1_in   : in signed(23 downto 0);
  Xi1_in   : in signed(23 downto 0);
  Xr2_in   : in signed(23 downto 0);
  Xi2_in   : in signed(23 downto 0);
  Xr3_in   : in signed(23 downto 0);
  Xi3_in   : in signed(23 downto 0);
  Xr4_in   : in signed(23 downto 0);
  Xi4_in   : in signed(23 downto 0);
  Xr5_in   : in signed(23 downto 0);
  Xi5_in   : in signed(23 downto 0);
  Xr6_in   : in signed(23 downto 0);
  Xi6_in   : in signed(23 downto 0);
  Xr7_in   : in signed(23 downto 0);
  Xi7_in   : in signed(23 downto 0);
  Xr8_in   : in signed(23 downto 0);
  Xi8_in   : in signed(23 downto 0);
  Xr9_in   : in signed(23 downto 0);
  Xi9_in   : in signed(23 downto 0);
  Xr10_in  : in signed(23 downto 0);
  Xi10_in  : in signed(23 downto 0);
  Xr11_in  : in signed(23 downto 0);
  Xi11_in  : in signed(23 downto 0);
  Xr12_in  : in signed(23 downto 0);
  Xi12_in  : in signed(23 downto 0);
  Xr13_in  : in signed(23 downto 0);
  Xi13_in  : in signed(23 downto 0);
  Xr14_in  : in signed(23 downto 0);
  Xi14_in  : in signed(23 downto 0);
  Xr15_in  : in signed(23 downto 0);
  Xi15_in  : in signed(23 downto 0);

  Wr0      : in signed(23 downto 0);
  Wi0      : in signed(23 downto 0);
  Wr1      : in signed(23 downto 0);
  Wi1      : in signed(23 downto 0);
  Wr2      : in signed(23 downto 0);
  Wi2      : in signed(23 downto 0);
  Wr3      : in signed(23 downto 0);
  Wi3      : in signed(23 downto 0);
  Wr4      : in signed(23 downto 0);
  Wi4      : in signed(23 downto 0);
  Wr5      : in signed(23 downto 0);
  Wi5      : in signed(23 downto 0);
  Wr6      : in signed(23 downto 0);
  Wi6      : in signed(23 downto 0);
  Wr7      : in signed(23 downto 0);
  Wi7      : in signed(23 downto 0);

  Xr0_out  : out signed(23 downto 0);
  Xi0_out  : out signed(23 downto 0);
  Xr1_out  : out signed(23 downto 0);
  Xi1_out  : out signed(23 downto 0);
  Xr2_out  : out signed(23 downto 0);
  Xi2_out  : out signed(23 downto 0);
  Xr3_out  : out signed(23 downto 0);
  Xi3_out  : out signed(23 downto 0);
  Xr4_out  : out signed(23 downto 0);
  Xi4_out  : out signed(23 downto 0);
  Xr5_out  : out signed(23 downto 0);
  Xi5_out  : out signed(23 downto 0);
  Xr6_out  : out signed(23 downto 0);
  Xi6_out  : out signed(23 downto 0);
  Xr7_out  : out signed(23 downto 0);
  Xi7_out  : out signed(23 downto 0);
  Xr8_out  : out signed(23 downto 0);
  Xi8_out  : out signed(23 downto 0);
  Xr9_out  : out signed(23 downto 0);
  Xi9_out  : out signed(23 downto 0);
  Xr10_out : out signed(23 downto 0);
  Xi10_out : out signed(23 downto 0);
  Xr11_out : out signed(23 downto 0);
  Xi11_out : out signed(23 downto 0);
  Xr12_out : out signed(23 downto 0);
  Xi12_out : out signed(23 downto 0);
  Xr13_out : out signed(23 downto 0);
  Xi13_out : out signed(23 downto 0);
  Xr14_out : out signed(23 downto 0);
  Xi14_out : out signed(23 downto 0);
  Xr15_out : out signed(23 downto 0);
  Xi15_out : out signed(23 downto 0);

  done     : out std_logic
  );
end entity;

architecture beh of fft is

  component Butterfly
  port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    Ai, Ar     : IN  SIGNED(23 DOWNTO 0);
    Bi, Br     : IN  SIGNED(23 DOWNTO 0);
    Wi, Wr     : IN  SIGNED(23 DOWNTO 0);
    start      : in  std_logic;
    Aip, Arp   : out signed(23 downto 0);
    Bip, Brp   : out signed(23 downto 0);
    start_next : out std_logic;
    done       : out std_logic
  );
  end component Butterfly;

  signal Aip11 : signed(23 downto 0);
  signal Arp11 : signed(23 downto 0);
  signal Bip11 : signed(23 downto 0);
  signal Brp11 : signed(23 downto 0);
  signal Aip12 : signed(23 downto 0);
  signal Arp12 : signed(23 downto 0);
  signal Bip12 : signed(23 downto 0);
  signal Brp12 : signed(23 downto 0);
  signal Aip13 : signed(23 downto 0);
  signal Arp13 : signed(23 downto 0);
  signal Bip13 : signed(23 downto 0);
  signal Brp13 : signed(23 downto 0);
  signal Aip14 : signed(23 downto 0);
  signal Arp14 : signed(23 downto 0);
  signal Bip14 : signed(23 downto 0);
  signal Brp14 : signed(23 downto 0);
  signal Aip15 : signed(23 downto 0);
  signal Arp15 : signed(23 downto 0);
  signal Bip15 : signed(23 downto 0);
  signal Brp15 : signed(23 downto 0);
  signal Aip16 : signed(23 downto 0);
  signal Arp16 : signed(23 downto 0);
  signal Bip16 : signed(23 downto 0);
  signal Brp16 : signed(23 downto 0);
  signal Aip17 : signed(23 downto 0);
  signal Arp17 : signed(23 downto 0);
  signal Bip17 : signed(23 downto 0);
  signal Brp17 : signed(23 downto 0);
  signal Aip18 : signed(23 downto 0);
  signal Arp18 : signed(23 downto 0);
  signal Bip18 : signed(23 downto 0);
  signal Brp18 : signed(23 downto 0);

  signal Aip21 : signed(23 downto 0);
  signal Arp21 : signed(23 downto 0);
  signal Bip21 : signed(23 downto 0);
  signal Brp21 : signed(23 downto 0);
  signal Aip22 : signed(23 downto 0);
  signal Arp22 : signed(23 downto 0);
  signal Bip22 : signed(23 downto 0);
  signal Brp22 : signed(23 downto 0);
  signal Aip23 : signed(23 downto 0);
  signal Arp23 : signed(23 downto 0);
  signal Bip23 : signed(23 downto 0);
  signal Brp23 : signed(23 downto 0);
  signal Aip24 : signed(23 downto 0);
  signal Arp24 : signed(23 downto 0);
  signal Bip24 : signed(23 downto 0);
  signal Brp24 : signed(23 downto 0);
  signal Aip25 : signed(23 downto 0);
  signal Arp25 : signed(23 downto 0);
  signal Bip25 : signed(23 downto 0);
  signal Brp25 : signed(23 downto 0);
  signal Aip26 : signed(23 downto 0);
  signal Arp26 : signed(23 downto 0);
  signal Bip26 : signed(23 downto 0);
  signal Brp26 : signed(23 downto 0);
  signal Aip27 : signed(23 downto 0);
  signal Arp27 : signed(23 downto 0);
  signal Bip27 : signed(23 downto 0);
  signal Brp27 : signed(23 downto 0);
  signal Aip28 : signed(23 downto 0);
  signal Arp28 : signed(23 downto 0);
  signal Bip28 : signed(23 downto 0);
  signal Brp28 : signed(23 downto 0);

  signal Aip31 : signed(23 downto 0);
  signal Arp31 : signed(23 downto 0);
  signal Bip31 : signed(23 downto 0);
  signal Brp31 : signed(23 downto 0);
  signal Aip32 : signed(23 downto 0);
  signal Arp32 : signed(23 downto 0);
  signal Bip32 : signed(23 downto 0);
  signal Brp32 : signed(23 downto 0);
  signal Aip33 : signed(23 downto 0);
  signal Arp33 : signed(23 downto 0);
  signal Bip33 : signed(23 downto 0);
  signal Brp33 : signed(23 downto 0);
  signal Aip34 : signed(23 downto 0);
  signal Arp34 : signed(23 downto 0);
  signal Bip34 : signed(23 downto 0);
  signal Brp34 : signed(23 downto 0);
  signal Aip35 : signed(23 downto 0);
  signal Arp35 : signed(23 downto 0);
  signal Bip35 : signed(23 downto 0);
  signal Brp35 : signed(23 downto 0);
  signal Aip36 : signed(23 downto 0);
  signal Arp36 : signed(23 downto 0);
  signal Bip36 : signed(23 downto 0);
  signal Brp36 : signed(23 downto 0);
  signal Aip37 : signed(23 downto 0);
  signal Arp37 : signed(23 downto 0);
  signal Bip37 : signed(23 downto 0);
  signal Brp37 : signed(23 downto 0);
  signal Aip38 : signed(23 downto 0);
  signal Arp38 : signed(23 downto 0);
  signal Bip38 : signed(23 downto 0);
  signal Brp38 : signed(23 downto 0);

  signal start_next1 : std_logic_vector(7 downto 0);
  signal done1       : std_logic_vector(7 downto 0);
  signal start_next2 : std_logic_vector(7 downto 0);
  signal done2       : std_logic_vector(7 downto 0);
  signal start_next3 : std_logic_vector(7 downto 0);
  signal done3       : std_logic_vector(7 downto 0);
  signal start_next4 : std_logic_vector(7 downto 0);
  signal done4       : std_logic_vector(7 downto 0);

  signal start2 : std_logic;
  signal start3 : std_logic;
  signal start4 : std_logic;

begin

--PRIMO STADIO
  butt11 : Butterfly port map(clk => clk, rst => rst, Ai => Xi0_in, Ar => Xr0_in, Bi => Xi8_in,  Br => Xr8_in,  Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip11, Arp => Arp11, Bip => Bip11, Brp => Brp11, start_next => start_next1(0), done => done1(0));
  butt12 : Butterfly port map(clk => clk, rst => rst, Ai => Xi1_in, Ar => Xr1_in, Bi => Xi9_in,  Br => Xr9_in,  Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip12, Arp => Arp12, Bip => Bip12, Brp => Brp12, start_next => start_next1(1), done => done1(1));
  butt13 : Butterfly port map(clk => clk, rst => rst, Ai => Xi2_in, Ar => Xr2_in, Bi => Xi10_in, Br => Xr10_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip13, Arp => Arp13, Bip => Bip13, Brp => Brp13, start_next => start_next1(2), done => done1(2));
  butt14 : Butterfly port map(clk => clk, rst => rst, Ai => Xi3_in, Ar => Xr3_in, Bi => Xi11_in, Br => Xr11_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip14, Arp => Arp14, Bip => Bip14, Brp => Brp14, start_next => start_next1(3), done => done1(3));
  butt15 : Butterfly port map(clk => clk, rst => rst, Ai => Xi4_in, Ar => Xr4_in, Bi => Xi12_in, Br => Xr12_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip15, Arp => Arp15, Bip => Bip15, Brp => Brp15, start_next => start_next1(4), done => done1(4));
  butt16 : Butterfly port map(clk => clk, rst => rst, Ai => Xi5_in, Ar => Xr5_in, Bi => Xi13_in, Br => Xr13_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip16, Arp => Arp16, Bip => Bip16, Brp => Brp16, start_next => start_next1(5), done => done1(5));
  butt17 : Butterfly port map(clk => clk, rst => rst, Ai => Xi6_in, Ar => Xr6_in, Bi => Xi14_in, Br => Xr14_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip17, Arp => Arp17, Bip => Bip17, Brp => Brp17, start_next => start_next1(6), done => done1(6));
  butt18 : Butterfly port map(clk => clk, rst => rst, Ai => Xi7_in, Ar => Xr7_in, Bi => Xi15_in, Br => Xr15_in, Wi => Wi0,  Wr => Wr0, start => start, Aip => Aip18, Arp => Arp18, Bip => Bip18, Brp => Brp18, start_next => start_next1(7), done => done1(7));

--SECONDO STADIO
  start2 <= start_next1(0) and start_next1(1) and start_next1(2) and start_next1(3) and start_next1(4) and start_next1(5) and start_next1(6) and start_next1(7);

  butt21 : Butterfly port map(clk => clk, rst => rst, Ai => Aip11, Ar => Arp11, Bi => Aip15, Br => Arp15, Wi => Wi0,  Wr => Wr0, start => start2, Aip => Aip21, Arp => Arp21, Bip => Bip21, Brp => Brp21, start_next => start_next2(0), done => done2(0));
  butt22 : Butterfly port map(clk => clk, rst => rst, Ai => Aip12, Ar => Arp12, Bi => Aip16, Br => Arp16, Wi => Wi0,  Wr => Wr0, start => start2, Aip => Aip22, Arp => Arp22, Bip => Bip22, Brp => Brp22, start_next => start_next2(1), done => done2(1));
  butt23 : Butterfly port map(clk => clk, rst => rst, Ai => Aip13, Ar => Arp13, Bi => Aip17, Br => Arp17, Wi => Wi0,  Wr => Wr0, start => start2, Aip => Aip23, Arp => Arp23, Bip => Bip23, Brp => Brp23, start_next => start_next2(2), done => done2(2));
  butt24 : Butterfly port map(clk => clk, rst => rst, Ai => Aip14, Ar => Arp14, Bi => Aip18, Br => Arp18, Wi => Wi0,  Wr => Wr0, start => start2, Aip => Aip24, Arp => Arp24, Bip => Bip24, Brp => Brp24, start_next => start_next2(3), done => done2(3));

  butt25 : Butterfly port map(clk => clk, rst => rst, Ai => Bip11, Ar => Brp11, Bi => Bip15, Br => Brp15, Wi => Wi4,  Wr => Wr4, start => start2, Aip => Aip25, Arp => Arp25, Bip => Bip25, Brp => Brp25, start_next => start_next2(4), done => done2(4));
  butt26 : Butterfly port map(clk => clk, rst => rst, Ai => Bip12, Ar => Brp12, Bi => Bip16, Br => Brp16, Wi => Wi4,  Wr => Wr4, start => start2, Aip => Aip26, Arp => Arp26, Bip => Bip26, Brp => Brp26, start_next => start_next2(5), done => done2(5));
  butt27 : Butterfly port map(clk => clk, rst => rst, Ai => Bip13, Ar => Brp13, Bi => Bip17, Br => Brp17, Wi => Wi4,  Wr => Wr4, start => start2, Aip => Aip27, Arp => Arp27, Bip => Bip27, Brp => Brp27, start_next => start_next2(6), done => done2(6));
  butt28 : Butterfly port map(clk => clk, rst => rst, Ai => Bip14, Ar => Brp14, Bi => Bip18, Br => Brp18, Wi => Wi4,  Wr => Wr4, start => start2, Aip => Aip28, Arp => Arp28, Bip => Bip28, Brp => Brp28, start_next => start_next2(7), done => done2(7));

--TERZO STADIO

  start3 <= start_next2(0) and start_next2(1) and start_next2(2) and start_next2(3) and start_next2(4) and start_next2(5) and start_next2(6) and start_next2(7);

  butt31 : Butterfly port map(clk => clk, rst => rst, Ai => Aip21, Ar => Arp21, Bi => Aip23, Br => Arp23, Wi => Wi0,  Wr => Wr0, start => start3, Aip => Aip31, Arp => Arp31, Bip => Bip31, Brp => Brp31, start_next => start_next3(0), done => done3(0));
  butt32 : Butterfly port map(clk => clk, rst => rst, Ai => Aip22, Ar => Arp22, Bi => Aip24, Br => Arp24, Wi => Wi0,  Wr => Wr0, start => start3, Aip => Aip32, Arp => Arp32, Bip => Bip32, Brp => Brp32, start_next => start_next3(1), done => done3(1));

  butt33 : Butterfly port map(clk => clk, rst => rst, Ai => Bip21, Ar => Brp21, Bi => Bip23, Br => Brp23, Wi => Wi4,  Wr => Wr4, start => start3, Aip => Aip33, Arp => Arp33, Bip => Bip33, Brp => Brp33, start_next => start_next3(2), done => done3(2));
  butt34 : Butterfly port map(clk => clk, rst => rst, Ai => Bip22, Ar => Brp22, Bi => Bip24, Br => Brp24, Wi => Wi4,  Wr => Wr4, start => start3, Aip => Aip34, Arp => Arp34, Bip => Bip34, Brp => Brp34, start_next => start_next3(3), done => done3(3));

  butt35 : Butterfly port map(clk => clk, rst => rst, Ai => Aip25, Ar => Arp25, Bi => Aip27, Br => Arp27, Wi => Wi2,  Wr => Wr2, start => start3, Aip => Aip35, Arp => Arp35, Bip => Bip35, Brp => Brp35, start_next => start_next3(4), done => done3(4));
  butt36 : Butterfly port map(clk => clk, rst => rst, Ai => Aip26, Ar => Arp26, Bi => Aip28, Br => Arp28, Wi => Wi2,  Wr => Wr2, start => start3, Aip => Aip36, Arp => Arp36, Bip => Bip36, Brp => Brp36, start_next => start_next3(5), done => done3(5));

  butt37 : Butterfly port map(clk => clk, rst => rst, Ai => Bip25, Ar => Brp25, Bi => Bip27, Br => Brp27, Wi => Wi6,  Wr => Wr6, start => start3, Aip => Aip37, Arp => Arp37, Bip => Bip37, Brp => Brp37, start_next => start_next3(6), done => done3(6));
  butt38 : Butterfly port map(clk => clk, rst => rst, Ai => Bip26, Ar => Brp26, Bi => Bip28, Br => Brp28, Wi => Wi6,  Wr => Wr6, start => start3, Aip => Aip38, Arp => Arp38, Bip => Bip38, Brp => Brp38, start_next => start_next3(7), done => done3(7));

--QUARTO STADIO
  start4 <= start_next3(0) and start_next3(1) and start_next3(2) and start_next3(3) and start_next3(4) and start_next3(5) and start_next3(6) and start_next3(7);

  butt41 : Butterfly port map(clk => clk, rst => rst, Ai => Aip31, Ar => Arp31, Bi => Aip32, Br => Arp32, Wi => Wi0,  Wr => Wr0, start => start4, Aip => Xi0_out, Arp => Xr0_out, Bip => Xi8_out, Brp => Xr8_out, start_next => start_next4(0), done => done4(0));
  butt42 : Butterfly port map(clk => clk, rst => rst, Ai => Bip31, Ar => Brp31, Bi => Bip32, Br => Brp32, Wi => Wi4,  Wr => Wr4, start => start4, Aip => Xi4_out, Arp => Xr4_out, Bip => Xi12_out, Brp => Xr12_out, start_next => start_next4(1), done => done4(1));

  butt43 : Butterfly port map(clk => clk, rst => rst, Ai => Aip33, Ar => Arp33, Bi => Aip34, Br => Arp34, Wi => Wi2,  Wr => Wr2, start => start4, Aip => Xi2_out, Arp => Xr2_out, Bip => Xi10_out, Brp => Xr10_out, start_next => start_next4(2), done => done4(2));
  butt44 : Butterfly port map(clk => clk, rst => rst, Ai => Bip33, Ar => Brp33, Bi => Bip34, Br => Brp34, Wi => Wi6,  Wr => Wr6, start => start4, Aip => Xi6_out, Arp => Xr6_out, Bip => Xi14_out, Brp => Xr14_out, start_next => start_next4(3), done => done4(3));

  butt45 : Butterfly port map(clk => clk, rst => rst, Ai => Aip35, Ar => Arp35, Bi => Aip36, Br => Arp36, Wi => Wi1,  Wr => Wr1, start => start4, Aip => Xi1_out, Arp => Xr1_out, Bip => Xi9_out, Brp => Xr9_out, start_next => start_next4(4), done => done4(4));
  butt46 : Butterfly port map(clk => clk, rst => rst, Ai => Bip35, Ar => Brp35, Bi => Bip36, Br => Brp36, Wi => Wi5,  Wr => Wr5, start => start4, Aip => Xi5_out, Arp => Xr5_out, Bip => Xi13_out, Brp => Xr13_out, start_next => start_next4(5), done => done4(5));

  butt47 : Butterfly port map(clk => clk, rst => rst, Ai => Aip37, Ar => Arp37, Bi => Aip38, Br => Arp38, Wi => Wi3,  Wr => Wr3, start => start4, Aip => Xi3_out, Arp => Xr3_out, Bip => Xi11_out, Brp => Xr11_out, start_next => start_next4(6), done => done4(6));
  butt48 : Butterfly port map(clk => clk, rst => rst, Ai => Bip37, Ar => Brp37, Bi => Bip38, Br => Brp38, Wi => Wi7, Wr => Wr7, start => start4, Aip => Xi7_out, Arp => Xr7_out, Bip => Xi15_out, Brp => Xr15_out, start_next => start_next4(7), done => done4(7));

  done <= done4(0) and done4(1) and done4(2) and done4(3) and done4(4) and done4(5) and done4(6) and done4(7);

end architecture;
