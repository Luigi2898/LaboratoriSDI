LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DP_TX IS
	PORT(CLOCK     : IN STD_LOGIC;
		 DATA_IN   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 BAUD_END  : OUT STD_LOGIC;
		 SHIFT_END : OUT STD_LOGIC;
		 SH_OUT    : OUT STD_LOGIC;
		 DP_RST    : IN STD_LOGIC;
		 BAUD_CNT  : IN STD_LOGIC;
		 SHIFT_CNT : IN STD_LOGIC;
		 SHIFT_EN  : IN STD_LOGIC;
		 LOAD_EN   : IN STD_LOGIC;
		 READ_EN   : IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE STRUCTURAL OF DP_TX IS

COMPONENT N_COUNTER IS
		GENERIC(N : INTEGER:= 12; MODULE : INTEGER:= 2604);
		PORT(CLK : IN STD_LOGIC;
			 EN  : IN STD_LOGIC;
			 RST : IN STD_LOGIC;
			 CNT_END : OUT STD_LOGIC;
			 CNT_OUT : BUFFER UNSIGNED(N-1 DOWNTO 0)
		);
END COMPONENT;

COMPONENT REG_N IS
GENERIC ( N : INTEGER := 8);
PORT(
		IN_REG : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		CLK, ENABLE, RST : IN STD_LOGIC;
		OUT_REG : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT SHIFTREGN_U IS
  GENERIC(
    N : INTEGER := 10
  );
  PORT (
    CLOCK    : IN STD_LOGIC;
    SHIFT_EN : IN STD_LOGIC;
    LOAD_EN  : IN STD_LOGIC;
    RSTN     : IN STD_LOGIC;
    D_IN     : IN STD_LOGIC_VECTOR(N-3 DOWNTO 0);
    D_OUT    : OUT STD_LOGIC
  );
END COMPONENT;

SIGNAL BAUD_OUT : UNSIGNED(11 DOWNTO 0);
SIGNAL SHIFT_OUT : UNSIGNED(3 DOWNTO 0);
SIGNAL REG_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);



BEGIN
CNT_BAUD: N_COUNTER GENERIC MAP(N => 12, MODULE => 2604) PORT MAP(CLOCK, BAUD_CNT, DP_RST, BAUD_END, BAUD_OUT);

SH_CNT: N_COUNTER GENERIC MAP(N => 4, MODULE => 10) PORT MAP(CLOCK, SHIFT_CNT, DP_RST, SHIFT_END, SHIFT_OUT);

REG: REG_N GENERIC MAP (N => 8)  PORT MAP(DATA_IN, CLOCK, READ_EN, DP_RST, REG_OUT);

SH_REG: SHIFTREGN_U GENERIC MAP (N => 10) PORT MAP(CLOCK, SHIFT_EN, LOAD_EN, DP_RST, REG_OUT, SH_OUT);










END ARCHITECTURE;
