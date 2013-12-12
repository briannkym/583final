library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


use work.breakout_config.all;

Entity BreakRaster is
Port(

x_pos       : in std_logic_vector(11 downto 0);
y_pos       : in std_logic_vector(11 downto 0);
paddle_x    : in std_logic_vector(11 downto 0); --This will change based off the paddle's width.
ball_x      : in std_logic_vector(11 downto 0);  --These values will also change based off of the balls acceptable space
ball_y      : in std_logic_vector(11 downto 0);
bricks      : in std_logic_vector(127 downto 0); -- For now this will be the map of acceptable brick coordinates. May change.
score       : in std_logic_vector(11 downto 0);
lives       : in std_logic_vector(3 downto 0);
draw_mode   : in std_logic_vector(3 downto 0); -- We may wish to draw things multiple ways...
R, G, B     : out std_logic_vector(3 downto 0)
);

end BreakRaster;

Architecture dataflow of BreakRaster is

component Digit is
port(
rainbow : in std_logic;
number : in std_logic_vector(3 downto 0);
x : in std_logic_vector(2 downto 0);
y : in std_logic_vector(2 downto 0);
R : out std_logic_vector(3 downto 0);
G : out std_logic_vector(3 downto 0);
B : out std_logic_vector(3 downto 0));
end component;

component Char is
port(
rainbow : in std_logic;
charnum : in std_logic_vector(7 downto 0);
x : in std_logic_vector(2 downto 0);
y : in std_logic_vector(2 downto 0);
R : out std_logic_vector(3 downto 0);
G : out std_logic_vector(3 downto 0);
B : out std_logic_vector(3 downto 0));
end component;


signal x,y,px,bx,by : unsigned(11 downto 0);

signal xSymbol, ySymbol: std_logic_vector(2 downto 0);
signal rSymbol, gSymbol, bSymbol, number,
rLetter, gLetter, bLetter : std_logic_vector(3 downto 0);
signal letter: std_logic_vector(7 downto 0);
signal rainbow: std_logic;

begin

x   <= unsigned(x_pos);
y   <= unsigned(y_pos);
px  <= unsigned(paddle_x);
bx  <= unsigned(ball_x);
by  <= unsigned(ball_y);

xSymbol <= std_logic_vector(x(5 downto 3));
ySymbol <= std_logic_vector(y(2 downto 0));

		digit_impl : Digit port map (	 
		rainbow => '1',
		number => number,
		x => xSymbol,
		y => ySymbol,
		R => rSymbol,
		G => gSymbol,
		B => BSymbol);
	
		char_impl : Char port map (	 
		rainbow => rainbow,
		charnum => letter,
		x => xSymbol,
		y => ySymbol,
		R => rLetter,
		G => gLetter,
		B => BLetter);
		
	process(x, y, px, bx, by, bricks, draw_mode)
	variable vx, vy : std_logic_vector(11 downto 0);
	begin
	R <= x"0";
	G <= x"0";
	B <= x"0";
	
	if(y < SCREEN_Y_BEGIN) then
		if(x < 64) then
			number <= score(11 downto 8);			
			R <= rSymbol;
			G <= gSymbol;
			B <= bSymbol;
		elsif (x < 128) then
			number <= score(7 downto 4);
			R <= rSymbol;
			G <= gSymbol;
			B <= bSymbol;
		elsif (x < 192) then
			number <= score(3 downto 0);
			R <= rSymbol;
			G <= gSymbol;
			B <= bSymbol;
		elsif(576<=x) then
			number <= lives;
			R <= rSymbol;
			G <= gSymbol;
			B <= bSymbol;
		end if;
	elsif(y < SCREEN_Y_END) then
		R <= "1000";
		G <= "1000";
		B <= "1000";
	elsif(y< SCREEN_PADDLE_BEGIN) then
		if((x < SCREEN_X_BEGIN) or (SCREEN_X_END <= x)) then
		R <= "1000";
		G <= "1000";
		B <= "1000";
		elsif((bx <= x) and (x < bx + BALL_WIDTH) and (by <= y) and (y < by + BALL_HEIGHT)) then
		R <= "1100";
		G <= "0000";
		B <= "0000";
		elsif((SCREEN_BRICK_BEGIN <= y) and (y < SCREEN_BRICK_END)) then
			vx := std_logic_vector(x - SCREEN_X_BEGIN);
			vy := std_logic_vector(y - SCREEN_BRICK_BEGIN);
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
	elsif(y < SCREEN_PADDLE_END) then
		if((x < SCREEN_X_BEGIN) or (SCREEN_X_END <= x))then
		R <= "0000";
		G <= "1000";
		B <= "1000";
		elsif ((px <= x) and (x < px + PADDLE_WIDTH)) then
		R <= "1100";
		G <= "0000";
		B <= "0000";
		end if;
	end if; 
	end process;

end dataflow;
