library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_unsigned.all;

entity Multiplier is
  generic(Nbit : integer := 8);
  port (
    In1   : in signed(Nbit - 1 downto 0);
    In2   : in signed(Nbit - 1 downto 0);
    Mult2 : in std_logic; -- Se '1' multiplica In1 per 2, altrimenti moltiplica i due ingressi
    clk   : in std_logic;
    rst   : in std_logic;
    Res   : out signed(2 * Nbit - 2 downto 0)
  );
end entity;

architecture behavioural of Multiplier is

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

  component GENERICS_MUX
  generic (
    INPUTS : INTEGER := 15;
    SIZE   : INTEGER := 1
  );
  port (
    INS     : IN  SIGNED((INPUTS*SIZE)-1 DOWNTO 0);
    SEL     : IN  INTEGER;
    OUT_MUX : OUT SIGNED(SIZE-1 DOWNTO 0)
  );
  end component GENERICS_MUX;


  signal mult, mult_f, mult_s, shift : signed(2 * Nbit - 1 downto 0);
  signal sel                         : integer := 0;
  signal multslv                     : std_logic_vector(0 downto 0);
  signal mux_in                      : signed(4 * Nbit - 3 downto 0);

begin

  mult                            <= In1 * In2;

  shift(2 * Nbit - 1)             <= In1(Nbit - 1);
  shift(2 * Nbit - 1 downto Nbit) <= In1(Nbit - 1 downto 0);
  shift(Nbit - 1 downto 0)        <= (others => '0');

  multslv(0)                      <= Mult2;
  sel                             <= TO_INTEGER(unsigned(multslv));

  reg1 : Registro generic map(2 * Nbit)
                  port map(mult, mult_f, '1', clk, rst);

  reg2 : Registro generic map(2 * Nbit)
                  port map(mult_f, mult_s, '1', clk, rst);

  mux_in                          <= shift(Nbit*2 - 2 downto 0) & mult_s(Nbit*2 - 2 downto 0);

  mux  : GENERICS_MUX generic map(2, 2 * Nbit - 1)
                      port map(mux_in, sel, Res);

end architecture;
