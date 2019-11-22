LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity serial2parallel is
  port (clock      : in std_logic;
        paralleld  : in std_logic_vector(7 downto 0);
        seriald    : out std_logic;
        input_en   : in std_logic;
        rst    : in std_logic
  );
end entity;

architecture behavioural of serial2parallel is

  signal reg : std_logic_vector(8 downto 0);


  begin
    michele : process(clock, rst)
    begin
    if clock'event and clock = '1' then
      if rst = '0' then
        reg <= (others => '1');
      end if;
      if input_en = '1' then
        reg <= '0' &  paralleld;
      end if;
      seriald <= reg(0);
      for i in 0 to 6 loop
        reg(i) <= reg(i+1);
      end loop;
      reg(7) <= '1';
    end if;
end process michele;

end architecture;
