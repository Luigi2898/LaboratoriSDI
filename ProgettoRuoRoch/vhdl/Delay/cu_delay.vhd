LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CU_DELAY IS
	PORT(CLK           : IN  STD_LOGIC;
		 RST           : IN  STD_LOGIC;
		 RST_DP        : OUT STD_LOGIC;
		 PEAK1         : IN  STD_LOGIC;
		 PEAK2         : IN  STD_LOGIC;
		 RESTART       : OUT STD_LOGIC; --FA RIPARTIRE I COMPARATORI
		 EN_CNT_DELAY  : OUT STD_LOGIC;
		 RST_CNT_DELAY : OUT STD_LOGIC;
         RST_FIRST     : OUT STD_LOGIC;
         RST_SECOND    : OUT STD_LOGIC;
		 EN_FIRST      : OUT STD_LOGIC;
	     EN_SECOND     : OUT STD_LOGIC;
	     DELAY_END     : IN  STD_LOGIC;
		 EN_DELAY_OUT  : OUT STD_LOGIC;
		 SUB           : OUT STD_LOGIC;
         SIMULTANEOUS  : buffer STD_LOGIC;
		 DONE          : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE BEH OF CU_DELAY IS

TYPE STATE_TYPE IS (IDLE, FIRST_DX, FIRST_SX, SECOND_DX, SECOND_SX, EQUAL, CALC_DELAY, TRANSMIT);
SIGNAL STATE: STATE_TYPE;

BEGIN

FSM_DELAY : PROCESS(CLK, RST)
BEGIN
IF(RST = '0') THEN
	STATE <= IDLE;
	ELSIF(CLK'EVENT AND CLK = '1') THEN
		CASE(STATE) IS
		WHEN IDLE=>  IF(PEAK1 = '1' AND PEAK2 = '0') THEN
						     STATE <= FIRST_DX;
						     ELSIF(PEAK1 = '0' AND PEAK2 = '1') THEN
						     STATE <= FIRST_SX;
                 elsif (PEAK1 = '1' AND PEAK2 = '1') then
                  STATE <= EQUAL;
						     ELSE STATE <= IDLE;
						     END IF;
		WHEN FIRST_DX =>     IF(PEAK2 = '1') THEN
						     STATE <= SECOND_SX;
						     ELSE STATE <= FIRST_DX;
						     END IF;
		WHEN FIRST_SX =>     IF(PEAK1 = '1') THEN
						     STATE <= SECOND_DX;
						     ELSE STATE <= FIRST_SX;
						     END IF;
    WHEN SECOND_DX => STATE <= CALC_DELAY;
    WHEN SECOND_SX => STATE <= CALC_DELAY;
    WHEN EQUAL => STATE <= TRANSMIT;
		WHEN CALC_DELAY =>   STATE <= TRANSMIT;
		WHEN TRANSMIT   =>   STATE <= IDLE;
	    WHEN OTHERS => STATE <= IDLE;
		END CASE;
END IF;
END PROCESS;


OUTPUT_P : PROCESS(STATE)
BEGIN
RST_DP <= '1';
RST_CNT_DELAY <= '1';
RST_FIRST <= '1';
RST_SECOND <= '1';
RESTART <= '0';
EN_CNT_DELAY <= '0';
EN_FIRST  <= '0';
EN_SECOND <= '0';
EN_DELAY_OUT <= '0';
SIMULTANEOUS <= '0';
SUB <= '0';
DONE <= '0';

CASE (STATE) IS
	  WHEN IDLE =>
    RST_DP <= '0';
    RST_CNT_DELAY <= '0';
    RST_FIRST <= '0';
    RST_SECOND <= '0';
    WHEN FIRST_DX =>
	RST_FIRST <= '0';
    EN_CNT_DELAY <= '1';
    WHEN FIRST_SX =>
    RST_SECOND <= '0';
    EN_CNT_DELAY <= '1';
    WHEN SECOND_SX =>
    EN_SECOND <= '1';
    WHEN SECOND_DX =>
    EN_FIRST <= '1';
    WHEN CALC_DELAY =>
	EN_DELAY_OUT <= '1';
    WHEN EQUAL =>
    SIMULTANEOUS <= '1';
    WHEN TRANSMIT =>
    done <= '1';
		RESTART <= '1';

END CASE;
END PROCESS;

END ARCHITECTURE;
