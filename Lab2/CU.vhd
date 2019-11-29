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

begin

end architecture;
