library ieee;
  use ieee.std_logic_1164.all;

entity  is
  port (
  clk : in std_logic;
  rst : in std_logic;
  rx : in std_logic;
  rd : in std_logic;
  data : out std_logic_vextor(7 downto 0);
  dav : out std_logic;
  );
end entity;

architecture behavioural of RX is
  component CU_RX IS
  	PORT(CLOCK          : IN STD_LOGIC;
           RST            : IN STD_LOGIC;
  		 S_BIT          : IN STD_LOGIC;
  		 DATA_VALID     : OUT STD_LOGIC;
  		 DP_RST         : OUT STD_LOGIC;
  		 RD             : IN STD_LOGIC;
  		 BAUD_EN        : OUT STD_LOGIC;
  		 BAUD_END       : IN  STD_LOGIC;
  		 FRAME_EN       : OUT STD_LOGIC;
  		 FRAME_END      : IN STD_LOGIC;
  	     ENABLE_INPUT   : OUT STD_LOGIC;
  		 ENABLE_OUTPUT  : OUT STD_LOGIC
  	);
  END component;

  component DP is
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
    frame_end : out std_logic
    );
  end component;

  signal eninput : std_logic;
  signal startbit : std_logic;
  signal en_out_reg : std_logic;
  signal  baud_en : std_logic;
  signal baud_end : std_logic;
  signal  frame_en : std_logic;
  signal frame_end : std_logic
  signal dp_reset : std_logic;

begin

  dadatapath : dp port map(rx, dp_reset, clk, eninput, startbit, en_out_reg, data, baud_en, baud_end, frame_en, frame_end);
  control_unit : cu_RX port map(clk, rst, startbit, dav, dp_reset, rd, baud_en, baud_end, frame_en, frame_end, eninput, en_out_reg);
  
end architecture;
