library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;


entity game_logic is
  port( clock           : in std_logic; 
        reset           : in std_logic;
        control_en      : in std_logic;
        control_mode    : in std_logic;
        control_signal	: in control_signal_out;
        
--Things specific to the game
        paddle_x        : out std_logic_vector(11 downto 0); 
        ball_x          : out std_logic_vector(11 downto 0);  
        ball_y          : out std_logic_vector(11 downto 0);
        bricks          : out std_logic_vector(127 downto 0);
        lives           : out std_logic_vector(3 downto 0);
        score           : out std_logic_vector(11 downto 0);
        dead            : out std_logic;
        draw_mode       : out std_logic_vector(3 downto 0));

end game_logic;

architecture behavioral of game_logic is

-- Create a clock that will update game objects at a speed perceivable by human eye
-- AKA a clock that is not too fast, but not too slow.
-- 50Mhz clock counter.
signal clk50MhzCounter : unsigned(19 downto 0);
-- 50hz clock output.
signal clk50hz : std_logic;

--Registers for all important game objects.
signal paddle_x_reg, ball_x_reg, ball_y_reg : unsigned(11 downto 0);
signal bricks_reg : std_logic_vector(127 downto 0); 
signal draw_mode_reg : std_logic_vector(3 downto 0);
signal draw_mode_in  : std_logic_vector (3 downto 0);

--Registers for movement of game objects.
signal ball_x_dir, ball_y_dir, paddle_x_dir, paddle_moving: std_logic;
type angle is (low, med, hi);
type speed is (slow, normal, fast, faster, fastest);
--type mode is (start, play, pause, game_over);

signal mode_entry : control_signal_out;
signal angle_reg  : angle;
signal speed_reg  : speed;
signal score_reg  : std_logic_vector(11 downto 0);
signal lives_reg  : std_logic_vector(3 downto 0);
signal dead_reg   : std_logic;
signal restart    : std_logic;


begin -- game_logic
  
paddle_moving <= control_en;
--read_en       <= control_mode;
Delay: process (clock, reset)
  begin  -- process FSM
    if(reset = '0') then
		clk50hz <= '0';
		clk50MhzCounter <= (others => '0');
	elsif (rising_edge(clock)) then
		--Keep count of clock cycles, then convert to 50hz clk.
		clk50MhzCounter <= clk50MhzCounter+1;
		if(clk50MhzCounter = 500000) then
		clk50hz <= not clk50hz;
		clk50MhzCounter <= (others => '0');
	end if;
    end if;
  end process Delay;
		
In_Signals:process (reset,clk50hz)
begin  -- process
  if reset = '0' then
    paddle_x_dir <= '0';

  elsif (rising_edge(clk50hz)) then
         
    case (control_signal) is
      when  go_left=>
        paddle_x_dir   <= '0';
        
      when go_right =>
        paddle_x_dir   <= '1';
        
      when others => null;
    end case;
   
  end if;  
end process;	 
  
ModeIN_Signals:process (reset, clk50hz, control_mode)
begin  -- process
  if reset = '0' then
    draw_mode_in <= x"0";

  elsif (rising_edge(control_mode)) then
         
    case (control_signal) is
      when end_game =>
        draw_mode_in  <= x"3";
        
      when pause    =>
        if draw_mode_reg = x"1" then
          draw_mode_in  <= x"2";
        elsif draw_mode_reg = x"2" then
          draw_mode_in  <= x"1";
        end if;

      when launch   =>
        if draw_mode_reg = x"0" then
          draw_mode_in  <= x"1";
        end if;
        if draw_mode_reg = x"3" then
          draw_mode_in  <= x"0";
        end if;
        
      when others => null;
    end case;
   
  end if;  
end process;	 

Mode_Signals:process (reset, clk50hz)
begin  -- process
  if reset = '0' then
    draw_mode_reg <= x"0";

  elsif (rising_edge(clock)) then
         
    draw_mode_reg  <= draw_mode_in;
    if dead_reg = '1' then
       draw_mode_reg <= x"3";
    end if; 
       
  end if;  
end process;	 


