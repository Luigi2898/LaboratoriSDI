library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity testbench_delay is
end entity;

architecture beh of testbench_delay is

  COMPONENT compute_delay is
      port (clk : in std_logic;
        rst   : in std_logic;
        DELAY_OUT : BUFFER SIGNED(11 DOWNTO 0);
        MSB   : OUT STD_LOGIC;
        PEAK1 : IN STD_LOGIC;
        PEAK2 : IN STD_LOGIC;
        RESTART : OUT STD_LOGIC;
        SIMULTANEOUS : buffer STD_LOGIC;
        DONE : OUT STD_LOGIC
  );
  end COMPONENT;

SIGNAL DELAY_OUT : SIGNED(11 DOWNTO 0);
SIGNAL clk, rst ,MSB, RESTART, SIMULTANEOUS, DONE : STD_LOGIC;
signal PEAK1, PEAK2 : std_logic := '0';
begin

  RST_PROCESS : PROCESS
  BEGIN
  	RST <= '0';
  	WAIT FOR 90 NS;
  	RST <= '1';
  	wait for 20 sec;
  END PROCESS;

  clock : process
  	begin

  		clk <= '1';
  		wait for 500 ns;
  		clk <= '0';
  		wait for 500 ns;

  	end process;

    PEAK2_P : process
    begin
    WAIT FOR 10 us;
    PEAK2 <= '1';
    wait for 1 us;
    PEAK2 <= '0';
    wait;
    END PROCESS;

    PEAK1_P : process
    begin
    WAIT FOR 20 us;
    PEAK1 <= '1';
    wait for 1 us;
    PEAK1 <= '0';
    wait;
    END PROCESS;

TEST:  compute_delay PORT MAP(CLK, RST, DELAY_OUT, msb, PEAK1, PEAK2, restart, SIMULTANEOUS, done);



end architecture;
