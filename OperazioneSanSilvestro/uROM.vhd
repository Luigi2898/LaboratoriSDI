library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity uROM is
  port (
    address : in std_logic_vector(3 downto 0); --cod. connessioni _ moltipicazione _ ROM rounding _ reset
    data    : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioural of uROM is

  type mem is array (0 to 12) of std_logic_vector(6 downto 0);
  constant rom : mem :=(
  "0000000",
  "0001101",
  "0010001",
  "0011101",
  "0100001",
  "0101001",
  "0110001",
  "0111001",
  "1000001",
  "1001011",
  "1010011",
  "1011011",
  "1110011"
  );

begin

  data <= rom(to_integer(unsigned(address)));

--  uROM : process(clk)
--  begin
--    if (clk'event and clk = '1') then
--      if (chip_s = '1') then
--        case (address) is

--          when "0000"   => data <= address & '0' & '0' & '0';
--          when "0001"   => data <= address & '1' & '0' & '1';
--          when "0010"   => data <= address & '0' & '0' & '1';
--          when "0011"   => data <= address & '1' & '0' & '1';
--          when "0100"   => data <= address & '0' & '0' & '1';
--          when "0110"   => data <= address & '0' & '0' & '1';
--          when "0101"   => data <= address & '0' & '0' & '1';
--          when "0111"   => data <= address & '0' & '0' & '1';
--          when "1000"   => data <= address & '0' & '0' & '1';
--          when "1001"   => data <= address & '0' & '1' & '1';
--          when "1010"   => data <= address & '0' & '1' & '1';
--          when "1011"   => data <= address & '0' & '1' & '1';
--          when "1100"   => data <= address & '0' & '1' & '1';
--          when others => data <= (others => '0');

--        end case;
--      end if;
--    end if;
--  end process;

end architecture;
