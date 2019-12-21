LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;


ENTITY DATAPATH IS
	GENERIC(N : INTEGER := 47);
	PORT(CLOCK       : IN STD_LOGIC;
         RST         : IN STD_LOGIC;
		 IN1         : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 W_R         : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 W_I         : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 MULT2       : IN STD_LOGIC;
		 DP_OUT      : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
		 CONNECTIONS : IN STD_LOGIC_VECTOR(40 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE STRUCTURE OF DATAPATH IS

COMPONENT TRISTATE IS
	GENERIC(N : INTEGER := 47);
	PORT(D_IN : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 D_OUT : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 EN : IN STD_LOGIC
	);
END COMPONENT;

COMPONENT BAS IS
  GENERIC(
    PARALLELISM : INTEGER := 8;
    NINPUT      : INTEGER := 3;
    NOUTPUT     : INTEGER := 2
  );
  PORT (
    INPUTENABLE  : IN STD_LOGIC_VECTOR(NINPUT - 1 DOWNTO 0);
    OUTPUTENABLE : IN STD_LOGIC_VECTOR(NOUTPUT - 1 DOWNTO 0);
    INS          : IN STD_LOGIC_VECTOR((NINPUT * PARALLELISM) - 1 DOWNTO 0);
    OUTS         : OUT STD_LOGIC_VECTOR((NOUTPUT * PARALLELISM) - 1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT REGISTRO IS
  GENERIC(NBIT : INTEGER := 8);
  PORT (
   DATAIN  : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
   DATAOUT : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
   CLOCK   : IN STD_LOGIC;
   RESET   : IN STD_LOGIC
  );
END COMPONENT;

COMPONENT MUX IS
	GENERIC(N : INTEGER := 47);
	PORT(IN_MUX, W_R, W_I : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 OUT_MUX : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		 SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT SUB IS
  GENERIC (NBIT : INTEGER :=8);
  PORT (DATA_1 : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
	    DATA_2 : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
        SUB    : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT ADDER IS
  GENERIC (NBIT : INTEGER :=8);
  PORT (DATA_1 : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
	    DATA_2 : IN STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0);
	    ADD    : OUT STD_LOGIC_VECTOR(NBIT-1 DOWNTO 0)
  );
END COMPONENT;

COMPONENT MULTIPLIER IS
  GENERIC(NBIT : INTEGER := 8);
  PORT (IN1   : IN STD_LOGIC_VECTOR(NBIT - 1 DOWNTO 0);
		IN2   : IN STD_LOGIC_VECTOR(NBIT - 1 DOWNTO 0);
		MULT2 : IN STD_LOGIC; -- SE '1' MULTIPLICA PER 2, ALTRIMENTI MOLTIPLICA I DUE INGRESSI
		RES   : OUT STD_LOGIC_VECTOR(2 * NBIT - 1 DOWNTO 0)
  );
END COMPONENT;

SIGNAL SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL OUT_MUX: STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL OUTS_BUS_H_EXT, OUTS_BUS_A_EXT2, OUTS_BUS_A_EXT3, OUT_R3_EXT : STD_LOGIC_VECTOR(47 DOWNTO 0);

--SEGNALI REGISTRI
SIGNAL OUT_R1, OUT_R2, OUT_R3, OUT_R7: STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL OUT_R9, OUT_R5, OUT_R4, OUT_R8, OUT_R6, ADD, OUTS_BUS_I, OUT_SUB: STD_LOGIC_VECTOR(47 DOWNTO 0);
--SEGNALI USCITE BUS
SIGNAL OUTS_BUS_A, OUTS_BUS_B : STD_LOGIC_VECTOR(3*24 - 1 DOWNTO 0);
SIGNAL OUTS_BUS_H : STD_LOGIC_VECTOR(2*24 - 1 DOWNTO 0);
SIGNAL OUTS_BUS_G, OUTS_BUS_D : STD_LOGIC_VECTOR(3*48 - 1 DOWNTO 0);
SIGNAL OUTS_BUS_C, OUTS_BUS_F, OUTS_BUS_E: STD_LOGIC_VECTOR(2*48 - 1 DOWNTO 0);
--SEGNALI USCITE MULTIPLIER
SIGNAL RES : STD_LOGIC_VECTOR(2*24-1 DOWNTO 0);

BEGIN

MUX1 : MUX GENERIC MAP(N => 24) PORT MAP(IN1, W_R, W_I, OUT_MUX, SEL);

BUS_A : BAS GENERIC MAP(PARALLELISM => 24, NINPUT => 1, NOUTPUT => 3) PORT MAP(CONNECTIONS(0 DOWNTO 0), CONNECTIONS(3 DOWNTO 1), OUT_MUX, OUTS_BUS_A);

BUS_B : BAS GENERIC MAP(PARALLELISM => 24, NINPUT => 1, NOUTPUT => 3) PORT MAP(CONNECTIONS(4 DOWNTO 4), CONNECTIONS(7 DOWNTO 5), IN1, OUTS_BUS_B);

--EXT BUS A (2) E (3)
OUTS_BUS_A_EXT2(47 DOWNTO 24) <= (OTHERS => OUTS_BUS_A(47));
OUTS_BUS_A_EXT2 <= OUTS_BUS_A_EXT2(47 DOWNTO 24) & OUTS_BUS_A(47 DOWNTO 24);
OUTS_BUS_A_EXT3(47 DOWNTO 24) <= (OTHERS => OUTS_BUS_A(71));
OUTS_BUS_A_EXT3 <= OUTS_BUS_A_EXT3(47 DOWNTO 24) & OUTS_BUS_A(71 DOWNTO 48);
BUS_C : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 4, NOUTPUT => 2) PORT MAP(CONNECTIONS(11 DOWNTO 8), CONNECTIONS(13 DOWNTO 12),
	    OUTS_BUS_D(143 DOWNTO 96)&OUTS_BUS_D(95 DOWNTO 48)&OUTS_BUS_A_EXT3&OUTS_BUS_A_EXT2, OUTS_BUS_C);

BUS_D : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 2, NOUTPUT => 3) PORT MAP(CONNECTIONS(15 DOWNTO 14), CONNECTIONS(18 DOWNTO 16),
	    ADD&OUT_SUB, OUTS_BUS_D);
		
DP_OUT <= OUTS_BUS_D(47 DOWNTO 0);		

OUT_R3_EXT(47 DOWNTO 24) <= (OTHERS => OUT_R3(23));
OUT_R3_EXT <= OUT_R3_EXT(47 DOWNTO 24) & OUT_R3;
BUS_E : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 3, NOUTPUT => 2) PORT MAP(CONNECTIONS(21 DOWNTO 19), CONNECTIONS(23 DOWNTO 22),
		OUT_R8&OUT_R5&OUT_R3_EXT, OUTS_BUS_E);

BUS_F : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 2, NOUTPUT => 2) PORT MAP(CONNECTIONS(25 DOWNTO 24), CONNECTIONS(27 DOWNTO 26), OUT_R6&OUT_R4, OUTS_BUS_F);

BUS_G : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 3, NOUTPUT => 3) PORT MAP(CONNECTIONS(30 DOWNTO 28), CONNECTIONS(33 DOWNTO 31),
	    OUTS_BUS_H_EXT&RES&OUT_R9, OUTS_BUS_G);

