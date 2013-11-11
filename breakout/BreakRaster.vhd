library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity BreakRaster is
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

end BreakRaster;

Architecture dataflow of BreakRaster is
begin
	process(x_pos, y_pos, paddle_x, ball_x, ball_y, bricks, draw_mode)
	begin
		if(x_pos > 0) then
		end if;

	end process;

end dataflow;
