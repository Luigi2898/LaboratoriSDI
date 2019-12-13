library ieee;
  use ieee.std_logic_1164.all;
  use ieee.NUMERIC_STD.all;

entity DP is
  port (
  RX : in std_logic;
  rst :  in std_logic;
  clock : in std_logic;
  eninput : in std_logic;
  startbit : out std_logic;
  en_out_reg : in std_logic;
  dataout : out std_logic_vector(7 downto 0);
  baud_en : in std_logic;
  baud_end : out std_logic;
  frame_en : in std_logic;
  frame_end : out std_logic;
  frame_rst : in std_logic
  );
end entity;

architecture behavioural of DP is

  component N_COUNTER IS
  		GENERIC(N : INTEGER:= 12; MODULE : INTEGER:= 2604);
  		PORT(CLK : IN STD_LOGIC;
  			 EN  : IN STD_LOGIC;
  			 RST : IN STD_LOGIC;
  			 CNT_END : OUT STD_LOGIC;
  			 CNT_OUT : BUFFER UNSIGNED(N-1 DOWNTO 0)
  		);
  END component;

  component SERIAL2PARALLEL IS
  GENERIC(N:integer);
  	PORT(CLK        : IN STD_LOGIC;
  		 RST        : IN STD_LOGIC;
  		 EN         : IN STD_LOGIC;
  		 SERIAL_D   : IN STD_LOGIC;
  		 PARALLEL_D : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0)
  	);
  END component;

  component StartBitFinder is
    port (
      frame : in std_logic_vector(7 downto 0);
      startbit : out std_logic
    );
  end component;

  component voter is
    port (

    in1 : in std_logic;
    in2 : in std_logic;
    in3 : in std_logic;
    winner : out std_logic

    );
  end component;

  signal baud_count_out : UNSIGNED(11 downto 0);
  signal frame_count_out : UNSIGNED(2 downto 0);
  signal to_logic : std_logic_vector(7 downto 0);
  signal vote : std_logic;
  signal in1, in2, in3 : std_logic;

begin
  baud_counter : n_counter GENERIC MAP(12, 2604) port map(clock, baud_en, rst, baud_end, baud_count_out);
  frame_counter : n_counter GENERIC MAP(3 , 7) port map(clock, frame_en, frame_rst, frame_end, frame_count_out);
  input_reg : SERIAL2PARALLEL GENERIC MAP(8) port map(clock, rst, eninput, Rx, to_logic);
  output_reg : SERIAL2PARALLEL GENERIC MAP(8) PORT MAP(clock, rst, en_out_reg , vote , dataout);
  votatore : voter Port map(to_logic(3), to_logic(4), to_logic(5), vote);
  s_bit_f : StartBitFinder port map(to_logic, startbit);


end architecture;
