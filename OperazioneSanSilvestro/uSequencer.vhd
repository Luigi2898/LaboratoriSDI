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
    uIR     : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioural of uSequencer is

  component uROM is
    port (
      address : in std_logic_vector(3 downto 0); --cod. connessioni _ moltipicazione _ ROM rounding _ reset
      data    : out std_logic_vector(6 downto 0)
    );
  end component;

  signal uAR   : integer;
  signal uIR1  : std_logic_vector(6 downto 0);
  signal uAR_slv : std_logic_vector (3 downto 0);

begin

  uAR_slv <= std_logic_vector(to_unsigned(uAR, 4));
  uuROM : uROM port map(uAR_slv, uIR1);

  seq : process(clk)
    begin
      str_nxt <= '0';
      if clk'event and clk = '1' then --IL uAR SI AGGIORNA SUL FRONTE DI SALITA
        if rst = '0' then
          uAR  <= 0;
          uIR <= (others => '0');
          done <= '0';
        elsif start = '1' then --DA RIVEDERE
          uAR  <= uAR + 1;
          done <= '0';
        end if;
        if not(uIR1 = "0000000") then
          uAR  <= uAR + 1;
        end if;
      end if;
      if uAR = 12 then
        uAR <= 0;
        done <= '1';
      end if;
      if uAR = 10 then
        str_nxt <= '1';
      end if;
      if clk'event and clk = '0' then --IL uIR SI AGGIORNA SUL FRONTE DI DISCESA
        uIR <= uIR1;
      end if;
  end process;
end architecture;
