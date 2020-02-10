library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk     : in std_logic;            --clock
    rstN    : in std_logic;            --reset active-low
    signa   : in signed(27 downto 0);  --input signal
    DAV     : in std_logic;
    restart : in std_logic;            --start
    peak    : out std_logic;           --notifies that the treshold is overcome
    -- debug signals
    energy : out signed(55 downto 0); --outputs computed energy
    calc   : out std_logic            --notifies that an energy has been computed
  );
end entity;
--TODO aggiungere data_valid
architecture arch of PeakNoticer is

  component REG IS
  	GENERIC(N : INTEGER := 8);
  	PORT(REG_IN : IN signed(N-1 DOWNTO 0);
  		 REG_OUT : OUT signed(N-1 DOWNTO 0);
  		 CLK, RST, LOAD : IN STD_LOGIC
  	);
  END component;
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
    generic (N : integer := 8);
    port (
      in1 : in  signed(N - 1 downto 0);
      sq  : out signed(N * 2 - 1 downto 0)
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
    generic (
      N : integer := 8
    );
    port (
      to_cmp, to_be_cmp : in  signed(N - 1 downto 0);
      maj               : out std_logic
    );
  end component comparator;

--State
  type state is(RST_S, IDLE, MEASURE, FOUND_TH);
  signal st                          : state;                         --state variable

--Control signals
  signal en_cnt, rst_cnt             : std_logic;                     --counter
  signal reset_buffer_reg            : std_logic;                     --buffer_reg
  signal en_buffer_reg               : std_logic;                     --buffer_reg
  signal reset_accumulator           : std_logic;                     --accumulator
  signal en_accumulator              : std_logic;                     --accumulator
  signal add_sub_c                   : std_logic;                     --adder

--State signals
  signal cnt_end                     : std_logic;                     --counter
  signal cmp_out                     : std_logic;                     --comparator

--Data signals
  signal buffer_out                  : signed(27 downto 0);           --buffer_reg
  signal next_energy, present_energy : signed(55 downto 0);           --accumulator
  signal square_out                  : signed(55 downto 0);           --square
  --signal square_out_ext              : signed(37 downto 0);           --square out extended
  signal treshold                    : signed(55 downto 0);           --comparator

--Dumb signals
  signal cnt_out_D                   : unsigned(9 downto 0);          --counter

begin

--Control unit

  state_transition : process(clk)
  begin
--    if (clk'event and clk = '1') then
    --  if (rstN = '0') then
      --  st <= RST_S;
    --  else
      --  case (st) is
        --  when RST_S =>
          --  if (start = '1') then
            --  st <= MEASURE;
            --else
            --  st <= RST_S;
            --end if;
          --when MEASURE =>
            --if (cnt_end = '1') then
            --  st <= RST_S;
            --elsif (cnt_end = '0' and cmp_out = '0') then
              --st <= MEASURE;
            --elsif (cmp_out = '1') then
              --st <= FOUND_TH;
            --else
              --st <= RST_S;
            --end if;
          --when FOUND_TH =>
            --if (start = '1') then
              --st <= RST_S;
            --else
              --st <= FOUND_TH;
            --end if;
          --when others =>
            --st <= RST_S;
        --end case;
      --end if;
    --end if;
    if (clk'event and clk = '1') then
      if (rstN='0') then
        st <= RST_S;
      else
        case (st) is
          when RST_S =>
            st <= IDLE;
          when IDLE =>
            if (DAV='1') then
              st <= MEASURE;
            elsif (DAV = '0' and cnt_end = '0') then
              st <= IDLE;
            elsif (cnt_end = '1') then
              st <= RST_S;
            elsif (cmp_out='1') then
              st <= FOUND_TH;
            end if;
          when MEASURE =>
            st <= IDLE;
          when FOUND_TH =>
            if (restart = '0') then
              st <= FOUND_TH;
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
    add_sub_c         <= '1';

    case (st) is
      when RST_S =>
        rst_cnt           <= '0';
        reset_buffer_reg  <= '0';
        reset_accumulator <= '0';
      when MEASURE =>
        en_cnt            <= '1';
        en_buffer_reg     <= '1';
        en_accumulator    <= '1';
      when IDLE =>

      when FOUND_TH =>
        peak              <= '1';
      when others =>
        rst_cnt           <= '0';
        reset_buffer_reg  <= '0';
        reset_accumulator <= '0';
    end case;
  end process;

--Datapath

  counter     : n_counter generic map(10, 1000)
                          port map(clk, en_cnt, rst_cnt, cnt_end, cnt_out_D);

  buffer_reg  : reg      generic map(28)
                         port map(signa, buffer_out, clk, reset_buffer_reg, en_buffer_reg);

  accumulator : reg      generic map(56)
                         port map(next_energy, present_energy, clk, reset_accumulator, en_accumulator);

  squa        : square generic map(28)
                       port map(buffer_out, square_out);

  --square_out_ext(27 downto 0) <= square_out;
  --square_out_ext(37 downto 28) <= (others => square_out(27));

  add         : ADD_SUB generic map(56)
                        port map(square_out, present_energy, next_energy, add_sub_c);

  treshold(37) <= '0';
  treshold(36 downto 0) <= (others => '1');

  cmp         : comparator generic map(56)
                           port map (present_energy, treshold, cmp_out);

--Debug
  energy <= next_energy;

  calc <= cnt_end;

end architecture;
