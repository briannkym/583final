
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity kbd is
  port( clock           : in std_logic;
        reset           : in std_logic;
        keyboard_clk    : in std_logic;
        keyboard_data   : in std_logic;
        scan_code	: out std_logic_vector(7 downto 0);
        scan_ready	: out std_logic;
        LEDs            : out std_logic_vector (2 downto 0));
end kbd;

architecture behavioral of kbd is

type receiver_status is (wait_start, start, parity, check);  -- Control & data flow for the receiver
signal next_state    : receiver_status;
signal current_state : receiver_status;

signal bit_index     : integer range 0 to 8;          -- counter for the shift register
signal one_counter   : integer ;                      -- counter for the erro checking
signal sum           : integer;                       -- parity checking
signal scan_code_reg : std_logic_vector (7 downto 0); -- Register that hold the
                                                      -- byte sent
signal scan_flag      : std_logic;                    -- signals for scan_ready process
signal scan_ready_reg : std_logic;
signal scan_counter   : integer;

signal main_counter : std_logic_vector(2 downto 0);

begin                                   

-------------------------------------------------------------------------------
-- FSM for updating the next state of the control FSM and generating the
-- scan_ready signal
-------------------------------------------------------------------------------
  FSM: process (clock, reset,next_state, scan_flag)
  begin  -- process FSM
    if reset='0' then
      scan_ready_reg    <= '0';
      current_state <= wait_start;
      scan_counter <= 0;
    elsif(falling_edge(clock)) then
      current_state <= next_state;
      if scan_flag = '0'  then
        scan_counter <= 0;
      else
        scan_counter <= scan_counter + 1;
      end if;
      if scan_counter = 4 then
        scan_ready_reg <= '1';
      else
        scan_ready_reg <= '0';
      end if;
    end if;
  end process FSM;
 
-------------------------------------------------------------------------------
-- FSM for sampling data received from the keyboard
-- inputs : keyboard_clk, reset
-- outputs: scan_flag, scan_code_reg and main_counter (debug)
-------------------------------------------------------------------------------

 
  
  control: process (keyboard_clk, reset)
  begin  -- process control
    if reset = '0' then
      scan_flag <= '0';
      scan_code_reg <= (others => '0');
      bit_index     <= 0;
      one_counter   <= 0;
      sum           <= 0;
      main_counter  <= "000";
    else
      
      if(falling_edge(keyboard_clk)) then
        one_counter <= one_counter;
        case (current_state) is
          when  wait_start =>             --detect the start bit
            scan_flag <= '0';
            if (keyboard_data = '0') then
            
              next_state <= start;
            end if;
          when start =>                   --sampling data
           
            if (keyboard_data = '1') then
              one_counter <= one_counter + 1;
            end if;
            
            if (bit_index = 7) then
                
              bit_index <= 0;
              next_state <= parity;
            else  
              bit_index <= bit_index + 1;
            end if;
            scan_code_reg (6 downto 0) <= scan_code_reg (7 downto 1);
            scan_code_reg (7)           <= keyboard_data;
            
          when parity =>                  --getting the parity bit
          
            if (keyboard_data = '1') then
              sum           <= one_counter + 1;
            else
              sum           <= one_counter;
            end if;	
            one_counter   <= 0;
            next_state <= check;
        
          when check =>                 -- checking for stop_bit and parity
        
            if ((sum mod 2) = 1) and keyboard_data = '1' then
              scan_flag <= '1';
            end if;
            next_state <= wait_start;
            if scan_code_reg = x"F0" then
              main_counter <= main_counter + 1;
            end if;
           
          when others => null;
            
        end case;    
        
      end if;
    end if;
  end process control;
  scan_ready <= scan_ready_reg;             
  scan_code  <= scan_code_reg;
  LEDs       <= main_counter;
end behavioral;
