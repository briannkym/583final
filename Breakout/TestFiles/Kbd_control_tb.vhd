

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.breakout_config.all;
        
entity kbd_control_tb is
  
end kbd_control_tb;

architecture behavioral of kbd_control_tb is


  
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
          control_mode    : out std_logic;
          control_signal  : out control_signal_out);
    
  end component;

  
  --Input signals
  signal clock         : std_logic := '0';
  signal reset         : std_logic;
  signal keyboard_clk  : std_logic := '1';
  signal keyboard_data : std_logic;

  --Inbetween signals
  signal scan_code  : std_logic_vector (7 downto 0);
  signal scan_ready : std_logic;

  --Output signals
  signal LEDs           : std_logic_vector (5 downto 0);
  signal control_en     : std_logic;
  signal control_mode   : std_logic;
  signal control_signal : control_signal_out;
  
  --Sample test data
  constant BitPeriod : time := 40 us;

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

function Even (V : std_logic_vector) return std_logic is
variable p : std_logic := '0';
begin
for i in V'range loop p := p xor V(i); end loop; return p;
end function;

begin  

  keyboard : kbd port map (
    clock         => clock,
    reset         => reset, 
    keyboard_clk  => keyboard_clk,
    keyboard_data => keyboard_data,
    scan_code     => scan_code,
    scan_ready    => scan_ready,
    LEDs          => LEDs (2 downto 0));

  control : Controller port map (
    clock         => clock,
    reset         => reset, 
    scan_ready    => scan_ready, 
    scan_code     => scan_code, 
    LEDs          => LEDs (5 downto 3),
    control_en    => control_en,
    control_mode  => control_mode,
    control_signal=> control_signal);

  
clock  <= not clock after 10 ns;
reset  <= '1', '0' after 25 ns, '1' after 75 ns;

-- Keyboard sending Data to the Controller
Emit: process
procedure SendCode ( D : std_logic_vector(7 downto 0);
Err : std_logic := '0') is
begin
keyboard_clk <= '1';
keyboard_data <= '1';
-- (1) verify that Clk was Idle (high) at least for 50 us.
-- this is not coded here.
wait for (BitPeriod / 2);
-- Start bit
keyboard_data <= '0';
wait for (BitPeriod / 2);
keyboard_clk <= '0'; wait for (BitPeriod / 2);
keyboard_clk <= '1';
-- Data Bits
for i in 0 to 7 loop
keyboard_data <= D(i);
wait for (BitPeriod / 2);
keyboard_clk <= '0'; wait for (BitPeriod / 2);
keyboard_clk <= '1';
end loop;
-- Odd Parity bit
keyboard_data <= Err xor not Even (D);
wait for (BitPeriod / 2);
keyboard_clk <= '0'; wait for (BitPeriod / 2);
keyboard_clk <= '1';
-- Stop bit
keyboard_data <= '1';
wait for (BitPeriod / 2);
keyboard_clk <= '0'; wait for (BitPeriod / 2);
keyboard_clk <= '1';
keyboard_data <= '1';
wait for (BitPeriod * 3);
end procedure SendCode;

begin -- process Emit
-----
Wait for BitPeriod;
-- Send the Test Frames
for i in Kbd_data'range loop
    SendCode (Kbd_data(i),'0');
end loop;
end process Emit;

end behavioral;
