library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
    use ieee.std_logic_textio.all;
	use std.textio.all;
entity ss_tb_new is
end entity;

architecture arch of ss_tb_new is
  component fft
  port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    start    : in  std_logic;
    Xr0_in   : in  signed(23 downto 0);
    Xi0_in   : in  signed(23 downto 0);
    Xr1_in   : in  signed(23 downto 0);
    Xi1_in   : in  signed(23 downto 0);
    Xr2_in   : in  signed(23 downto 0);
    Xi2_in   : in  signed(23 downto 0);
    Xr3_in   : in  signed(23 downto 0);
    Xi3_in   : in  signed(23 downto 0);
    Xr4_in   : in  signed(23 downto 0);
    Xi4_in   : in  signed(23 downto 0);
    Xr5_in   : in  signed(23 downto 0);
    Xi5_in   : in  signed(23 downto 0);
    Xr6_in   : in  signed(23 downto 0);
    Xi6_in   : in  signed(23 downto 0);
    Xr7_in   : in  signed(23 downto 0);
    Xi7_in   : in  signed(23 downto 0);
    Xr8_in   : in  signed(23 downto 0);
    Xi8_in   : in  signed(23 downto 0);
    Xr9_in   : in  signed(23 downto 0);
    Xi9_in   : in  signed(23 downto 0);
    Xr10_in  : in  signed(23 downto 0);
    Xi10_in  : in  signed(23 downto 0);
    Xr11_in  : in  signed(23 downto 0);
    Xi11_in  : in  signed(23 downto 0);
    Xr12_in  : in  signed(23 downto 0);
    Xi12_in  : in  signed(23 downto 0);
    Xr13_in  : in  signed(23 downto 0);
    Xi13_in  : in  signed(23 downto 0);
    Xr14_in  : in  signed(23 downto 0);
    Xi14_in  : in  signed(23 downto 0);
    Xr15_in  : in  signed(23 downto 0);
    Xi15_in  : in  signed(23 downto 0);
    Wr0      : in  signed(23 downto 0);
    Wi0      : in  signed(23 downto 0);
    Wr1      : in  signed(23 downto 0);
    Wi1      : in  signed(23 downto 0);
    Wr2      : in  signed(23 downto 0);
    Wi2      : in  signed(23 downto 0);
    Wr3      : in  signed(23 downto 0);
    Wi3      : in  signed(23 downto 0);
    Wr4      : in  signed(23 downto 0);
    Wi4      : in  signed(23 downto 0);
    Wr5      : in  signed(23 downto 0);
    Wi5      : in  signed(23 downto 0);
    Wr6      : in  signed(23 downto 0);
    Wi6      : in  signed(23 downto 0);
    Wr7      : in  signed(23 downto 0);
    Wi7      : in  signed(23 downto 0);
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
end component fft;

  signal clk      : std_logic;
  signal rst      : std_logic;
  signal start    : std_logic;
  signal Xr0_in   : signed(23 downto 0);
  signal Xi0_in   : signed(23 downto 0);
  signal Xr1_in   : signed(23 downto 0);
  signal Xi1_in   : signed(23 downto 0);
  signal Xr2_in   : signed(23 downto 0);
  signal Xi2_in   : signed(23 downto 0);
  signal Xr3_in   : signed(23 downto 0);
  signal Xi3_in   : signed(23 downto 0);
  signal Xr4_in   : signed(23 downto 0);
  signal Xi4_in   : signed(23 downto 0);
  signal Xr5_in   : signed(23 downto 0);
  signal Xi5_in   : signed(23 downto 0);
  signal Xr6_in   : signed(23 downto 0);
  signal Xi6_in   : signed(23 downto 0);
  signal Xr7_in   : signed(23 downto 0);
  signal Xi7_in   : signed(23 downto 0);
  signal Xr8_in   : signed(23 downto 0);
  signal Xi8_in   : signed(23 downto 0);
  signal Xr9_in   : signed(23 downto 0);
  signal Xi9_in   : signed(23 downto 0);
  signal Xr10_in  : signed(23 downto 0);
  signal Xi10_in  : signed(23 downto 0);
  signal Xr11_in  : signed(23 downto 0);
  signal Xi11_in  : signed(23 downto 0);
  signal Xr12_in  : signed(23 downto 0);
  signal Xi12_in  : signed(23 downto 0);
  signal Xr13_in  : signed(23 downto 0);
  signal Xi13_in  : signed(23 downto 0);
  signal Xr14_in  : signed(23 downto 0);
  signal Xi14_in  : signed(23 downto 0);
  signal Xr15_in  : signed(23 downto 0);
  signal Xi15_in  : signed(23 downto 0);
  signal Wr0      : signed(23 downto 0) := "011111111111111111111111";
  signal Wi0      : signed(23 downto 0) := "000000000000000000000000";
  signal Wr1      : signed(23 downto 0) := "011101100100000110101111";
  signal Wi1      : signed(23 downto 0) := "110011110000010000111011";
  signal Wr2      : signed(23 downto 0) := "010110101000001001111010";
  signal Wi2      : signed(23 downto 0) := "101001010111110110000110";
  signal Wr3      : signed(23 downto 0) := "001100001111101111000101";
  signal Wi3      : signed(23 downto 0) := "100010011011111001010001";
  signal Wr4      : signed(23 downto 0) := "000000000000000000000000";
  signal Wi4      : signed(23 downto 0) := "100000000000000000000000";
  signal Wr5      : signed(23 downto 0) := "110011110000010000111011";
  signal Wi5      : signed(23 downto 0) := "100010011011111001010001";
  signal Wr6      : signed(23 downto 0) := "101001010111110110000110";
  signal Wi6      : signed(23 downto 0) := "101001010111110110000110";
  signal Wr7      : signed(23 downto 0) := "100010011011111001010001";
  signal Wi7      : signed(23 downto 0) := "110011110000010000111011";
  signal Xr0_out  : signed(23 downto 0);
  signal Xi0_out  : signed(23 downto 0);
  signal Xr1_out  : signed(23 downto 0);
  signal Xi1_out  : signed(23 downto 0);
  signal Xr2_out  : signed(23 downto 0);
  signal Xi2_out  : signed(23 downto 0);
  signal Xr3_out  : signed(23 downto 0);
  signal Xi3_out  : signed(23 downto 0);
  signal Xr4_out  : signed(23 downto 0);
  signal Xi4_out  : signed(23 downto 0);
  signal Xr5_out  : signed(23 downto 0);
  signal Xi5_out  : signed(23 downto 0);
  signal Xr6_out  : signed(23 downto 0);
  signal Xi6_out  : signed(23 downto 0);
  signal Xr7_out  : signed(23 downto 0);
  signal Xi7_out  : signed(23 downto 0);
  signal Xr8_out  : signed(23 downto 0);
  signal Xi8_out  : signed(23 downto 0);
  signal Xr9_out  : signed(23 downto 0);
  signal Xi9_out  : signed(23 downto 0);
  signal Xr10_out : signed(23 downto 0);
  signal Xi10_out : signed(23 downto 0);
  signal Xr11_out : signed(23 downto 0);
  signal Xi11_out : signed(23 downto 0);
  signal Xr12_out : signed(23 downto 0);
  signal Xi12_out : signed(23 downto 0);
  signal Xr13_out : signed(23 downto 0);
  signal Xi13_out : signed(23 downto 0);
  signal Xr14_out : signed(23 downto 0);
  signal Xi14_out : signed(23 downto 0);
  signal Xr15_out : signed(23 downto 0);
  signal Xi15_out : signed(23 downto 0);
  signal done     : std_logic;


