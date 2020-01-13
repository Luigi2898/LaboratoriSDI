library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity PeakNoticer is
  port (
    clk    : in std_logic; --clock
    rstN   : in std_logic; --reset active-low
    signa  : in std_logic_vector(11 downto 0); --input signal
    peak   : out std_logic; --notifies that the treshold is overcome
    -- debug signals
    energy : out std_logic_vector(24 downto 0); --outputs computed energy
    calc   : out std_logic --notifies that an energy has been computed
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
     reset   : in std_logic
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
      in1 : in std_logic_vector(11 downto 0);
      sq  : out std_logic_vector(23 downto 0)
    );
  end component;

  component adder is
    port (
      in1, in2 : in std_logic_vector(24 downto 0);
      res      : out std_logic_vector(24 downto 0)
    );
  end component;

--Control signals
  signal en_cnt, rst_cnt             : std_logic; --counter
  signal rst_buffer_reg              : std_logic; --buffer_reg
  signal reset_accumulator           : std_logic; --accumulator

--State signals
  signal cnt_end                     : std_logic; --counter

--Data signals
  signal buffer_out                  : std_logic_vector(11 downto 0); --buffer_reg
  signal next_energy, present_energy : std_logic_vector(24 downto 0); --accumulator
  signal square_out                  : std_logic_vector(23 downto 0); --square

--Dumb signals
  signal cnt_out_D                   : unsigned(8 downto 0); --counter

  --TODO : Sistemare i tipi!!

begin

--Control unit

--Datapath

  counter     : n_counter generic map(9, 500)
                          port map(clk, en_cnt, rst_cnt, cnt_end, cnt_out_D);
  buffer_reg  : registro generic map(12)
                         port map(signa, buffer_out, clk, rst_buffer_reg);
  accumulator : registro generic map(25)
                         port map(next_energy, present_energy, clk, reset_accumulator);

  squa        : square port map(buffer_out, square_out);

  add         : adder port map(square_out(23) & square_out, present_energy, next_energy);

--Debug
  energy <= next_energy;
  calc <= cnt_end;

end architecture;
