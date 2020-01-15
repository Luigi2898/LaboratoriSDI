library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk    : in std_logic;                      --clock
    rstN   : in std_logic;                      --reset active-low
    signa  : in std_logic_vector(15 downto 0);  --input signal
    start  : in std_logic;                      --start
    peak   : out std_logic;                     --notifies that the treshold is overcome
    -- debug signals
    energy : out std_logic_vector(31 downto 0); --outputs computed energy
    calc   : out std_logic                      --notifies that an energy has been computed
  );
end entity;

architecture arch of PeakNoticer is

  component Registro is
    generic(
      Nbit : integer := 8
    );
    port (
     DataIn  : in std_logic_vector(Nbit-1 downto 0);
     DataOut : out std_logic_vector(Nbit-1 downto 0);
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
      in1 : in std_logic_vector(15 downto 0);
      sq  : out std_logic_vector(31 downto 0)
    );
  end component;

  component adder is
    port (
      in1, in2 : in std_logic_vector(31 downto 0);
      res      : out std_logic_vector(31 downto 0)
    );
  end component;

  component comparator
    port (
      to_cmp, to_be_cmp : in  signed(31 downto 0);
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

--State signals
  signal cnt_end                     : std_logic;                     --counter
  signal cmp_out                     : std_logic;                     --comparator

--Data signals
  signal buffer_out                  : std_logic_vector(15 downto 0); --buffer_reg
  signal next_energy, present_energy : std_logic_vector(31 downto 0); --accumulator
  signal square_out                  : std_logic_vector(31 downto 0); --square
  signal treshold                    : std_logic_vector(31 downto 0); --comparator

--Dumb signals
  signal cnt_out_D                   : unsigned(17 downto 0);          --counter

  --FIXME Sistemare i tipi!!

  --TODO Controllare parallelismo!!

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

  counter     : n_counter generic map(18, 177307)
                          port map(clk, en_cnt, rst_cnt, cnt_end, cnt_out_D);

  buffer_reg  : registro generic map(16)
                         port map(signa, buffer_out, clk, reset_buffer_reg, en_buffer_reg);

  accumulator : registro generic map(32)
                         port map(next_energy, present_energy, clk, reset_accumulator, en_accumulator);

  squa        : square port map(buffer_out, square_out);

  add         : adder port map(square_out, present_energy, next_energy);

  treshold <= "00010110111010101110110100010110";

  cmp         : comparator port map (signed(present_energy), signed(treshold), cmp_out);

--Debug
  energy <= next_energy;

  calc <= cnt_end;

end architecture;
