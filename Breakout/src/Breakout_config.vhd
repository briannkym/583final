
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
        
package breakout_config is

  type control_signal_out is (go_up, go_down, go_left, go_right, pause, end_game, launch, none);
  constant SCREEN_Y_BEGIN : integer := 64;
  constant SCREEN_Y_END : integer := 80;

  constant SCREEN_BRICK_BEGIN : integer := 116;
  constant SCREEN_BRICK_END : integer := 164;

  constant PADDLE_WIDTH : integer := 48;

  constant BALL_WIDTH : integer := 8;
  constant BALL_HEIGHT : integer := 6;

  constant SCREEN_PADDLE_BEGIN : integer := 450;
  constant SCREEN_PADDLE_END : integer := 456;

  constant SCREEN_X_BEGIN : integer := 32;
  constant SCREEN_X_END : integer := 608;

end breakout_config;
