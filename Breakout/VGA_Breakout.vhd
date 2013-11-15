library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity VGA is
Port(
B8: in std_logic; --The Clock
T4, U3: out std_logic; --Horizontal Sync and Vertical Sync
R9, T8, R8, N8, P8, P6, U5, U4: out std_logic; --RGB pins

--Things specific to the game
paddle_x : in std_logic_vector(11 downto 0); 
ball_x : in std_logic_vector(11 downto 0);  
ball_y : in std_logic_vector(11 downto 0);
bricks : in std_logic_vector(128 downto 0); 
draw_mode : in std_logic_vector(3 downto 0)
);
end VGA;

Architecture structural of VGA is

signal r, g, b : std_logic_vector(3 downto 0);
signal VGA_R, VGA_G, VGA_B : std_logic_vector(3 downto 0);

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
x_pos: in std_logic_vector(11 downto 0);
y_pos: in std_logic_vector(11 downto 0);
paddle_x : in std_logic_vector(11 downto 0); --This will change based off the paddle's width.
ball_x : in std_logic_vector(11 downto 0);  --These values will also change based off of the balls acceptable space
ball_y : in std_logic_vector(11 downto 0);
bricks : in std_logic_vector(128 downto 0); -- For now this will be the map of accpeptable brick coordinates. May change.
draw_mode : in std_logic_vector(3 downto 0); -- We may wish to draw things multiple ways...
R, G, B : out std_logic_vector(3 downto 0)
);
End Component BreakRaster;



begin

R9<=VGA_R(3);
T8<=VGA_R(2);
R8<=VGA_R(1);
N8<=VGA_G(3);
P8<=VGA_G(2);
P6<=VGA_G(1);
U5<=VGA_B(3);
U4<=VGA_B(2);

Sync_Imp: Sync
port map(
clk => B8,
R_in => r,
G_in => g,
B_in => b,
X => x,
Y => y,
HSync => T4,
VSync => U3,
R => VGA_R,
G => VGA_G,
B => VGA_B
);

BreakRaster_Imp : BreakRaster
port map(
x_pos => x,
y_pos => y,
paddle_x => paddle_x,
ball_x => ball_x,
ball_y => ball_y,
bricks => bricks, 
draw_mode => draw_mode, 
R => r, 
G => g, 
B => b
);


end structural;
