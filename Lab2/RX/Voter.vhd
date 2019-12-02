library ieee;
use ieee.std_logic_1164.all;

entity voter is
  port (

  in1 : in std_logic;
  in2 : in std_logic;
  in3 : in std_logic;
  winner : out std_logic

  );
end entity;

architecture behavioural of  voter is

begin

  winner <= (in1 and in2) or (in1 and in3) or (in2 and in3);

end architecture;