Paddle: process (reset, clk50hz)
begin --Begin Paddle Logic
   if (reset='0') then
      paddle_x_reg 	<= x"0D8";
   
	elsif(rising_edge(clk50hz)) then
          if draw_mode_reg = x"1" then
            
          
		case speed_reg is
			when slow =>
				if (paddle_moving = '0') then
				paddle_x_reg <= paddle_x_reg;
				elsif (paddle_x_dir = '1') then 
				paddle_x_reg <= paddle_x_reg + 3;  
				else
				paddle_x_reg <= paddle_x_reg - 3;
				end if;
			when normal =>
				if (paddle_moving = '0') then
				paddle_x_reg <= paddle_x_reg;
				elsif (paddle_x_dir = '1') then 
				paddle_x_reg <= paddle_x_reg + 4;  
				else
				paddle_x_reg <= paddle_x_reg - 4;
				end if;
			when fast =>
				if (paddle_moving = '0') then
				paddle_x_reg <= paddle_x_reg;
				elsif (paddle_x_dir = '1') then 
				paddle_x_reg <= paddle_x_reg + 5;  
				else
				paddle_x_reg <= paddle_x_reg - 5;
				end if;
			when faster =>
				if (paddle_moving = '0') then
				paddle_x_reg <= paddle_x_reg;
				elsif (paddle_x_dir = '1') then 
				paddle_x_reg <= paddle_x_reg + 6;  
				else
				paddle_x_reg <= paddle_x_reg - 6;
				end if;
			when fastest =>
				if (paddle_moving = '0') then
				paddle_x_reg <= paddle_x_reg;
				elsif (paddle_x_dir = '1') then 
				paddle_x_reg <= paddle_x_reg + 7;  
				else
				paddle_x_reg <= paddle_x_reg - 7;
				end if;
		end case;
	
		case paddle_x_dir is
			when '0' =>
				if(paddle_x_reg <= SCREEN_X_BEGIN) then
					paddle_x_reg <=  to_unsigned(SCREEN_X_BEGIN, 12);
				--	paddle_x_dir<='1';
				end if;
			when '1' =>
				if(paddle_x_reg >= (SCREEN_X_END-PADDLE_WIDTH)) then
					paddle_x_reg <= to_unsigned((SCREEN_X_END-PADDLE_WIDTH), 12);
				--	paddle_x_dir<='0';
				end if;
			when others => null;
		end case; 
         
          end if;
	end if;
	 --End: Logic of the Paddle.
  end process paddle;
  
  Ball: process (reset, clk50hz)
  variable vx, vy, vxn, vyn : std_logic_vector(11 downto 0);
  variable cx, cy : signed(3 downto 0);
  variable resultx, resulty, resultxy: integer;