TYPE ROM_TYPE IS ARRAY (0 TO 31) OF SIGNED(23 DOWNTO 0);

  IMPURE FUNCTION INITROMFROMFILE RETURN ROM_TYPE IS
    FILE DATA_FILE : TEXT OPEN READ_MODE IS "input_sin_cos.txt";
    VARIABLE DATA_LINE : LINE;
	VARIABLE TEMP_BV : BIT_VECTOR(23 DOWNTO 0);
    VARIABLE ROM_CONTENT : ROM_TYPE;
  BEGIN
    FOR I IN 0 TO 31 LOOP
    READLINE(DATA_FILE, DATA_LINE);
    READ(DATA_LINE, TEMP_BV);
	ROM_CONTENT(I) := SIGNED(TO_STDLOGICVECTOR(TEMP_BV));
    END LOOP;
    RETURN ROM_CONTENT;
  END FUNCTION;

  SIGNAL ROM : ROM_TYPE := INITROMFROMFILE;


begin

  fft_i : fft
  port map (
    clk      => clk,
    rst      => rst,
    start    => start,
    Xr0_in   => Xr0_in,
    Xi0_in   => Xi0_in,
    Xr1_in   => Xr1_in,
    Xi1_in   => Xi1_in,
    Xr2_in   => Xr2_in,
    Xi2_in   => Xi2_in,
    Xr3_in   => Xr3_in,
    Xi3_in   => Xi3_in,
    Xr4_in   => Xr4_in,
    Xi4_in   => Xi4_in,
    Xr5_in   => Xr5_in,
    Xi5_in   => Xi5_in,
    Xr6_in   => Xr6_in,
    Xi6_in   => Xi6_in,
    Xr7_in   => Xr7_in,
    Xi7_in   => Xi7_in,
    Xr8_in   => Xr8_in,
    Xi8_in   => Xi8_in,
    Xr9_in   => Xr9_in,
    Xi9_in   => Xi9_in,
    Xr10_in  => Xr10_in,
    Xi10_in  => Xi10_in,
    Xr11_in  => Xr11_in,
    Xi11_in  => Xi11_in,
    Xr12_in  => Xr12_in,
    Xi12_in  => Xi12_in,
    Xr13_in  => Xr13_in,
    Xi13_in  => Xi13_in,
    Xr14_in  => Xr14_in,
    Xi14_in  => Xi14_in,
    Xr15_in  => Xr15_in,
    Xi15_in  => Xi15_in,
    Wr0      => Wr0,
    Wi0      => Wi0,
    Wr1      => Wr1,
    Wi1      => Wi1,
    Wr2      => Wr2,
    Wi2      => Wi2,
    Wr3      => Wr3,
    Wi3      => Wi3,
    Wr4      => Wr4,
    Wi4      => Wi4,
    Wr5      => Wr5,
    Wi5      => Wi5,
    Wr6      => Wr6,
    Wi6      => Wi6,
    Wr7      => Wr7,
    Wi7      => Wi7,
    Xr0_out  => Xr0_out,
    Xi0_out  => Xi0_out,
    Xr1_out  => Xr1_out,
    Xi1_out  => Xi1_out,
    Xr2_out  => Xr2_out,
    Xi2_out  => Xi2_out,
    Xr3_out  => Xr3_out,
    Xi3_out  => Xi3_out,
    Xr4_out  => Xr4_out,
    Xi4_out  => Xi4_out,
    Xr5_out  => Xr5_out,
    Xi5_out  => Xi5_out,
    Xr6_out  => Xr6_out,
    Xi6_out  => Xi6_out,
    Xr7_out  => Xr7_out,
    Xi7_out  => Xi7_out,
    Xr8_out  => Xr8_out,
    Xi8_out  => Xi8_out,
    Xr9_out  => Xr9_out,
    Xi9_out  => Xi9_out,
    Xr10_out => Xr10_out,
    Xi10_out => Xi10_out,
    Xr11_out => Xr11_out,
    Xi11_out => Xi11_out,
    Xr12_out => Xr12_out,
    Xi12_out => Xi12_out,
    Xr13_out => Xr13_out,
    Xi13_out => Xi13_out,
    Xr14_out => Xr14_out,
    Xi14_out => Xi14_out,
    Xr15_out => Xr15_out,
    Xi15_out => Xi15_out,
    done     => done
  );

  Xr0_in   <= ROM(0);
  Xi0_in   <= ROM(1);
  Xr1_in   <= ROM(2);
  Xi1_in   <= ROM(3);
  Xr2_in   <= ROM(4);
  Xi2_in   <= ROM(5);
  Xr3_in   <= ROM(6);
  Xi3_in   <= ROM(7);
  Xr4_in   <= ROM(8);
  Xi4_in   <= ROM(9);
  Xr5_in   <= ROM(10);
  Xi5_in   <= ROM(11);
  Xr6_in   <= ROM(12);
  Xi6_in   <= ROM(13);
  Xr7_in   <= ROM(14);
  Xi7_in   <= ROM(15);
  Xr8_in   <= ROM(16);
  Xi8_in   <= ROM(17);
  Xr9_in   <= ROM(18);
  Xi9_in   <= ROM(19);
  Xr10_in  <= ROM(20);
  Xi10_in  <= ROM(21);
  Xr11_in  <= ROM(22);
  Xi11_in  <= ROM(23);
  Xr12_in  <= ROM(24);
  Xi12_in  <= ROM(25);
  Xr13_in  <= ROM(26);
  Xi13_in  <= ROM(27);
  Xr14_in  <= ROM(28);
  Xi14_in  <= ROM(29);
  Xr15_in  <= ROM(30);
  Xi15_in  <= ROM(31);

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
  wait;
end process;





	out_p : process(DONE)

			file posFile : text is out "out_SS_sin_cos_new_little.txt";
			variable l : line;
			variable n : integer;

		begin
				if(DONE = '1') then
				n := to_integer(Xr0_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi0_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr1_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi1_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr2_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi2_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr3_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi3_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr4_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi4_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr5_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi5_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr6_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi6_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr7_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi7_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr8_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi8_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr9_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi9_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr10_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi10_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr11_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi11_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr12_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi12_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr13_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi13_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr14_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi14_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xr15_out);
				write(l,n);
				writeline(posFile, l);
				n := to_integer(Xi15_out);
				write(l,n);
				writeline(posFile, l);

				end if;

		end process;


end architecture;
