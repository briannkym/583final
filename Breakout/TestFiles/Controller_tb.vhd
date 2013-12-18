

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;

entity controller_tb is
end controller_tb;

architecture behavioral of controller_tb is

  
 component controller
    port( clock           : in std_logic; 
          reset           : in std_logic;
          scan_ready      : in std_logic;
          scan_code       : in std_logic_vector(7 downto 0);
          LEDs            : out std_logic_vector(2 downto 0);
          control_en      : out std_logic;
          control_mode    : out std_logic;
          control_signal  : out control_signal_out);
    
  end component;

  --Input signals
  signal clock         : std_logic := '0';
  signal reset         : std_logic;
  signal scan_code     : std_logic_vector(7 downto 0);
  signal scan_ready    : std_logic := '0';

  --Output signals
  signal LEDs           : std_logic_vector (2 downto 0);
  signal control_en     : std_logic;
  signal control_mode   : std_logic;
  signal control_signal : control_signal_out;


  --Sample test data
  constant Period : time := 40 us;

  type frame_kbd_array is array (natural range <>) of std_logic_vector (7 downto 0);
 
  constant kbd_data : frame_kbd_array := (
  -----------
  -- frame 0
  -----------
  0 => "00101001", --29 ----Begin----- (space)
  -----------
  -- frame 1
  -----------
  1 => "11110000", --F0 
  -----------
  -- frame 2
  -----------
  2 => "00101001", --29 ----End ------
   -----------
  -- frame 3
  -----------
  3 => "00101001", --29 ----Begin----- (space)
   -----------
  -- frame 4
  -----------
  4 => "11110000", --F0
  -----------
  -- frame 5
  -----------
  5 => "00101001", --29 ----End------
  -----------
  -- frame 6
  -----------
  6 => "11100000", --E0 ----Begin----- (right)
   -----------
  -- frame 7
  -----------
  7 => "01110100", --74
   -----------
  -- frame 8
  -----------
  8 => "11100000", --E0
   -----------
  -- frame 9
  -----------
  9 => "11110000", --F0 
  -----------
  -- frame 10
  -----------
  10 => "01110100", --74 -----End------
  -----------
  -- frame 11
  -----------
  11 => "11100000", --E0 ----Begin----- (up)
   -----------
  -- frame 12
  -----------
  12 => "01110101", --75
   -----------
  -- frame 13
  -----------
  13 => "11100000", --E0
   -----------
  -- frame 14
  -----------
  14 => "01110101", --75 
  -----------
  -- frame 15
  -----------
  15 => "11100000", --E0 

    -----------
  -- frame 16
  -----------
  16 => "11110000", --F0 

  -----------
  -- frame 17      --75
  -----------
  17 => "01110101");



begin  

  control : Controller port map (
    clock         => clock,
    reset         => reset, 
    scan_ready    => scan_ready, 
    scan_code     => scan_code, 
    LEDs          => LEDs,
    control_en    => control_en,
    control_mode  => control_mode,
    control_signal=> control_signal);


clock  <= not clock after 10 ns;
reset  <= '1', '0' after 25 ns, '1' after 75 ns;

-- Keyboard sending Data to the Controller
Emit: process
procedure SendCode ( D : std_logic_vector(7 downto 0)) is
begin
scan_ready    <= '1';
scan_code     <=  D;
wait for 20ns;
scan_ready    <= '0';
wait for (Period * 3);

end procedure SendCode;

begin -- process Emit
-----
Wait for Period;
-- Send the Test Frames
for i in Kbd_data'range loop
    SendCode (Kbd_data(i));
end loop;
end process Emit;

end behavioral;
