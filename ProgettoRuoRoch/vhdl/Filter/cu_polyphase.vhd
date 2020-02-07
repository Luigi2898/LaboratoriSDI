LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CU_POLYPHASE IS 
	PORT(CLK          : IN STD_LOGIC;
         RST          : IN STD_LOGIC;
		 RST_FIR      : OUT STD_LOGIC;
		 RST_CNT_FIR  : OUT STD_LOGIC;
		 EN_CNT_FIR   : OUT STD_LOGIC;
		 CNT_END_POLY : IN STD_LOGIC;
		 OUT_MUX      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 PDM_AS	      : OUT STD_LOGIC;
		 EN_ACC       : OUT STD_LOGIC;
		 RST_ACC      : OUT STD_LOGIC;
		 LOAD_EN      : OUT STD_LOGIC;
		 DAV	      : OUT STD_LOGIC;
		 POLY_VALID   : IN STD_LOGIC;
		 SHIFT_EN     : OUT STD_LOGIC; 
		 M_DIV_END    : IN STD_LOGIC		 	
	);
END ENTITY;

ARCHITECTURE BEH OF CU_POLYPHASE IS

TYPE STATE_TYPE IS (IDLE, LOAD, WAITS, SUM, DIFF, COUNT, SHIFT, DATA_VALID, NEG_DAV);
SIGNAL STATE : STATE_TYPE;

BEGIN

FSM_FIR : PROCESS(CLK, RST)
BEGIN
IF(RST = '0') THEN
	STATE <= IDLE;
	ELSIF(CLK'EVENT AND CLK = '1') THEN
		CASE(STATE) IS
			WHEN IDLE =>  IF(M_DIV_END = '0') THEN
						  STATE <= IDLE;
						  ELSE STATE <= LOAD;
						  END IF;
			WHEN LOAD => STATE <= WAITS;
			WHEN WAITS =>IF(OUT_MUX(0) = '1') THEN
						 STATE <= SUM;
						 ELSE STATE <= DIFF;
						 END IF;			 
			WHEN SUM =>  STATE <= COUNT;	
			WHEN DIFF => STATE <= COUNT;
			WHEN COUNT => IF(CNT_END_POLY = '0') THEN 
						  STATE <= WAITS;
						  ELSE STATE <= SHIFT;
						  END IF;
			WHEN SHIFT => STATE <= DATA_VALID;
			WHEN DATA_VALID => IF(POLY_VALID = '1') THEN
					           STATE <= NEG_DAV;
							   ELSE STATE <= DATA_VALID;
							   END IF;
			WHEN NEG_DAV => IF(M_DIV_END = '0') THEN 
							   STATE <= NEG_DAV;
							   ELSE STATE <= LOAD;	
							   END IF;
			WHEN OTHERS => STATE <= IDLE;
		END CASE;
END IF;
END PROCESS;


OUTPUT_P : PROCESS(STATE)
BEGIN
RST_FIR <= '1';
RST_CNT_FIR <= '1';
RST_ACC <= '1';
EN_ACC <= '0';
LOAD_EN <= '0';
EN_CNT_FIR <= '0';
DAV <= '0';
PDM_AS <= '1';
SHIFT_EN <= '0';

CASE (STATE) IS
	WHEN IDLE => 
		 RST_FIR <= '0';
		 RST_ACC <= '0';
		 RST_CNT_FIR <= '0';
	WHEN LOAD =>
		 LOAD_EN <= '1';
		 RST_ACC <= '0';
		 RST_CNT_FIR <= '0';
	WHEN WAITS => 
	WHEN SUM => 
		 PDM_AS <= '1';
		 EN_ACC <= '1';		
		 EN_CNT_FIR <= '1';
	WHEN DIFF => 
		 PDM_AS <= '0';
		 EN_ACC <= '1';
		 EN_CNT_FIR <= '1';
	WHEN COUNT =>
		 
    WHEN SHIFT =>
		 SHIFT_EN <= '1';
	WHEN DATA_VALID =>
		 DAV <= '1';
	WHEN NEG_DAV => 
		 DAV <= '0';
END CASE;
END PROCESS;

END ARCHITECTURE;