
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;

entity kbd_top is
  port (
    clk   : in std_logic;
    PS2C  : in std_logic;
    PS2D  : in std_logic;
    LEDs  : out std_logic_vector(7 downto 0));
end kbd_top;

architecture top_level of kbd_top is


  
  component kbd
    port (clock           : in std_logic; 
          reset           : in std_logic;
          keyboard_clk    : in std_logic;
          keyboard_data   : in std_logic;
          scan_code	  : out std_logic_vector(7 downto 0);
          scan_ready      : out std_logic;
          LEDs            : out std_logic_vector(2 downto 0));
    
  end component;

  component controller
    port( clock           : in std_logic; 
          reset           : in std_logic;
          scan_ready      : in std_logic;
          scan_code       : in std_logic_vector(7 downto 0);
          LEDs            : out std_logic_vector(2 downto 0);
          control_en      : out std_logic;
          control_signal  : out control_signal_out);
    
  end component;

 
 --signals declaration
 
 signal reset           : std_logic;
 signal scan_ready      : std_logic;
 signal scan_code       : std_logic_vector(7 downto 0);
 signal control_signal  : control_signal_out;
 
begin  -- top_level
 reset    <= '1', '0' after 25 ns, '1' after 75 ns;

 keyboard : kbd port map (
    clock         => clk,
    reset         => reset, 
    keyboard_clk  => PS2C,
    keyboard_data => PS2D,
    scan_code     => scan_code,
    scan_ready    => scan_ready,
    LEDs          => LEDs (2 downto 0));


   control : Controller port map (
    clock         => clk,
    reset         => reset, 
    scan_ready    => scan_ready, 
    scan_code     => scan_code,
    LEDs(0)       => LEDs (3),
    LEDs(1)       => LEDs (4),
    LEDs(2)       => LEDs (6),
  --  LEDs          => LEDs (5 downto 3),
  --  LEDs          => LEDs (5 downto 3),
   -- LEDs          => LEDs (5 downto 3),    
    control_en    => LEDs (7),
    control_signal=> control_signal);
 
end top_level;
  

