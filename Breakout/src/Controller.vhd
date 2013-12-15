
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;


entity controller is
  port( clock           : in std_logic; 
        reset           : in std_logic;
        scan_ready      : in std_logic;
        scan_code       : in std_logic_vector(7 downto 0);
        LEDs            : out std_logic_vector(2 downto 0);
        control_en      : out std_logic;
        control_mode    : out std_logic;
        control_signal	: out control_signal_out);
end controller;

architecture behavioral of controller is

type controller_status is (wait_start_scan,wait_scan_arrow, wait_akn,
                           wait_akn_arrow, release);  -- state of the FSM
signal current_state : controller_status;
signal next_state    : controller_status;

signal scan_code_reg : std_logic_vector(7 downto 0);  -- register for the
                                                     -- incoming scan_code


signal out_reg : control_signal_out;    -- register for the
                                        -- outgoing control_signal

signal LEDs_reg : std_logic_vector(2 downto 0) ;

begin                                   
  -------------------------------------------------------------------------------
  -- Process for updating FSM states
  -------------------------------------------------------------------------------  
  Update_FSM:process (reset, clock)
  begin  -- process
    if reset='0' then
      current_state <= wait_start_scan;      
    elsif(rising_edge(clock)) then
      current_state <= next_state;
          
    end if;
  end process;

  
  -----------------------------------------------------------------------------
  -- Process that generate the right contrl_out signal depending on the scan code 
  -----------------------------------------------------------------------------
  control: process (clock, reset,scan_ready)
  begin  -- process control
    if reset = '0' then
      LEDs_reg <= "000";       
      control_en    <= '0';
      scan_code_reg <= (others => '0');
      next_state    <= wait_start_scan; 
      out_reg       <= none;
      control_mode  <= '0';
    elsif(rising_edge(clock)) then
      case (current_state) is
        when  wait_start_scan =>        -- wait for a scan_code and when ready
                                        -- sample the entry
                 
          if scan_ready = '1'then
            scan_code_reg <= scan_code;
            case (scan_code) is
              when   x"29" =>            -- space
                out_reg     <= pause;
                LEDs_reg <= LEDs_reg + 1;
                next_state  <= wait_akn;

              when   x"76" =>            -- ESC
                out_reg     <= end_game;
                next_state  <= wait_akn;

              when   x"5A" =>            -- Enter
                out_reg     <= launch;
                next_state  <= wait_akn;

              when   x"E0"=>          -- arrow
               next_state <= wait_scan_arrow;
                           
              when others =>
                null;
                             
            end case;
          end if;
                         
        when wait_akn =>                   -- wait for the acknowledgement or
                                           -- repeate of control signals 
             
          if scan_ready = '1' then
           
            if scan_code = scan_code_reg then 
              next_state <= wait_akn;
            elsif scan_code = x"F0"  then
              control_mode <= '1';
              next_state  <= release;
            else
              control_mode <= '0';
              next_state  <= wait_start_scan;
            end if;
          end if;

        when wait_scan_arrow =>         -- wait for the scan code 
                                        -- of arrows signals 

          if scan_ready = '1'  then
            scan_code_reg <= scan_code;
            next_state    <= wait_akn_arrow;
       
            case (scan_code) is
              when   x"75"=>          -- arrow up
                control_en <= '1';
                out_reg    <= go_up;
              when   x"72"=>          -- arrow down
                control_en <= '1';
                out_reg    <= go_down;
              when   x"6B"=>          -- arrow left
                control_en <= '1';
                out_reg    <= go_left;
              when   x"74"=>          -- arrow right
                control_en <= '1';
                out_reg    <= go_right;
              when others =>
                next_state    <= wait_start_scan;       
            end case;
          end if;
          
        when wait_akn_arrow =>          -- wait for the aknowledgement or
                                        -- repeate of
                                        -- arrows signals 
          if scan_ready = '1' then
            if scan_code = scan_code_reg then 
       
              next_state <= wait_akn_arrow;
            elsif scan_code = x"E0" then
              next_state  <= wait_akn_arrow;
            elsif scan_code = x"F0" then
              control_en <= '0';
              next_state  <= release;
            else
              control_en <= '0';
              next_state  <= wait_start_scan;
            end if;
          end if;

        when release =>                 -- wait for the released key scan_code
           
          if scan_ready = '1'then
            if scan_code = scan_code_reg then
              next_state <= wait_start_scan;
              control_mode <= '0';
            end if;
          end if;
          out_reg <= none;
       
      end case;
    end if;             
  end process control;
  
  control_signal <= out_reg;
  LEDs           <= LEDs_reg;
end behavioral;
