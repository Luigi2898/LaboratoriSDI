LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DECIMATOR_FIR IS
	PORT(CLK        : IN STD_LOGIC;
		 RST        : IN STD_LOGIC;
		 START      : IN STD_LOGIC;
		 PDM_IN     : IN STD_LOGIC;
		 FILTER_OUT : OUT SIGNED(27 DOWNTO 0);
		 FILT_VALID : OUT STD_LOGIC	
	);
END ENTITY;

ARCHITECTURE BEH OF DECIMATOR_FIR IS

COMPONENT FILTER IS
	PORT(CLK           : IN STD_LOGIC;
         RST_ALL       : IN STD_LOGIC;
	     PDM_IN        : IN STD_LOGIC;
		 LOAD          : IN STD_LOGIC;
		 M_EN          : IN STD_LOGIC;
		 DAV_OUT       : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); --MANDARE ALLA CU
		 DAV_IN        : IN STD_LOGIC; --DALLA CU PER SOMMARE TUTTO
		 POLY_VALID    : IN STD_LOGIC;
		 EN_CNT_ADD    : IN STD_LOGIC;
		 RST_ACC       : IN STD_LOGIC;
		 EN_ACC        : IN STD_LOGIC;
		 RST_M_DIV     : IN STD_LOGIC;
		 M_DIV_END_IN  : IN STD_LOGIC; --DALLA CU
		 M_DIV_END_OUT : OUT STD_LOGIC; --ALLA CU
		 CNT_END       : OUT STD_LOGIC; --ALLA CU
	     FILTER_OUT    : BUFFER SIGNED(27 DOWNTO 0)
	);
END COMPONENT;

COMPONENT CU_FILTER IS
	PORT(CLK				  : IN STD_LOGIC;
         RST                  : IN STD_LOGIC;
		 START                : IN STD_LOGIC;
		 RST_ALL              : OUT STD_LOGIC;
		 RST_M_DIV            : OUT STD_LOGIC;
		 DAV_OUT              : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 DAV_IN               : OUT STD_LOGIC;
		 EN_CNT_ADD           : OUT STD_LOGIC;
		 LOAD                 : OUT STD_LOGIC;
		 M_EN                 : OUT STD_LOGIC;
		 RST_ACC              : OUT STD_LOGIC;
		 EN_ACC				  : OUT STD_LOGIC;
		 M_DIV_END_IN         : OUT STD_LOGIC;
		 M_DIV_END_OUT        : IN STD_LOGIC; 
		 FILT_VALID           : OUT STD_LOGIC;
		 POLY_VALID           : OUT STD_LOGIC;
		 CNT_END              : IN STD_LOGIC	
	);
END COMPONENT;

SIGNAL RST_ALL : STD_LOGIC;
SIGNAL DAV_OUT : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL DAV_IN, LOAD, M_EN, RST_ACC, EN_ACC, M_DIV_END_IN, M_DIV_END_OUT, CNT_END, RST_M_DIV, EN_CNT_ADD, POLY_VALID : STD_LOGIC;

BEGIN

FILTER1 : FILTER PORT MAP(CLK, RST_ALL, PDM_IN, LOAD, M_EN, DAV_OUT, DAV_IN, POLY_VALID, EN_CNT_ADD, RST_ACC, EN_ACC, 
                          RST_M_DIV, M_DIV_END_IN, M_DIV_END_OUT, CNT_END, FILTER_OUT); 

CU : CU_FILTER PORT MAP(CLK, RST, START, RST_ALL, RST_M_DIV, DAV_OUT, DAV_IN, EN_CNT_ADD, LOAD, M_EN, RST_ACC, EN_ACC,
                        M_DIV_END_IN, M_DIV_END_OUT, FILT_VALID, POLY_VALID, CNT_END);






END ARCHITECTURE;