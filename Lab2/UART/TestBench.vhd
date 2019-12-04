library ieee;
use ieee.std_logic_1164.all;

entity TestBench is
end entity;

architecture beh of TestBench is

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

  signal data_in1, data_in2    : std_logic_vector (7 downto 0);
  signal tx                    : std_logic;
  signal tx_ready1, tx_ready2  : std_logic;
  signal wr1, wr2              : std_logic;
    
  signal data_out1, data_out2  : std_logic_vector (7 downto 0);
  signal rx                    : std_logic;
  signal rd1, rd2              : std_logic;
  signal dav1, dav2            : std_logic;
    
  signal clock                 : std_logic;
  signal resetN1, resetN2      : std_logic;

begin

  UART1 : UART port map (data_in1, tx, tx_ready1, wr1, data_out1, rx, rd1, dav1, clock, resetN1);
  UART2 : UART port map (data_in2, rx, tx_ready2, wr2, data_out2, tx, rd2, dav2, clock, resetN2);
    
  clk_proc : process
    begin
      wait for 20 ns;
      clock <= '1';
      wait for 20 ns;
      clock <= '0';
  end process;
  
  rst_proc1 : process
    begin
      resetN1 <= '1';
      wait for 5 ns;
      resetN1 <= '0';
      wait for 25 ns;
      resetN1 <= '1';
      wait;
  end process;

  rst_proc2 : process
    begin
      resetN2 <= '1';
      wait for 25 ns;
      resetN2 <= '0';
      wait for 45 ns;
      resetN2 <= '1';
      wait;
  end process;
        
end architecture;
