library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity compute_delay is
  port (clk : in std_logic;
        rst   : in std_logic;
        DELAY_OUT : BUFFER SIGNED(9 DOWNTO 0);
        MSB   : OUT STD_LOGIC;
        PEAK1 : IN STD_LOGIC;
        PEAK2 : IN STD_LOGIC;
        RESTART : OUT STD_LOGIC;
        SIMULTANEOUS : OUT STD_LOGIC;
        DONE : OUT STD_LOGIC
  );
end entity;

architecture arch of compute_delay is
  COMPONENT DP_DELAY IS
  	PORT(CLK           : IN STD_LOGIC;
  		 RST_DP        : IN STD_LOGIC;
  		 EN_CNT_DELAY  : IN STD_LOGIC;
  		 RST_CNT_DELAY : IN STD_LOGIC;
  		 EN_FIRST      : IN STD_LOGIC;
  	   EN_SECOND     : IN STD_LOGIC;
  	   DELAY_END     : OUT STD_LOGIC;
  		 DELAY_OUT     : BUFFER SIGNED(9 DOWNTO 0); --AGGIUNGERE BIT
       MSB           : OUT STD_LOGIC;
  		 EN_DELAY_OUT  : IN STD_LOGIC;
  		 SUB           : IN STD_LOGIC
  	);
  END COMPONENT;

  COMPONENT CU_DELAY IS
  	PORT(CLK         : IN  STD_LOGIC;
  		 RST           : IN  STD_LOGIC;
  		 RST_DP        : OUT STD_LOGIC;
  		 PEAK1         : IN  STD_LOGIC;
  		 PEAK2         : IN  STD_LOGIC;
  		 RESTART       : OUT STD_LOGIC; --FA RIPARTIRE I COMPARATORI
  		 EN_CNT_DELAY  : OUT STD_LOGIC;
  		 RST_CNT_DELAY : OUT STD_LOGIC;
  		 EN_FIRST      : OUT STD_LOGIC;
  	   EN_SECOND     : OUT STD_LOGIC;
  	   DELAY_END     : IN  STD_LOGIC;
  		 EN_DELAY_OUT  : OUT STD_LOGIC;
  		 SUB           : OUT STD_LOGIC;
       SIMULTANEOUS  : OUT STD_LOGIC;
  		 DONE          : OUT STD_LOGIC
  	);
  END COMPONENT;
  SIGNAL RST_DP, EN_CNT_DELAY, RST_CNT_DELAY, EN_FIRST, EN_SECOND, DELAY_END, EN_DELAY_OUT, SUB : STD_LOGIC;
begin

DP: DP_DELAY PORT MAP(CLK, RST_DP, EN_CNT_DELAY, RST_CNT_DELAY, EN_FIRST, EN_SECOND,
                      DELAY_END, DELAY_OUT, MSB, EN_DELAY_OUT, SUB);
CU : CU_DELAY PORT MAP(CLK, RST, RST_DP, PEAK1, PEAK2, RESTART, EN_CNT_DELAY, RST_CNT_DELAY, EN_FIRST,         EN_SECOND, DELAY_END, EN_DELAY_OUT, SUB, SIMULTANEOUS, DONE);
end architecture;
