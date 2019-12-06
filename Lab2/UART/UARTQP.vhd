library ieee;
use ieee.std_logic_1164.all;

entity UARTQP2 is

	port(
		SW : in std_logic_vector(9 downto 0);
		GPIO_0 : out std_logic_vector(35 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		HPS_CLOCK1_25 : in std_logic
	);

end entity;

architecture beh of UARTQP2 is

  component UART is
  
    port(
      data_in  : in std_logic_vector (7 downto 0);
      tx_pin       : out std_logic;
      tx_ready : out std_logic;
      wr       : in std_logic;
    
      data_out : out std_logic_vector (7 downto 0);
      rx_pin       : in std_logic;
      rd       : in std_logic;
      dav      : out std_logic;
    
      clock    : in std_logic;
      resetN   : in std_logic
    );
  
  end component;

  signal tx                    : std_logic;
  signal tx_ready  : std_logic;
    
  
    
  signal clock                 : std_logic;
  signal resetN1, resetN2      : std_logic;

begin

  UART1 : UART port map (sw(7 downto 0), tx, GPIO_0(8), not(KEY(0)), LEDR(7 downto 0), tx, not(KEY(1)), GPIO_0(16), HPS_CLOCK1_25, KEY(2));
  GPIO_0(0) <= tx;

  
        
end architecture;
