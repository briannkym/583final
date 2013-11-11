library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity VGA is
Port(
Clock_24: in std_logic_vector(1 downto 0);
VGA_HS, VGA_VS: out std_logic;
VGA_R, VGA_G, VGA_B: out std_logic_vector(3 downto 0);
Key: in std_logic_vector(3 downto 0);
SW: in std_logic_vector(1 downto 0);

--Things specific to the game
paddle_x : in integer range 0 to 640; 
ball_x : in integer range 0 to 640;  
ball_y : in integer range 0 to 480;
bricks : in std_logic_vector(128 downto 0); 
draw_mode : in std_logic_vector(3 downto 0)
);
end VGA;

Architecture structural of VGA is

signal r, g, b : std_logic_vector(3 downto 0);
signal x,y : std_logic_vector(11 downto 0);


Component Sync is
Port(
clk: in std_logic;
R_in, G_in, B_in : in std_logic_vector(3 downto 0);
X, Y : out std_logic_vector(11 downto 0);
HSync, VSync: out std_logic;
R, G, B : out std_logic_vector(3 downto 0)
);
End Component Sync;


Component BreakRaster is
Port(
x_pos: in integer range 0 to 800;
y_pos: in integer range 0 to 525;
paddle_x : in integer range 0 to 640; --This will change based off the paddle's width.
ball_x : in integer range 0 to 640;  --These values will also change based off of the balls acceptable space
ball_y : in integer range 0 to 480;
bricks : in std_logic_vector(128 downto 0); -- For now this will be the map of accpeptable brick coordinates. May change.
draw_mode : in std_logic_vector(3 downto 0); -- We may wish to draw things multiple ways...
R, G, B : out std_logic_vector(3 downto 0)
);
End Component BreakRaster;



begin

Sync_Imp: Sync
port map(
clk => Clock_24(0),
R_in => r,
G_in => g,
B_in => b,
X => x,
Y => y,
HSync => VGA_HS,
VSync => VGA_VS,
R => VGA_R,
G => VGA_G,
B => VGA_B,
);

BreakRaster_Imp : BreakRaster
port map(
x_pos => x,
y_pos => y,
paddle_x => paddle; 
ball_x => ball_x;  
ball_y => ball_y;
bricks => bricks; 
draw_mode => draw_mode; 
R => r, 
G => g, 
B => b,
);


end structural;
