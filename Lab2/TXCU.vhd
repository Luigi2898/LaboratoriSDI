LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity TXCU is
    port (
      clock : in std_logic;
      reset : in std_logic;
      wr    : in std_logic;
      txrdy : out std_logic;
      reg_rst : out std_logic;
      input_en   : out std_logic
    );
end entity;

architecture behavioural of TXCU is

    type STATETYPE is (ResetS, Idle, TX0, TX1, TX2, TX3, TX4, TX5, TX6, TX7);
    signal state : STATETYPE;

begin

    CU : process(clock, reset, wr)
    begin

        if(clock'event and clock = '1') then
          if(reset = '0') then
              state <= ResetS;
          else
            case( state ) is

              when ResetS =>
                  state <= Idle;

              when Idle =>
                  if wr = '0' then
                      state <= Idle;
                  else
                      state <= TX0;
                  end if;

              when TX0 =>
                  state <= TX1;

              when TX1 =>
                  state <= TX2;

              when TX2 =>
                  state <= TX3;

              when TX3 =>
                  state <= TX4;

              when TX4 =>
                  state <= TX5;

              when TX5 =>
                  state <= TX6;

              when TX6 =>
                  state <= TX7;

              when TX7 =>
                  state <= Idle;


              when others => state <= ResetS;

            end case;
          end if;
        end if;
    end process;

    outprc : process(state)
    begin
      txrdy <= '0';
      input_en <= '0';
      reg_rst <= '1';

      case state  is

       when ResetS =>
        reg_rst <= '0';


        when IDLE =>
            input_en <= '1';
            txrdy <= '1';

         when TX0 =>


         when TX1 =>


         when TX2 =>

         when TX3 =>

         when TX4 =>

         when TX5 =>

         when TX6 =>

         when TX7 =>

       end case;

    end process;

end architecture;
