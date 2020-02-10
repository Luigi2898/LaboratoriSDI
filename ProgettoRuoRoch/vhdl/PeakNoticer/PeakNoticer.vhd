library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk    : in std_logic;            --clock
    rstN   : in std_logic;            --reset active-low
    signa  : in signed(13 downto 0);  --input signal
    start  : in std_logic;            --start
    peak   : out std_logic;           --notifies that the treshold is overcome
    -- debug signals
    energy : out signed(37 downto 0); --outputs computed energy
    calc   : out std_logic            --notifies that an energy has been computed
  );
end entity;
--TODO parallelismo a 28 bit
--TODO aggiungere data_valid
architecture arch of PeakNoticer is
  --FIXME Cambiare con reg
  component Registro is
    generic(
      Nbit : integer := 8
    );
    port (
     DataIn  : in signed(Nbit-1 downto 0);
     DataOut : out signed(Nbit-1 downto 0);
     clock   : in std_logic;
     reset   : in std_logic;
     enable  : in std_logic
    );
  end component;

  component N_COUNTER IS
    GENERIC(
      N      : INTEGER:= 12;
      MODULE : INTEGER:= 2604
    );
    PORT(
      CLK     : IN STD_LOGIC;
      EN      : IN STD_LOGIC;
      RST     : IN STD_LOGIC;
      CNT_END : OUT STD_LOGIC;
      CNT_OUT : BUFFER UNSIGNED(N-1 DOWNTO 0)
    );
  END component;

  component square is
    port (
      in1 : in signed(13 downto 0);
      sq  : out signed(27 downto 0)
    );
  end component;

  component ADD_SUB
  generic (
    N_AS : INTEGER := 20
  );
  port (
    IN_AS_1, IN_AS_2 : IN  SIGNED(N_AS-1 DOWNTO 0);
    AS_OUT           : OUT SIGNED(N_AS-1 DOWNTO 0);
    PDM              : IN  std_logic
  );
  end component ADD_SUB;

  component comparator
    port (
      to_cmp, to_be_cmp : in  signed(37 downto 0);
      maj               : out std_logic
    );
  end component comparator;

--State
  type state is(RST_S, MEASURE, FOUND_TH);
  signal st                          : state;                         --state variable

--Control signals
  signal en_cnt, rst_cnt             : std_logic;                     --counter
  signal reset_buffer_reg            : std_logic;                     --buffer_reg
  signal en_buffer_reg               : std_logic;                     --buffer_reg
  signal reset_accumulator           : std_logic;                     --accumulator
  signal en_accumulator              : std_logic;                     --accumulator
  signal add_sub                     : std_logic;                     --adder

--State signals
  signal cnt_end                     : std_logic;                     --counter
  signal cmp_out                     : std_logic;                     --comparator

--Data signals
  signal buffer_out                  : signed(13 downto 0);           --buffer_reg
  signal next_energy, present_energy : signed(37 downto 0);           --accumulator
  signal square_out                  : signed(27 downto 0);           --square
  signal square_out_ext              : signed(37 downto 0);           --square out extended
  signal treshold                    : signed(37 downto 0);           --comparator

--Dumb signals
  signal cnt_out_D                   : unsigned(9 downto 0);          --counter

begin

--Control unit

  state_transition : process(clk)
  begin
    if (clk'event and clk = '1') then
      if (rstN = '0') then
        st <= RST_S;
      else
        case (st) is
          when RST_S =>
            if (start = '1') then
              st <= MEASURE;
            else
              st <= RST_S;
            end if;
          when MEASURE =>
            if (cnt_end = '1') then
              st <= RST_S;
            elsif (cnt_end = '0' and cmp_out = '0') then
              st <= MEASURE;
            elsif (cmp_out = '1') then
              st <= FOUND_TH;
            else
              st <= RST_S;
            end if;
          when FOUND_TH =>
            if (start = '1') then
              st <= RST_S;
            else
              st <= FOUND_TH;
            end if;
          when others =>
            st <= RST_S;
        end case;
      end if;
    end if;
  end process;

  output_calculation : process(st)
  begin

    en_cnt            <= '0';
    rst_cnt           <= '1';
    reset_buffer_reg  <= '1';
    en_buffer_reg     <= '0';
    reset_accumulator <= '1';
    en_accumulator    <= '0';
    peak              <= '0';

    case (st) is
      when RST_S =>
        rst_cnt         <= '0';
        reset_buffer_reg  <= '0';
        reset_accumulator <= '0';
      when MEASURE =>
        en_cnt         <= '1';
        en_buffer_reg  <= '1';
        en_accumulator <= '1';
      when FOUND_TH =>
        peak <= '1';
      when others =>
        rst_cnt         <= '0';
        reset_buffer_reg  <= '0';
        reset_accumulator <= '0';
    end case;
  end process;

--Datapath

  counter     : n_counter generic map(10, 1000)
                          port map(clk, en_cnt, rst_cnt, cnt_end, cnt_out_D);

  buffer_reg  : registro generic map(14)
                         port map(signa, buffer_out, clk, reset_buffer_reg, en_buffer_reg);

  accumulator : registro generic map(38)
                         port map(next_energy, present_energy, clk, reset_accumulator, en_accumulator);

  squa        : square port map(buffer_out, square_out);

  square_out_ext(27 downto 0) <= square_out;
  square_out_ext(37 downto 28) <= (others => square_out(27));

  add         : ADD_SUB generic map()
                        port map(square_out_ext, present_energy, next_energy, add_sub);

  treshold(37) <= '0';
  treshold(36 downto 0) <= (others => '1');

  cmp         : comparator port map (present_energy, treshold, cmp_out);

--Debug
  energy <= next_energy;

  calc <= cnt_end;

end architecture;
