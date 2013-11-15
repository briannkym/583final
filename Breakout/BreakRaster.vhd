library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity BreakRaster is
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

end BreakRaster;

Architecture dataflow of BreakRaster is

signal x,y,px,bx,by : unsigned(11 downto 0);


begin

x<= unsigned(x_pos);
y<= unsigned(y_pos);
px<= unsigned(paddle_x);
bx<= unsigned(ball_x);
by<= unsigned(ball_y);

	process(x, y, px, bx, by, bricks, draw_mode)
	begin
	
	if((x > 25) and (x < 30) and (y >=0) and (y < 50))then
		R <= x"F";
		G <= x"0";
		B <= x"F";
	else
		R <= x"0";
		G <= x"F";
		B <= x"F";
	end if;
	
	end process;

end dataflow;
