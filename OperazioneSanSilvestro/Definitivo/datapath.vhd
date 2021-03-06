LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY DATAPATH IS
	PORT(CLOCK   : IN STD_LOGIC;
		 Ai, Ar    : IN SIGNED(23 DOWNTO 0);
		 Bi, Br    : IN SIGNED(23 DOWNTO 0);
     Wi, Wr    : IN SIGNED(23 DOWNTO 0);
		 CONTROLS: IN STD_LOGIC_VECTOR(24 DOWNTO 0); --DA RIVEDERE
		 EXT     : OUT SIGNED(46 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE STRUCTURE OF DATAPATH IS

COMPONENT GENERICS_MUX IS
	GENERIC(INPUTS : INTEGER := 15; SIZE: INTEGER := 1); --N INPUT, N BIT
	PORT(INS : IN SIGNED((INPUTS*SIZE)-1 DOWNTO 0);
		 SEL : IN INTEGER;
		 OUT_MUX : OUT SIGNED(SIZE-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT REGISTRO IS
  GENERIC(NBIT : INTEGER := 8);
  PORT (
   DATAIN  : IN SIGNED(NBIT-1 DOWNTO 0);
   DATAOUT : OUT SIGNED(NBIT-1 DOWNTO 0);
   EN_REGISTRO : IN STD_LOGIC;
   CLOCK   : IN STD_LOGIC;
   RESET   : IN STD_LOGIC
  );
END COMPONENT;


COMPONENT SUB IS
  GENERIC (NBIT : INTEGER :=8);
  PORT (DATA_1 : IN SIGNED(NBIT-1 DOWNTO 0);
	    DATA_2 : IN SIGNED(NBIT-1 DOWNTO 0);
        SUB    : OUT SIGNED(NBIT-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT ADDER IS
  GENERIC (NBIT : INTEGER :=8);
  PORT (DATA_1 : IN SIGNED(NBIT-1 DOWNTO 0);
	    DATA_2 : IN SIGNED(NBIT-1 DOWNTO 0);
	    ADD    : OUT SIGNED(NBIT-1 DOWNTO 0)
  );
END COMPONENT;

component Multiplier
generic (
  Nbit : integer := 8
);
port (
  In1   : in  signed(Nbit - 1 downto 0);
  In2   : in  signed(Nbit - 1 downto 0);
  Mult2 : in  std_logic;
  clk   : in  std_logic;
  rst   : in  std_logic;
  Res   : out signed(2 * Nbit - 2 downto 0)
);
end component Multiplier;

------------------------------------------------------------------------------------------------------
--SIGNAL REG--
SIGNAL OUT_R1, OUT_R2, OUT_R3, OUT_R4, OUT_R5, OUT_R6: SIGNED(23 DOWNTO 0);
SIGNAL OUT_R1_EXT, OUT_R2_EXT : SIGNED(46 DOWNTO 0);
SIGNAL OUT_R7, OUT_R8, OUT_R9, OUT_R10: SIGNED(46 DOWNTO 0);

------------------------------------------------------------------------------------------------------
--SIGNAL MUX--
SIGNAL IN_MUX1: SIGNED(47 DOWNTO 0);
SIGNAL IN_MUX2: SIGNED(95 DOWNTO 0);
SIGNAL IN_MUX3: SIGNED(140 DOWNTO 0);
SIGNAL IN_MUX4: SIGNED(93 DOWNTO 0);
SIGNAL IN_MUX5: SIGNED(93 DOWNTO 0);
SIGNAL IN_MUX6: SIGNED(93 DOWNTO 0);
SIGNAL IN_MUX7: SIGNED(93 DOWNTO 0);
SIGNAL IN_MUX8: SIGNED(187 DOWNTO 0);
SIGNAL OUT_MUX1: SIGNED(23 DOWNTO 0);
SIGNAL OUT_MUX2: SIGNED(23 DOWNTO 0);
SIGNAL OUT_MUX3: SIGNED(46 DOWNTO 0);
SIGNAL OUT_MUX4: SIGNED(46 DOWNTO 0);
SIGNAL OUT_MUX5: SIGNED(46 DOWNTO 0);
SIGNAL OUT_MUX7: SIGNED(46 DOWNTO 0);
SIGNAL OUT_MUX8: SIGNED(46 DOWNTO 0);
------------------------------------------------------------------------------------------------------
SIGNAL OUT_SUB, OUT_ADD : SIGNED(46 DOWNTO 0);
------------------------------------------------------------------------------------------------------
SIGNAL RES_MULT: SIGNED(46 DOWNTO 0);
------------------------------------------------------------------------------------------------------
signal ctr1, ctr2, ctr3, ctr4, ctr5, ctr6, ctr7, ctr8 : integer := 0;
BEGIN
------------------------------------------------------------------------------------------------------
--REGISTRI--
R1  : REGISTRO GENERIC MAP(24) PORT MAP(Ar,OUT_R1,CONTROLS(11),CLOCK,CONTROLS(12)); --AR

R2  : REGISTRO GENERIC MAP(24) PORT MAP(Ai,OUT_R2,CONTROLS(10),CLOCK,CONTROLS(12)); --AI

R3  : REGISTRO GENERIC MAP(24) PORT MAP(Br,OUT_R3,CONTROLS(9),CLOCK,CONTROLS(12));  --BR

R4  : REGISTRO GENERIC MAP(24) PORT MAP(Bi,OUT_R4,CONTROLS(8),CLOCK,CONTROLS(12));  --BI

R5  : REGISTRO GENERIC MAP(24) PORT MAP(Wr,OUT_R5,CONTROLS(7),CLOCK,CONTROLS(12));  --WR

R6  : REGISTRO GENERIC MAP(24) PORT MAP(Wi,OUT_R6,CONTROLS(6),CLOCK,CONTROLS(12));  --WI

R7  : REGISTRO GENERIC MAP(47) PORT MAP(OUT_MUX5,OUT_R7,CONTROLS(5),CLOCK,CONTROLS(12));

R8  : REGISTRO GENERIC MAP(47) PORT MAP(RES_MULT, OUT_R8,CONTROLS(4),CLOCK, CONTROLS(12));

R9  : REGISTRO GENERIC MAP(47) PORT MAP(RES_MULT, OUT_R9,CONTROLS(3),CLOCK, CONTROLS(12));

R10 : REGISTRO GENERIC MAP(47) PORT MAP(OUT_MUX4, OUT_R10, CONTROLS(2), CLOCK, CONTROLS(12));
----------------------------------------------------------------------------------------------------
--MULTIPLICATORE--
MOLTIPLICATORE : MULTIPLIER GENERIC MAP(24) PORT MAP(OUT_MUX2,OUT_MUX1,CONTROLS(13),clock, CONTROLS(12), RES_MULT);
----------------------------------------------------------------------------------------------------
--SOMMATORE--
ADD : ADDER GENERIC MAP(47) PORT MAP(OUT_R9, OUT_MUX3, OUT_ADD);
----------------------------------------------------------------------------------------------------
--SOTTRATTORE--
SUB1 : SUB GENERIC MAP(47) PORT MAP(OUT_MUX8, OUT_MUX7, OUT_SUB);
----------------------------------------------------------------------------------------------------
--CONCAT SEGNALI
IN_MUX1 <= OUT_R6 & OUT_R5;
IN_MUX2 <= OUT_R4 & OUT_R3 & OUT_R2 & OUT_R1;
IN_MUX3 <= OUT_R10 & OUT_R2_EXT & OUT_R1_EXT;
IN_MUX4 <= OUT_ADD & OUT_SUB;
IN_MUX5 <= OUT_SUB & RES_MULT(46 DOWNTO 0);
IN_MUX6 <= OUT_R10 & OUT_R7;
IN_MUX7 <= OUT_R10 & OUT_R9;
IN_MUX8 <= OUT_R10 & OUT_R9 & OUT_R8 & OUT_R7;
-----------------------------------------------------------------------------------------------------------
--ESTENSIONE
OUT_R1_EXT(22 DOWNTO 0) <= (OTHERS => '0');
OUT_R1_EXT(46 downto 23) <=  OUT_R1;

OUT_R2_EXT(22 DOWNTO 0) <= (OTHERS => '0');
OUT_R2_EXT(46 downto 23) <=  OUT_R2;
-----------------------------------------------------------------------------------------------------------
--MUXES--
ctr1 <= TO_INTEGER(UNSIGNED(CONTROLS(24 DOWNTO 24)));
MUX1 : GENERICS_MUX GENERIC MAP(INPUTS => 2, SIZE => 24) PORT MAP(IN_MUX1, ctr1, OUT_MUX1);

ctr2 <= TO_INTEGER(UNSIGNED(CONTROLS(23 DOWNTO 23) & CONTROLS(22 DOWNTO 22)));
MUX2 : GENERICS_MUX GENERIC MAP(INPUTS => 4, SIZE => 24)
                    PORT MAP(IN_MUX2, ctr2, OUT_MUX2);

ctr3 <= TO_INTEGER(UNSIGNED(CONTROLS(21 DOWNTO 21) & CONTROLS(20 DOWNTO 20)));
MUX3 : GENERICS_MUX GENERIC MAP(INPUTS => 3, SIZE => 47) PORT MAP(IN_MUX3, ctr3, OUT_MUX3);

ctr4 <= TO_INTEGER(UNSIGNED(CONTROLS(19 DOWNTO 19)));
MUX4 : GENERICS_MUX GENERIC MAP(INPUTS => 2, SIZE => 47)
                    PORT MAP(IN_MUX4, ctr4, OUT_MUX4);

ctr5 <= TO_INTEGER(UNSIGNED(CONTROLS(18 DOWNTO 18)));
MUX5 : GENERICS_MUX GENERIC MAP(INPUTS => 2, SIZE => 47) PORT MAP(IN_MUX5, ctr5, OUT_MUX5);

ctr6 <= TO_INTEGER(UNSIGNED(CONTROLS(17 DOWNTO 17)));
MUX6 : GENERICS_MUX GENERIC MAP(INPUTS => 2, SIZE => 47) PORT MAP(IN_MUX6, ctr6, EXT);

ctr7 <= TO_INTEGER(UNSIGNED(CONTROLS(16 DOWNTO 16)));
MUX7 : GENERICS_MUX GENERIC MAP(INPUTS => 2, SIZE => 47) PORT MAP(IN_MUX7, ctr7, OUT_MUX7);

ctr8 <= TO_INTEGER(UNSIGNED(CONTROLS(15 DOWNTO 15) & CONTROLS(14 DOWNTO 14)));
MUX8 : GENERICS_MUX GENERIC MAP(INPUTS => 4, SIZE => 47)
                    PORT MAP(IN_MUX8, ctr8, OUT_MUX8);
------------------------------------------------------------------------------------------------------------
END ARCHITECTURE;
