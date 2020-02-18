LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--CONTROL UNIT TX

ENTITY CU IS
  PORT (
    CLOCK      : IN STD_LOGIC;
    RST        : IN STD_LOGIC;
    BAUD_END   : IN STD_LOGIC;
    SHIFT_END  : IN STD_LOGIC;
    DATA_VALID : IN STD_LOGIC;
    DP_RST     : OUT STD_LOGIC;
    BAUD_CNT   : OUT STD_LOGIC;
    SHIFT_CNT  : OUT STD_LOGIC;
    SHIFT_EN   : OUT STD_LOGIC;
    LOAD_EN    : OUT STD_LOGIC;
    READ_EN    : OUT STD_LOGIC;
    TXREADY    : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE BEHAVIOURAL OF CU IS

  TYPE STATE_TYPE IS (RESET, IDLE, LOAD, TRANSMIT, BUSY);
  SIGNAL STATE : STATE_TYPE;

BEGIN

  FSM : PROCESS(CLOCK, DATA_VALID, RST)
  BEGIN

    IF (CLOCK'EVENT AND CLOCK = '1') THEN
      IF (RST = '0') THEN
        STATE <= RESET;
      ELSE
      CASE (STATE) IS
        WHEN RESET =>
            STATE <= IDLE;
        WHEN IDLE =>
          IF (DATA_VALID = '0') THEN
            STATE <= IDLE;
          ELSE
            STATE <= LOAD;
          END IF;
        WHEN LOAD =>
          STATE <= TRANSMIT;
        WHEN TRANSMIT =>
          STATE <= BUSY;
        WHEN BUSY =>
          IF (BAUD_END = '0') THEN
            STATE <= BUSY;
          ELSE
            IF (SHIFT_END = '0') THEN
              STATE <= TRANSMIT;
            ELSE
              STATE <= IDLE;
            END IF;
          END IF;
        WHEN OTHERS =>
          STATE <= RESET;

      END CASE;
    END IF;
    END IF;

  END PROCESS;

  OUTPUT_CONTROL : PROCESS(STATE)
  BEGIN
    DP_RST    <= '1';
    BAUD_CNT  <= '0';
    SHIFT_CNT <= '0';
    SHIFT_EN  <= '0';
    LOAD_EN   <= '0';
    READ_EN   <= '1';
    TXREADY   <= '1';
      CASE (STATE) IS
        WHEN RESET =>
          DP_RST   <= '0';

        WHEN IDLE =>
          SHIFT_EN <= '1';
        WHEN LOAD =>
          LOAD_EN <= '1';
        WHEN TRANSMIT =>
          SHIFT_EN  <= '1';
          SHIFT_CNT <= '1';
          TXREADY   <= '0';
        WHEN BUSY =>
          BAUD_CNT <= '1';
          TXREADY <= '0';
      END CASE;
  END PROCESS;

END ARCHITECTURE;
