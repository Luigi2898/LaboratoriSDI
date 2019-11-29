LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity CU is
  port (
    clock      : in std_logic;
    rst        : in std_logic;
    baud_end   : in std_logic;
    shift_end  : in std_logic;
    data_valid : in std_logic;
    dp_rst     : out std_logic;
    baud_cnt   : out std_logic;
    shift_cnt  : out std_logic;
    shift_en   : out std_logic;
    load_en    : out std_logic;
    read_en    : out std_logic;
    txready    : out std_logic
  );
end entity;

architecture Behavioural of CU is

  type state_type is (RESET, IDLE, TRANSMIT, BUSY);
  signal state : state_type;

begin

  Ball_diagram : process(clock, data_valid, rst)
  begin

    if (clock'event and clock = '1') then
      if (rst = '0') then
        state <= RESET;
      end if;
      case (state) is
        when RESET =>
          if (rst = '0') then
            state <= RESET;
          else
            state <= IDLE;
          end if;
        when IDLE =>
          if (data_valid = '0') then
            state <= IDLE;
          else
            state <= TRANSMIT;
          end if;
        when TRANSMIT =>
          state <= BUSY;
        when BUSY =>
          if (baud_end = '0') then
            state <= BUSY;
          else
            if (shift_end = '0') then
              state <= TRANSMIT;
            else
              state <= IDLE;
            end if;
          end if;
        when others =>
          state <= RESET;

      end case;
    end if;

  end process;

end architecture;
