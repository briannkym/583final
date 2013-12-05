
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
        
package breakout_config is

  type control_signal_out is (go_up, go_down, go_left, go_right, pause, end_game, launch, none);

end breakout_config;
