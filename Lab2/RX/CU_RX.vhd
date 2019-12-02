LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CU_RX IS
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
END ENTITY;

ARCHITECTURE BEH OF CU_RX IS

TYPE STATE_TYPE IS (RESET, IDLE, BUSY, RECEIVE, DAV);
SIGNAL STATE : STATE_TYPE;

BEGIN

FSM : PROCESS(CLOCK, RST, RD, S_BIT, FRAME_END, BAUD_END)
  BEGIN
    IF (CLOCK'EVENT AND CLOCK = '1') THEN
      IF (RST = '0') THEN
        STATE <= RESET;
      ELSE
      CASE (STATE) IS
        WHEN RESET =>
            STATE <= IDLE;
        WHEN IDLE =>
     		 IF(S_BIT = '0') THEN
			     STATE <= IDLE;
			 ELSE
			     STATE <= BUSY;
			 END IF;
		WHEN BUSY =>
			 IF(BAUD_END = '0') THEN
			     STATE <= BUSY;
			 ELSE
			     STATE <= RECEIVE;
			 END IF;
	    WHEN RECEIVE =>
			 IF(FRAME_END = '1') THEN
				 STATE <= DAV;
			 ELSE
				 STATE <= BUSY;
			 END IF;
		WHEN DAV =>
			 IF(RD = '0') THEN
				 STATE <= DAV;
			 ELSE
				 STATE <= IDLE;
			 END IF;
		WHEN OTHERS =>
		         STATE <= RESET;
		END CASE;
	  END IF;
	END IF;
END PROCESS;

output_control : process(state)
     begin
	 DP_RST <= '1';
	 ENABLE_INPUT <= '1';
	 ENABLE_OUTPUT <= '0';
	 BAUD_EN <= '0';
	 FRAME_EN <= '0';
	 DATA_VALID <= '0';

	 CASE(STATE) IS
	    WHEN RESET =>
		 DP_RST <= '0';
		WHEN IDLE =>
		WHEN BUSY =>
		 BAUD_EN <= '1';
		WHEN RECEIVE =>
         FRAME_EN <= '1';
				 ENABLE_OUTPUT <= '1';
        WHEN DAV =>
         DATA_VALID <= '1';
	 END CASE;
   END PROCESS;

END ARCHITECTURE;
