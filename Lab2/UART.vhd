library ieee;
use ieee.std_logic_vector.all;

entity UART is
  
  port(
    data_in  : in std_logic_vector (7 downto 0);
    tx       : out std_logic;
    tx_ready : out std_logic;
    wr       : in std_logic;
    
    data_out : out std_logic_vector (7 downto 0);
    rx       : in std_logic;
    rd       : in std_logic;
    dav      : out std_logic;
    
    clock    : in std_logic;
    resetN   : in std_logic
    );
  
end entity;
 
architecture Behavioural of UART is
   
  begin
  
end architecture;
