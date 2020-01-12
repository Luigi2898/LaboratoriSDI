library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
	port(reg_in : in std_logic;
		 reg_out : out std_logic;
		 clk, rst : in std_logic	
	);
end entity;

architecture beh of reg is

begin
REGproc: process(clk)
begin
if(rst = '0') then
	reg_out <= '0';
     elsif(clk'event and clk = '1') then
		 reg_out <= reg_in;
end if;

end process;

end architecture;