library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity uROM is
  port (
    clk     : in std_logic;
    address : in std_logic_vector(3 downto 0); --cod. connessioni _ moltipicazione _ ROM rounding _ reset
    chip_s  : in std_logic;
    data    : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioural of uROM is

begin

  uROM : process(clk)
  begin
    if (clk'event and clk = '1')
      if (chip_s = '1') then
        case( address ) is

          when '0000' => data <= address & '0' & '0' & '0';
          when '0001' => data <= address & '1' & '0' & '1';
          when '0010' => data <= address & '0' & '0' & '1';
          when '0011' => data <= address & '1' & '0' & '1';
          when '0100' => data <= address & '0' & '0' & '1';
          when '0110' => data <= address & '0' & '0' & '1';
          when '0101' => data <= address & '0' & '0' & '1';
          when '0111' => data <= address & '0' & '0' & '1';
          when '1000' => data <= address & '0' & '0' & '1';
          when '1001' => data <= address & '0' & '1' & '1';
          when '1010' => data <= address & '0' & '1' & '1';
          when '1011' => data <= address & '0' & '1' & '1';
          when '1100' => data <= address & '0' & '1' & '1';
          when others => data <= (others <= '0');

        end case;
      end if;
    end if;
  end process;

end architecture;