--ESTENSIONE SU 48 BIT
OUTS_BUS_H_EXT(47 DOWNTO 24) <= (OTHERS => OUTS_BUS_H(47));
OUTS_BUS_H_EXT <= OUTS_BUS_H_EXT(47 DOWNTO 24) & OUTS_BUS_H(47 DOWNTO 24);
BUS_H : BAS GENERIC MAP(PARALLELISM => 24, NINPUT => 3, NOUTPUT => 2) PORT MAP(CONNECTIONS(36 DOWNTO 34), CONNECTIONS(38 DOWNTO 37),
		OUT_R1&OUT_R7&OUT_R2, OUTS_BUS_H);

BUS_I : BAS GENERIC MAP(PARALLELISM => 48, NINPUT => 1, NOUTPUT => 1) PORT MAP(CONNECTIONS(39 DOWNTO 39), CONNECTIONS(40 DOWNTO 40), OUT_R5, OUTS_BUS_I);

R1 : REGISTRO GENERIC MAP(NBIT => 24) PORT MAP(OUTS_BUS_B(23 DOWNTO 0), OUT_R1, CLOCK, RST);

R2 : REGISTRO GENERIC MAP(NBIT => 24) PORT MAP(OUTS_BUS_B(71 DOWNTO 48), OUT_R2, CLOCK, RST);

R3 : REGISTRO GENERIC MAP(NBIT => 24) PORT MAP(OUTS_BUS_A(23 DOWNTO 0), OUT_R3, CLOCK, RST);

R4 : REGISTRO GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_G(95 DOWNTO 48), OUT_R4, CLOCK, RST);

R5 : REGISTRO GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_C(95 DOWNTO 48), OUT_R5, CLOCK, RST);

R6 : REGISTRO GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_F(47 DOWNTO 0), OUT_R6, CLOCK, RST);

R7 : REGISTRO GENERIC MAP(NBIT => 24) PORT MAP(OUTS_BUS_B(47 DOWNTO 24), OUT_R7, CLOCK, RST);

R8 : REGISTRO GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_C(47 DOWNTO 0), OUT_R8, CLOCK, RST);

R9 : REGISTRO GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_G(47 DOWNTO 0), OUT_R9, CLOCK, RST);

MULT : MULTIPLIER GENERIC MAP(NBIT => 24) PORT MAP(OUTS_BUS_H(23 DOWNTO 0), OUTS_BUS_E(23 DOWNTO 0), MULT2, RES); ------

ADD1 : ADDER GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_G(143 DOWNTO 96), OUTS_BUS_I(47 DOWNTO 0), ADD);

SUB1 : SUB GENERIC MAP(NBIT => 48) PORT MAP(OUTS_BUS_F(95 DOWNTO 48), OUTS_BUS_E(95 DOWNTO 48), OUT_SUB);







END ARCHITECTURE;