begin --Logic of the Ball
   if (reset='0') then
      ball_x_reg <= x"0EC";
      ball_y_reg <= x"1BA";     
      ball_x_dir <= '1';
      ball_y_dir <= '0';
      angle_reg  <= hi;
      speed_reg  <= slow;		
      bricks_reg <= x"00000FFFFFFFFFFFFFFFFFFFFFFFFFFF";
      lives_reg  <= x"3";
      score_reg  <= x"000";
      dead_reg   <= '0';
      restart    <= '0';
   elsif(rising_edge(clk50hz)) then

   if draw_mode_reg = x"1" and restart = '0' then
      case speed_reg is
			when slow =>
				case angle_reg is
					when low =>
						if (ball_x_dir = '1') then
							cx := to_signed(3, 4);
						else
							cx := to_signed(-3, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(1, 4);
						else
							cy := to_signed(-1, 4);
						end if;
					when med =>
						if (ball_x_dir = '1') then
							cx := to_signed(2, 4);
						else
							cx := to_signed(-2, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(2, 4);
						else
							cy := to_signed(-2, 4);
						end if;
					when hi =>
						if (ball_x_dir = '1') then
							cx := to_signed(1, 4);
						else
							cx := to_signed(-1, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(3, 4);
						else
							cy := to_signed(-3, 4);
						end if;
				end case;
			when normal =>
				case angle_reg is
					when low =>
						if (ball_x_dir = '1') then
							cx := to_signed(4, 4);
						else
							cx := to_signed(-4, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(2, 4);
						else
							cy := to_signed(-2, 4);
						end if;
					when med =>
						if (ball_x_dir = '1') then
								cx := to_signed(3, 4);
							else
								cx := to_signed(-3, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(3, 4);
						else
							cy := to_signed(-3, 4);
						end if;
					when hi =>
						if (ball_x_dir = '1') then
							cx := to_signed(2, 4);
						else
							cx := to_signed(-2, 4);
						end if;
						if (ball_y_dir = '1') then 
							cy := to_signed(4, 4);
						else
							cy := to_signed(-4, 4);
						end if;
				end case;
			when fast =>
				case angle_reg is
					when low =>
						if (ball_x_dir = '1') then
							cx := to_signed(5, 4);
						else
							cx := to_signed(-5, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(2, 4);
						else
							cy := to_signed(-2, 4);
						end if;
					when med =>
						if (ball_x_dir = '1') then
							cx := to_signed(4, 4);
						else
							cx := to_signed(-4, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(4, 4);
						else
							cy := to_signed(-4, 4);
						end if;
					when hi =>
						if (ball_x_dir = '1') then
							cx := to_signed(2, 4);
						else
							cx := to_signed(-2, 4);
						end if;
						if (ball_y_dir = '1') then 
							cy := to_signed(5, 4);
						else
							cy := to_signed(-5, 4);
						end if;
				end case;
			when faster =>
				case angle_reg is
					when low =>
						if (ball_x_dir = '1') then
							cx := to_signed(6, 4);
						else
							cx := to_signed(-6, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(3, 4);
						else
							cy := to_signed(-3, 4);
						end if;
					when med =>
						if (ball_x_dir = '1') then
							cx := to_signed(5, 4);
						else
							cx := to_signed(-5, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(5, 4);
						else
							cy := to_signed(-5, 4);
						end if;
					when hi =>
						if (ball_x_dir = '1') then
							cx := to_signed(3, 4);
						else
							cx := to_signed(-3, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(6, 4);
						else
							cy := to_signed(-6, 4);
						end if;
				end case;
			when fastest =>
				case angle_reg is
					when low =>
						if (ball_x_dir = '1') then
							cx := to_signed(7, 4);
						else
							cx := to_signed(-7, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(4, 4);
						else
							cy := to_signed(-4, 4);
						end if;
					when med =>
						if (ball_x_dir = '1') then
							cx := to_signed(6, 4);
						else
							cx := to_signed(-6, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(6, 4);
						else
							cy := to_signed(-6, 4);
						end if;
					when hi =>
						if (ball_x_dir = '1') then
							cx := to_signed(4, 4);
						else
							cx := to_signed(-4, 4);
						end if;
						if (ball_y_dir = '1') then
							cy := to_signed(7, 4);								
						else
							cy := to_signed(-7, 4);
						end if;
				end case;
		end case;
		
		if(cx > 0) then
		ball_x_reg <= ball_x_reg + unsigned(x"00" & std_logic_vector(cx));
		else
		ball_x_reg <= ball_x_reg + unsigned(x"FF" & std_logic_vector(cx));
		end if;
		
		if(cy > 0) then
		ball_y_reg <= ball_y_reg + unsigned(x"00" & std_logic_vector(cy));
		else
		ball_y_reg <= ball_y_reg + unsigned(x"FF" & std_logic_vector(cy));
		end if;								
		
		case ball_x_dir is
			when '1' =>
				if(ball_x_reg >= (SCREEN_X_END-BALL_WIDTH)) then
					ball_x_reg <= to_unsigned((SCREEN_X_END-BALL_WIDTH), 12);
					ball_x_dir <= '0';
				end if;
			when '0' =>
				if(ball_x_reg <= SCREEN_X_BEGIN) then
					ball_x_reg <= to_unsigned(SCREEN_X_BEGIN, 12);
					ball_x_dir <= '1';
				end if;
			when others => null;
		end case;
		
		case ball_y_dir is
			when '0' =>
				if(ball_y_reg <= SCREEN_Y_END) then
					ball_y_dir <= '1';
					ball_y_reg <= to_unsigned(SCREEN_Y_END, 12);
				end if;
			when '1' =>
				  if(ball_y_reg > (SCREEN_PADDLE_BEGIN - BALL_HEIGHT)) then
					 ball_y_reg <= to_unsigned((SCREEN_PADDLE_BEGIN - BALL_HEIGHT), 12);
					 if (ball_x_reg >= paddle_x_reg - 7 and ball_x_reg < paddle_x_reg + 4) then
						ball_x_dir <= '0';
						ball_y_dir <= '0';
						angle_reg <= low;

					 elsif (ball_x_reg >= paddle_x_reg + 36 and ball_x_reg < paddle_x_reg + 52) then
						ball_x_dir <= '1';
						ball_y_dir <= '0';
						angle_reg <= low;
						

					 elsif (ball_x_reg >= paddle_x_reg + 4 and ball_x_reg < paddle_x_reg + 12) then
						ball_x_dir <= '0';
						ball_y_dir <= '0';
						angle_reg <= med;

					 elsif (ball_x_reg >= paddle_x_reg + 29 and ball_x_reg < paddle_x_reg + 36) then
						ball_x_dir <= '1';
						ball_y_dir <= '0';
						angle_reg <= med;

					 elsif (ball_x_reg >= paddle_x_reg +12 and ball_x_reg < paddle_x_reg + 20) then
						ball_x_dir <= '0';
						ball_y_dir <= '0';
						angle_reg <= hi;

					 elsif (ball_x_reg >= paddle_x_reg +20 and ball_x_reg < paddle_x_reg + 29) then
						ball_x_dir <= '1';
						ball_y_dir <= '0';
						angle_reg <= hi;  

					 else
						if lives_reg > x"0" then
						  lives_reg <= std_logic_vector(unsigned(lives_reg)-1);
						  restart   <= '1';
						else
						  dead_reg <= '1';
						end if;
					  
						
						 end if;
			end if;
			when others => null;
		end case;
		
		--Collision Logic----------
		if ((ball_y_reg >= SCREEN_BRICK_BEGIN) and (ball_y_reg < SCREEN_BRICK_END) and 
		(ball_x_reg >= SCREEN_X_BEGIN) and (ball_x_reg < (SCREEN_X_END-BALL_WIDTH))) then
			bricks_reg <= bricks_reg;
			
			vx := std_logic_vector(ball_x_reg + BALL_WIDTH/2- SCREEN_X_BEGIN);
			vy := std_logic_vector(ball_y_reg + BALL_HEIGHT/2- SCREEN_BRICK_BEGIN);
			
			if(cx > 0) then
				vxn := std_logic_vector(ball_x_reg + BALL_WIDTH/2- SCREEN_X_BEGIN + unsigned(x"00" & std_logic_vector(cx)));
			else
				vxn := std_logic_vector(ball_x_reg + BALL_WIDTH/2- SCREEN_X_BEGIN + unsigned(x"FF" & std_logic_vector(cx)));
			end if;
			
			
			if(cy > 0) then
				vyn := std_logic_vector(ball_y_reg + BALL_HEIGHT/2- SCREEN_BRICK_BEGIN + unsigned(x"00" & std_logic_vector(cy)));
			else
				vyn := std_logic_vector(ball_y_reg + BALL_HEIGHT/2- SCREEN_BRICK_BEGIN + unsigned(x"FF" & std_logic_vector(cy)));
			end if;
			resultx := to_integer(unsigned("000" & vy(11 downto 3)) * 18 + unsigned("00000" & vxn(11 downto 5)));
			resulty := to_integer(unsigned("000" & vyn(11 downto 3)) * 18 + unsigned("00000" & vx(11 downto 5)));
			resultxy := to_integer(unsigned("000" & vyn(11 downto 3)) * 18 + unsigned("00000" & vxn(11 downto 5)));

			if(bricks_reg(resultx) = '1' or bricks_reg(resulty) = '1' or bricks_reg(resultxy) = '1' ) then
			  --change the speed of the ball depending the brick hit
			  case ("000" & vy(11 downto 3)) is
				 when x"000" =>
					speed_reg <= fastest;
				 when x"001" =>
					speed_reg <= faster;
				 when x"002" =>
					speed_reg <= fast;
				 when x"003" =>
					speed_reg <= normal;
				 when x"004" =>
					speed_reg <= slow;
             when x"005" =>
					speed_reg <= slow;
				 when others => null;
			  end case;
			  
			  
			  if score_reg (3 downto 0) = x"9" then
				 score_reg (3 downto 0) <= x"0";
				 if score_reg (7 downto 4) = x"9" then
					score_reg (7 downto 4) <= x"0";
					score_reg (11 downto 8) <= std_logic_vector(unsigned(score_reg (11 downto 8)) + 1);
				 else
					score_reg (7 downto 4) <= std_logic_vector(unsigned(score_reg (7 downto 4)) + 1);
				 end if;
			  else
				 score_reg (3 downto 0) <= std_logic_vector(unsigned(score_reg (3 downto 0)) + 1);
			  end if;

			  if(bricks_reg(resulty) = '1') then
				  ball_y_dir <= not ball_y_dir;
				  bricks_reg(resulty) <= '0';
			  else if (bricks_reg(resultx) = '1') then
				  ball_x_dir <= not ball_x_dir;
				  bricks_reg(resultx) <= '0';
			  else if (bricks_reg(resultxy) = '1') then
				  ball_x_dir <= not ball_x_dir;
				  ball_y_dir <= not ball_y_dir;
				  bricks_reg(resultxy) <= '0';
			  end if;
         end if;
		end if;
		end if;
	end if;
	 elsif restart = '1' then
		restart <= '0';
		ball_x_reg <= paddle_x_reg + 24;
		ball_y_reg <= x"1BA";     
		ball_x_dir <= '1';
		ball_y_dir <= '0';
		angle_reg  <= hi;
		speed_reg  <= slow;
	 end if;

	end if;
	 --End: Logic of the Ball.
  end process Ball;
   
  -- Begin: output registers to the signals
  paddle_x  <= std_logic_vector(paddle_x_reg);
  ball_x    <= std_logic_vector(ball_x_reg);
  ball_y    <= std_logic_vector(ball_y_reg);
  bricks    <= std_logic_vector(bricks_reg); 
  draw_mode <= std_logic_vector(draw_mode_reg);
  score     <= score_reg;
  lives     <= lives_reg;
  dead      <= dead_reg;
  -- End: output registers to the signals
end behavioral;
  
  
