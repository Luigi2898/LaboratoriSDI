Library IEEE;
USE IEEE.Std_logic_1164.all;

entity RisingEdge_DFlipFlop_reset is
   port(
      Q : out std_logic;
      Clk :in std_logic;
      D :in  std_logic ;
      reset : in std_logic
   );
end RisingEdge_DFlipFlop_reset;

architecture Behavioral of RisingEdge_DFlipFlop_reset is
begin
 process(Clk, reset)
 begin
    if (reset = '1') then
      Q <= '0';
    elsif(clk'event and clk = '1') then
      Q <= D;
    end if;
 end process;
end Behavioral;
