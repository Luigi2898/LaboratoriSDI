library ieee;
use ieee.std_logic_1164.all;

entity UART is

  port(
    data_in  : in std_logic_vector (7 downto 0);
    tx_pin   : out std_logic;
    tx_ready : out std_logic;
    wr       : in std_logic;

    data_out : out std_logic_vector (7 downto 0);
    rx_pin   : in std_logic;
    rd       : in std_logic;
    dav      : out std_logic;

    clock    : in std_logic;
    resetN   : in std_logic
    );

end entity;

architecture Behavioural of UART is

  component RX is
    port (
      clk : in std_logic;
      rst : in std_logic;
      rx : in std_logic;
      rd : in std_logic;
      data : out std_logic_vector(7 downto 0);
      dav : out std_logic
    );
  end component;

  component TX IS
	 PORT(
     CLOCK       : IN STD_LOGIC;
		 RST         : IN STD_LOGIC;
		 DATA_IN     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 TX          : OUT STD_LOGIC;
		 DATA_VALID  : IN STD_LOGIC;
		 TXREADY     : OUT STD_LOGIC
	 );
  END component;

  begin

    Receiver    : RX port map(clock, resetN, rx_pin, rd, data_out, dav);
    Transmitter : TX port map(clock, resetN, data_in, tx_pin, wr, tx_ready);


end architecture;
