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

  type state_type is (RESET, IDLE, LOAD, TRANSMIT, BUSY);
  signal state : state_type;

begin

  FSM : process(clock, data_valid, rst)
  begin

    if (clock'event and clock = '1') then
      if (rst = '0') then
        state <= RESET;
      else
      case (state) is
        when RESET =>
            state <= IDLE;
        when IDLE =>
          if (data_valid = '0') then
            state <= IDLE;
          else
            state <= LOAD;
          end if;
        when LOAD =>
          state <= TRANSMIT;
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
    end if;

  end process;

  output_control : process(state)
  begin
    dp_rst    <= '1';
    baud_cnt  <= '0';
    shift_cnt <= '0';
    shift_en  <= '0';
    load_en   <= '0';
    read_en   <= '1';
    txready   <= '1';
      case (state) is
        when RESET =>
          dp_rst   <= '0';

        when IDLE =>
          shift_en <= '1';
        when LOAD =>
          load_en <= '1';
        when TRANSMIT =>
          shift_en  <= '1';
          shift_cnt <= '1';
          txready   <= '0';
        when BUSY =>
          baud_cnt <= '1';
          txready <= '0';
      end case;
  end process;

end architecture;
