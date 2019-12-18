LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ShiftRegN is
  generic(
    N : integer := 10
  );
  port (
    clock    : in std_logic;
    shift_en : in std_logic;
    load_en  : in std_logic;
    rstN     : in std_logic;
    D_in     : in std_logic_vector(N-3 downto 0);
    D_out    : out std_logic
  );
end entity;

architecture Behavioural of ShiftRegN is

  signal reg : std_logic_vector(N-1 downto 0);

begin

  Shift : process(clock)
  begin
    if (clock'event and clock = '1') then
      if (rstN = '0') then
        reg <= (others => '1');
      elsif (load_en = '1') then
          reg(N-1)         <= '1';
          reg(0)           <= '0';
          reg(N-2 downto 1) <= D_in;
        elsif (shift_en = '1') then
          D_out <= reg(0);
          for i in 0 to N-2 loop
            reg(i) <= reg(i+1);
          end loop;
        end if;
      end if;
  end process;

end architecture;
