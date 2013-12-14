
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;

entity top_module is
  port (
    clk   : in std_logic;

--Keyboard signals
    PS2C  : in std_logic;
    PS2D  : in std_logic;
    LEDs  : out std_logic_vector(7 downto 0);
   
--The signals to the VGA
    Hsync: out std_logic;
    Vsync: out std_logic;
    vgaRed: out std_logic_vector(3 downto 1);
    vgaGreen: out std_logic_vector(3 downto 1);
    vgaBlue: out std_logic_vector(3 downto 2));


end top_module;

architecture top_level of top_module is

  component kbd
    port (
      clock           : in std_logic; 
      reset           : in std_logic;
      keyboard_clk    : in std_logic;
      keyboard_data   : in std_logic;
      scan_code	      : out std_logic_vector(7 downto 0);
      scan_ready      : out std_logic;
      LEDs            : out std_logic_vector(2 downto 0));
    
  end component;

  component controller
    port(
      clock           : in std_logic; 
      reset           : in std_logic;
      scan_ready      : in std_logic;
      scan_code       : in std_logic_vector(7 downto 0);
      LEDs            : out std_logic_vector(2 downto 0);
      control_en      : out std_logic;
      control_mode    : out std_logic;
      control_signal  : out control_signal_out);
    
  end component;

  component game_logic 
    port(
      clock           : in std_logic; 
      reset           : in std_logic;
      control_en      : in std_logic;
      control_mode    : in std_logic;
      control_signal  : in control_signal_out;
        
--Things specific to the game
      paddle_x        : out std_logic_vector(11 downto 0); 
      ball_x          : out std_logic_vector(11 downto 0);  
      ball_y          : out std_logic_vector(11 downto 0);
      bricks          : out std_logic_vector(127 downto 0);
      lives           : out std_logic_vector(3 downto 0);
      score           : out std_logic_vector(11 downto 0);
      dead            : out std_logic;
      draw_mode       : out std_logic_vector(3 downto 0));

  end component;

  
  Component VGA is
    Port(
--The Clock
      clk       : in std_logic; 
      rst       : in std_logic;

--The signals to the VGA
      Hsync     : out std_logic;
      Vsync     : out std_logic;
      vgaRed    : out std_logic_vector(3 downto 1);
      vgaGreen  : out std_logic_vector(3 downto 1);
      vgaBlue   : out std_logic_vector(3 downto 2);


--Things specific to the game
      paddle_x  : in std_logic_vector(11 downto 0); 
      ball_x    : in std_logic_vector(11 downto 0);  
      ball_y    : in std_logic_vector(11 downto 0);
      bricks    : in std_logic_vector(127 downto 0);
      lives     : in std_logic_vector(3 downto 0);
      score     : in std_logic_vector(11 downto 0);
      draw_mode : in std_logic_vector(3 downto 0)
      );
  End Component VGA;


  Component DCM
    Port(
      CLKIN_IN   : IN std_logic;
      RST_IN     : IN std_logic;          
      CLKDV_OUT  : OUT std_logic;
      CLK0_OUT   : OUT std_logic;
      LOCKED_OUT : OUT std_logic);
  end Component;

  --signals declaration
 signal reset: std_logic :='1';
 signal count: unsigned(7 downto 0) := (others => '0'); 
 
--Keyboard signals
 signal scan_ready      : std_logic;
 signal scan_code       : std_logic_vector(7 downto 0);

--Controller signals
 signal control_en      : std_logic;
 signal control_signal  : control_signal_out;
 signal control_mode    : std_logic; 
--BreakRaster signals
 signal paddle_x        : std_logic_vector(11 downto 0); 
 signal ball_x          : std_logic_vector(11 downto 0);  
 signal ball_y          : std_logic_vector(11 downto 0);
 signal bricks          : std_logic_vector(127 downto 0); 
 signal lives           : std_logic_vector(3 downto 0);
 signal score           : std_logic_vector(11 downto 0);
 signal draw_mode       : std_logic_vector(3 downto 0);

 signal lock            : std_logic;
 signal clk25mhz        : std_logic;
 signal clk50mhz        : std_logic;
 signal clkdv           : std_logic;
--Game logic signal
 signal dead            : std_logic;

begin  -- top_level

 keyboard : kbd port map (
    clock         => clk,
    reset         => not reset, 
    keyboard_clk  => PS2C,
    keyboard_data => PS2D,
    scan_code     => scan_code,
    scan_ready    => scan_ready,
    LEDs          => LEDs (2 downto 0));


   control : Controller port map (
    clock         => clk,
    reset         => not reset, 
    scan_ready    => scan_ready, 
    scan_code     => scan_code,
    LEDs(0)       => LEDs (3),
    LEDs(1)       => LEDs (4),
    LEDs(2)       => LEDs (6),
    control_en    => control_en,
    control_mode  => control_mode,
    control_signal=> control_signal);

 game_log : game_logic port map (
    clock          => clk,
    reset          => not reset,
    control_en     => control_en,
    control_mode   => control_mode,
    control_signal => control_signal,
        
--Things specific to the game
    paddle_x       => paddle_x,
    ball_x         => ball_x,
    ball_y         => ball_y,
    bricks         => bricks,
    lives          => lives,
    score          => score,
    dead           => dead,
    draw_mode      => draw_mode);
 
 --The 25mhz clock is only working properly when lock is 1. 
clk25mhz <= clkdv when lock='1' else '0';

 VGA_impl: VGA port map(
--The Clock
   clk       => clk25mhz, 
   rst       => reset,

--The signals to the VGA
   Hsync     => Hsync,
   Vsync     => Vsync,
   vgaRed    => vgaRed,
   vgaGreen  => vgaGreen,
   vgaBlue   => vgaBlue,

--Things specific to the game
   paddle_x  => paddle_x,
   ball_x    => ball_x,
   ball_y    => ball_y,
   bricks    => bricks,
   lives     => lives,
   score     => score,
   draw_mode => draw_mode);


 Inst_DCM: DCM PORT MAP(
   CLKIN_IN   => clk,
   RST_IN     => '0',
   CLKDV_OUT  => clkdv ,
   CLK0_OUT   => clk50mhz,
   LOCKED_OUT => lock);
 
 
 
 ToggleReset: process(clk)
 begin
 if(rising_edge(clk)) then
   if reset = '1' then
     count <= count +1;
     if(count = 100) then
       reset <='0';
     end if;
   elsif dead = '1' then
     count <= (others => '0');
	  reset <='1';
   end if;
  
 end if;
 
 end process ToggleReset;


end top_level;
  

