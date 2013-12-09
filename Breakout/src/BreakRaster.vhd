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
bricks : in std_logic_vector(127 downto 0); -- For now this will be the map of acceptable brick coordinates. May change.
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
	variable vx, vy : std_logic_vector(11 downto 0);
	begin
	R <= x"0";
	G <= x"0";
	B <= x"0";
	
	if(y < 48) then
		R <= x"0";
		G <= x"0";
		B <= x"0";
	elsif(y < 64) then
		R <= "1000";
		G <= "1000";
		B <= "1000";
	elsif(y< 450) then
		if((x < 32) or (608 <= x)) then
		R <= "1000";
		G <= "1000";
		B <= "1000";
		elsif((bx <= x) and (x < bx + 8) and (by <= y) and (y < by + 6)) then
		R <= "1100";
		G <= "0000";
		B <= "0000";
		elsif((100 <= y) and (y < 148)) then
			vx := std_logic_vector(x - 32);
			vy := std_logic_vector(y - 100);
			vx := "00000" & vx(11 downto 5);
			vy := "000" & vy(11 downto 3);
			if(bricks(to_integer(unsigned(vy) * 18 + unsigned(vx))) = '1' ) then
				case vy is
					when x"000" => 
						R <= "1110";
						G <= "0000";
						B <= "0000";
					when x"001" => 
						R <= "1110";
						G <= "0110";
						B <= "0000";
					when x"002" => 
						R <= "1110";
						G <= "1110";
						B <= "0000";
					when x"003" =>
						R <= "0000";
						G <= "1110";
						B <= "0000";
					when x"004" =>
						R <= "0000";
						G <= "0000";
						B <= "1100";
					when x"005" => 
						R <= "1000";
						G <= "0000";
						B <= "1100";
					when others => 
						R <= "1110";
						G <= "1110";
						B <= "1100";
				end case;
			end if;
		end if;
	elsif(y < 456) then
		if((x < 32) or (608 <= x))then
		R <= "0000";
		G <= "1000";
		B <= "1000";
		elsif ((px <= x) and (x < px + 48)) then
		R <= "1100";
		G <= "0000";
		B <= "0000";
		end if;
	end if; 
	end process;

end dataflow;
