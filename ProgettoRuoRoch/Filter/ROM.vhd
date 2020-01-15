library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
entity ROM is
  port (
	clk, chip_s : in std_logic;
    address : in UNSIGNED(5 downto 0); 
    data    : out signed(13 downto 0)
  );
end entity;

architecture behavioural of ROM is

  type mem is array (0 to 42) of signed(13 downto 0);
  constant rom : mem :=(
	"11111111111000",
    "00000000001110",
    "11111111101000",
    "00000000100100",
    "11111111001110",
    "00000000111111",
    "11111110110111",
    "00000001001101",
    "11111110111001",
    "00000000110100",
    "11111111101111",
    "11111111011101",
    "00000001101000",
    "11111101000001",
    "00000100100010",
    "11111001110100",
    "00000111111001",
    "11110110100001",
    "00001010111001",
    "11110100000010",
    "00001100101010",
    "01111010110100",
    "00001100101010",
    "11110100000010",
    "00001010111001",
    "11110110100001",
    "00000111111001",
    "11111001110100",
    "00000100100010",
    "11111101000001",
    "00000001101000",
    "11111111011101",
    "11111111101111",
    "00000000110100",
    "11111110111001",
    "00000001001101",
    "11111110110111",
    "00000000111111",
    "11111111001110",
    "00000000100100",
    "11111111101000",
    "00000000001110",
    "11111111111000"
  );
  
  begin
  
   process(clk)
   begin
    if (clk'event and clk = '1') then
      if (chip_s = '1') then
		 data <= rom(to_integer(unsigned(address)));
	  end if;
	end if;
   end process;
  
  
 end architecture; 