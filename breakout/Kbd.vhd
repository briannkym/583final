
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

        
entity kbd is
  port( clock           : in std_logic; 
        reset           : in std_logic;
        keyboard_clk    : in std_logic;
        keyboard_data   : in std_logic;
        scan_code	: out std_logic_vector(7 downto 0);
        scan_ready	: out std_logic);
end kbd;

architecture behavioral of kbd is

type receiver_status is (wait_start, start, parity, ready);  -- Control & data flow for the receiver
signal control_state : receiver_status;
signal bit_index : unsigned;                -- counter for the shift register
signal one_counter : unsigned;              -- counter for the erro checking
signal sum : unsigned;                      -- parity checking
signal scan_code_reg : std_logic_vector (7 downto 0);  -- Register that hold the
                                                       -- byte sent
begin                                   --mixed

  -- purpose: FSM for receiving bytes from keyboard
  -- type   : combinational
  -- inputs : keyboard_clk
  -- outputs: 
  control: process (keyboard_clk)
  begin  -- process control
    if reset = '0' then
      scan_ready    <= '0';
      scan_code_reg <= (others => '0');
      control_state <= wait_start;
      bit_index     <= 0;
      one_counter   <= 0;
      sum           <= 0;
    elsif(falling_edge(keyboard_clk)) then
      case (control_state) is
        when  wait_start =>

          if (keyboard_data = '0') then
            control_state <= start;
          end if;
        when start =>
 
          if (keyboard_data = '1') then
            one_counter <= one_counter + 1;
          end if;

          if (index = 7) then
            index <= 0;
            control_state <= ready;
          else  
            index <= index + 1;
          end if;
          scan_code_reg (6 downto 0) <= scan_code_reg (7 downto 1);
          scan_code_reg (7)           <= keyboard_data;

        when parity =>
          sum           <= one_counter + keyboard_data;
          one_counter   <= 0;
          control_state <= ready;
        when ready =>
           if (sum mod 2) = 0 then
             scan_code_reg <= (others => '0');
             control_state <= wait_start;
           else
             scan_ready <= '1';
           end if;
          
        when others => null;
      end case;    

    end if;
  end process control;
  scan_code <= scan_code_reg;
end behavioral;
