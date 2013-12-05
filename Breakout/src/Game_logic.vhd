
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;


entity game_logic is
  port( clock           : in std_logic; 
        reset           : in std_logic;
        control_en      : in std_logic;
        control_signal	: in control_signal_out;
        
--Things specific to the game
        paddle_x        : out std_logic_vector(11 downto 0); 
        ball_x          : out std_logic_vector(11 downto 0);  
        ball_y          : out std_logic_vector(11 downto 0);
        bricks          : out std_logic_vector(127 downto 0); 
        draw_mode       : out std_logic_vector(3 downto 0));

end game_logic;

architecture behavioral of game_logic is
signal paddle_x_reg : std_logic_vector(11 downto 0);
begin

  FSM: process (reset,control_en)
  begin  -- process FSM
    if reset='0' then
      paddle_x_reg <= "000000111111";
      ball_x       <= "000000111111";
      ball_y       <= "000011111111";
      bricks       <= x"FFFFFFFFEEEEEEEECCCCCCCC11111111";
      draw_mode <= (others => '0');
    elsif(rising_edge(control_en)) then
      if control_signal = go_left then
        paddle_x_reg <= paddle_x_reg +1; 
      end if;
      
    end if;
  end process FSM;
  paddle_x <= paddle_x_reg;
end behavioral;
  
  
