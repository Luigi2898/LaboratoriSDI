library ieee;
use ieee.std_logic_1164.all;

entity UARTQP is

	port(
		SW : in std_logic_vector(9 downto 0);
		GPIO_0 : out std_logic_vector(35 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		CLOCK_50 : in std_logic
	);

end entity;

architecture beh of UARTQP is

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
  
  
component pll is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic;        -- outclk0.clk
		outclk_1 : out std_logic;        -- outclk1.clk
		locked   : out std_logic         --  locked.export
	);
end component pll;

component RisingEdge_DFlipFlop is 
   port(
      Q : out std_logic;    
      Clk :in std_logic;   
      D :in  std_logic    
   );
end component RisingEdge_DFlipFlop;

  signal tx                    : std_logic;
  signal tx_ready  : std_logic;
    
  signal wr : std_logic ;
  
  signal d : std_logic;
  signal q : std_logic;
  
  signal clock, outclk_0, outclk_1, locked  : std_logic;
  signal resetN1, resetN2      : std_logic;

begin

  UART1 : UART port map (sw(7 downto 0), tx, GPIO_0(8), wr, LEDR(7 downto 0), tx, not(KEY(1)), GPIO_0(16), outclk_0, KEY(2));
  GPIO_0(2) <= outclk_0;
  GPIO_0(34) <= wr;
  GPIO_0(22) <= tx;                                                        
  
  pllll : pll port map(CLOCK_50, not(KEY(2)), outclk_0, outclk_1, locked);
  
  ff : RisingEdge_DFlipFlop port map(q, outclk_0, d);
  
  keypropc1 : process(key(0), outclk_0)
  
  begin
	if(key(0)'event and key(0) = '0') then
		if (outclk_0 = '1') then
			wr <= '1';
			d <= '1';
		end if;
	end if;
	if(outclk_0 = '1' and q = '1') then
		wr <= '0';
		d <= '0';
	end if;
  end process;
  
  --keypropc2 : process(outclk_0)
  
  --begin
	--if(outclk_0'event and outclk_0 = '1')  then
		--if (q = '1') then
		--	wr <= not(wr);
		--	d <= not(d);
		--end if;
	--end if;
  --end process;
        
end architecture;
