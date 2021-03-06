LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MIC_FRONT_END IS
	PORT(CLK_10N : IN STD_LOGIC;
		 CLK_MIC : IN STD_LOGIC;
		 RST     : IN STD_LOGIC;	
		 FF_OUT  : OUT STD_LOGIC;
		 FF_OUT_NEG : OUT STD_LOGIC
	
	);
END ENTITY;



ARCHITECTURE BEH OF MIC_FRONT_END IS

COMPONENT DP_FRONT_END IS
	PORT(CLK_10N : IN STD_LOGIC;
		 RST_CNT1 : IN STD_LOGIC;
		 RST_CNT2  : IN STD_LOGIC;
		 TC_HIGH : OUT STD_LOGIC;
		 TC_HIGH_NEG : OUT STD_LOGIC;
		 FF_IN : IN STD_LOGIC;
		 FF_OUT : OUT STD_LOGIC;
		 EN_FF1 : IN STD_LOGIC;
		 RST_FF1: IN STD_LOGIC;
		 FF_IN_NEG : IN STD_LOGIC;
		 FF_OUT_NEG : OUT STD_LOGIC;
		 EN_FF2  : IN STD_LOGIC;
		 RST_FF2 : IN STD_LOGIC
	);
END COMPONENT;

COMPONENT CU_FRONT_END IS
	PORT(CLK_10N : IN STD_LOGIC;
	     CLK_MIC  : IN STD_LOGIC;
		 RST_CU     : IN STD_LOGIC;
		 RST_CNT1 : OUT STD_LOGIC;
		 RST_CNT2  : OUT STD_LOGIC;
		 TC_HIGH : IN STD_LOGIC;
		 TC_HIGN_NEG : IN STD_LOGIC;
		 FF_IN : OUT STD_LOGIC;
		 EN_FF1 : OUT STD_LOGIC;
		 RST_FF1: OUT STD_LOGIC;
		 FF_IN_NEG : OUT STD_LOGIC;
		 EN_FF2  : OUT STD_LOGIC;
		 RST_FF2 : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL RST_CNT1, RST_CNT2, TC_HIGH, TC_HIGH_NEG, FF_IN, EN_FF1, RST_FF1, FF_IN_NEG, EN_FF2, RST_FF2 : STD_LOGIC;
BEGIN

CU : CU_FRONT_END PORT MAP(CLK_10N, CLK_MIC, RST, RST_CNT1, RST_CNT2, TC_HIGH, TC_HIGH_NEG, FF_IN, EN_FF1, RST_FF1, FF_IN_NEG, EN_FF2, RST_FF2);

DP : DP_FRONT_END PORT MAP(CLK_10N, RST_CNT1, RST_CNT2, TC_HIGH, TC_HIGH_NEG, FF_IN, FF_OUT, EN_FF1, RST_FF1, FF_IN_NEG, FF_OUT_NEG, EN_FF2, RST_FF2);


END ARCHITECTURE;