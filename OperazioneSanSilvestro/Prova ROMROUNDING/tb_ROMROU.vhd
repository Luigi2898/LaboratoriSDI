library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;

entity tb_ROMROU is
end entity;

architecture beh of tb_ROMROU is
  component POLY_ROM
  generic (
    INITFILE   : STRING := "POLYPHASE.TXT";
    ADDR_N     : INTEGER := 4;
    DATA_WIDTH : INTEGER := 28;
    num_add    : integer := 12
  );
  port (
    ADDRESS : IN  UNSIGNED(ADDR_N-1 DOWNTO 0);
    DATAOUT : OUT SIGNED(DATA_WIDTH-1 DOWNTO 0)
  );
  end component POLY_ROM;

  signal outlong : signed(46 downto 0);
  signal out_rom : signed(1 downto 0);
  signal rounded : signed(23 downto 0);

begin
  rom_rounding : POLY_ROM generic map("ROM_ROUNDING.txt", 3, 2, 7)
                          port map(unsigned(outlong(24 downto 22)), out_rom);

  rounded <= outlong(46 downto 25) & out_rom;

  in_p : process

      file inFile : text is in "input.txt";
      variable l : line;
      variable n : std_logic_vector(46 downto 0);

    begin
      while (endfile(inFile) = false) loop
        readline(inFile, l);
        read(l,n);
        outlong <= signed(n);
        wait for 10 ns;
      end loop;
      wait;
    end process;

    out_p : process

  		file posFile : text is out "output.txt";
  		variable l : line;
  		variable n : integer;

  	begin
      n := to_integer(rounded);
  		write(l,n);
  		writeline(posFile, l);
  		wait for 10 ns;
  	end process;

end architecture;
