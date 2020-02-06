LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CU_FILTER IS
	PORT(CLK				  : IN STD_LOGIC;
         RST                  : IN STD_LOGIC;
		 START                : IN STD_LOGIC;
		 RST_ALL              : OUT STD_LOGIC;
		 DAV_OUT              : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 DAV_IN               : OUT STD_LOGIC;
		 LOAD                 : OUT STD_LOGIC;
		 M_EN                 : OUT STD_LOGIC;
		 RST_ACC              : OUT STD_LOGIC;
		 EN_ACC				  : OUT STD_LOGIC;
		 M_DIV_END_IN         : OUT STD_LOGIC;
		 M_DIV_END_OUT        : IN STD_LOGIC; 
		 FILT_VALID           : OUT STD_LOGIC;
		 CNT_END              : IN STD_LOGIC	
	);
END ENTITY;


ARCHITECTURE BEH OF CU_FILTER IS

TYPE STATE_TYPE IS (RST_S, IDLE, INIT, WAITS, END_DIV, ACCUMULATE, COUNT, DATA_VALID);
SIGNAL STATE : STATE_TYPE; 

BEGIN

FSM_PROCESS : PROCESS(CLK, RST)
BEGIN
IF(RST = '0') THEN
	STATE <= RST_S;
	ELSIF(CLK'EVENT AND CLK = '1') THEN
		  CASE STATE IS
		  WHEN RST_S      => STATE <= IDLE;
		  WHEN IDLE       => IF(START = '1') THEN
					         STATE <= INIT;
					         ELSE STATE <= IDLE;
					         END IF;
		  WHEN INIT       => STATE <= WAITS;
		  WHEN WAITS      => IF(M_DIV_END_OUT = '1') THEN
							 STATE <= END_DIV;
							 ELSE STATE <= INIT;
							 END IF;
		 WHEN END_DIV     => IF((DAV_OUT(0) AND DAV_OUT(1) AND DAV_OUT(2) AND DAV_OUT(3) AND DAV_OUT(4)) = '1') THEN 
						     STATE <= ACCUMULATE;
						     ELSE STATE <= WAITS;
						     END IF;
		  WHEN ACCUMULATE => STATE <= COUNT;				 
		  WHEN COUNT      => IF(CNT_END = '1') THEN
							 STATE <= DATA_VALID;
							 ELSE STATE <= ACCUMULATE;
							 END IF;
		  WHEN DATA_VALID => IF(START = '1') THEN
					         STATE <= INIT;
					         ELSE STATE <= IDLE;
					         END IF;	
		  WHEN OTHERS     => STATE <= RST_S;					 
     	  END CASE; 
END IF;			
END PROCESS;

OUTPUT_P: PROCESS(STATE) 
BEGIN
RST_ALL <= '1';
RST_ACC <= '1';
LOAD <= '0';
M_EN <= '0';
DAV_IN <= '0';
EN_ACC <= '0';
M_DIV_END_IN <= '0';
FILT_VALID <= '0';
    CASE STATE IS
         WHEN RST_S => 
	     RST_ALL <= '0';
         WHEN IDLE => 
	     RST_ACC <= '0';
         WHEN INIT => 
         LOAD <= '1';	 
         M_EN <= '1'; 		 
         WHEN WAITS =>
		 
		 WHEN END_DIV =>
		 M_DIV_END_IN <= '1';     
		 WHEN ACCUMULATE =>
		 DAV_IN <= '1';
		 EN_ACC <= '1';
		 WHEN COUNT => 
		 
		 WHEN DATA_VALID =>
		 FILT_VALID <= '1';

END CASE;
END PROCESS;

END ARCHITECTURE;