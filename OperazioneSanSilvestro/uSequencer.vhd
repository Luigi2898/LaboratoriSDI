library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity uSequencer is
  port (
    clk     : in std_logic;
    rst     : in std_logic;
    start   : in std_logic;
    done    : out std_logic;
    str_nxt : out std_logic;
    uIR     : buffer std_logic_vector(24 downto 0)
  );
end entity;

architecture behavioural of uSequencer is

  component POLY_ROM
  generic (
    INITFILE   : STRING := "POLYPHASE.TXT";
    ADDR_N     : INTEGER := 4;
    DATA_WIDTH : INTEGER := 28
  );
  port (
    ADDRESS : IN  UNSIGNED(ADDR_N-1 DOWNTO 0);
    DATAOUT : OUT SIGNED(DATA_WIDTH-1 DOWNTO 0)
  );
  end component POLY_ROM;


  signal uAR   : integer;
  signal uIR1  : signed(24 downto 0) := (others => '0');
  signal uAR_u : unsigned(3 downto 0);

begin

  uAR_u <= to_unsigned(uAR, 4);
  uuROM : POLY_ROM generic map("ROM_controllo.txt", 4, 25)
                   port map(uAR_u, uIR1);

  seq : process(clk)
    begin
      --str_nxt <= '0';
    --  done <= '0';
      if clk'event and clk = '1' then --IL uAR SI AGGIORNA SUL FRONTE DI SALITA
        if rst = '0' then
          uAR <= 0;
        else
          if start = '1' and uIR(0) = '1' then
            uAR <= 1;
          elsif start = '0' and not(uAR = 0) then
            uAR <= uAR + 1;
          elsif start = '1' then
            uAR <= uAR + 1;
          end if;
          if uAR = 12 then
            uAR <= 0;
          --  done <= '1';
          end if;
          if uAR = 10 then
          --  str_nxt <= '1';
        end if;
        end if;
      end if;
      if clk'event and clk = '0' then
        uIR <= std_logic_vector(uIR1);
      end if;
  end process;
end architecture;
