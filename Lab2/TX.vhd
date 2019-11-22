library ieee;
use ieee.std_logic_1164.all;

entity TX is
  port (
      clock : in std_logic;
      data : in std_logic_vector(7 downto 0);
      wr : in std_logic;
      txrdy : out std_logic;
      reset : in std_logic;
      tx : out std_logic
  );
end entity;

architecture beh of TX is


  component serial2parallel is
    port (clock      : in std_logic;
          paralleld  : in std_logic_vector(7 downto 0);
          seriald    : out std_logic;
          input_en   : in std_logic;
          rst    : in std_logic
    );
  end component;

  component TXCU is
      port (
      clock : in std_logic;
      reset : in std_logic;
      wr    : in std_logic;
      txrdy : out std_logic;
      reg_rst : out std_logic;
      input_en   : out std_logic
      );
  end component;

  signal txout : std_logic;
  signal reg_rst : std_logic;
  signal input_en : std_logic;

begin

    cu : TXCU port map(clock, reset, wr, txrdy, reg_rst, input_en);

    ser2par : serial2parallel port map(clock, data, tx, input_en, reg_rst);


end architecture;
