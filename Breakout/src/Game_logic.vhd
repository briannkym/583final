library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library work;
use work.breakout_config.all;


entity game_logic is
  port( clock           : in std_logic; 
        reset           : in std_logic;
        control_en      : in std_logic;
        control_signal	: in control_signal_out;
        
--Things specific to the game
        paddle_x        : out std_logic_vector(11 downto 0); 
        ball_x          : out std_logic_vector(11 downto 0);  
        ball_y          : out std_logic_vector(11 downto 0);
        bricks          : out std_logic_vector(127 downto 0); 
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

--Registers for movement of game objects.
signal ball_x_dir, ball_y_dir, paddle_x_dir, paddle_moving: std_logic;
type angle is (low, med, hi);
type speed is (slow, normal, fast, faster, fastest);

signal angle_reg: angle;
signal speed_reg: speed;




begin -- game_logic
  
paddle_moving <= control_en;

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
		
		
 OtherStuff: process (reset, clk50hz) 
begin
   if (reset='0') then
      speed_reg <= slow;
      draw_mode_reg <= x"1";
	 end if;
  end process OtherStuff;
  
In_Signals:process (reset,clk50hz)
begin  -- process
  if reset = '0' then
    paddle_x_dir <= '0';
  elsif (rising_edge(clk50hz)) then
    case (control_signal) is
      when  go_left=>
        paddle_x_dir <= '0';
      when go_right =>
        paddle_x_dir <= '1';
      when others => null;
    end case;
  end if;  
end process;	 


Paddle: process (reset, clk50hz)
begin --Begin Paddle Logic
   if (reset='0') then
      paddle_x_reg 	<= x"0D8";
     -- paddle_x_dir <='1';
   --   paddle_moving <='0';
	elsif(rising_edge(clk50hz)) then
	 
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
					null;
			when fast =>
					null;
			when faster =>
					null;
			when fastest =>
					null;
		end case;
	
		case paddle_x_dir is
			when '0' =>
				if(paddle_x_reg <= 32) then
					paddle_x_reg <= x"020";
				--	paddle_x_dir<='1';
				end if;
			when '1' =>
				if(paddle_x_reg >= 560) then
					paddle_x_reg <= x"230";
				--	paddle_x_dir<='0';
				end if;
			when others => null;
		end case; 
	 
	end if;
	 --End: Logic of the Paddle.
  end process paddle;
  
  Ball: process (reset, clk50hz)
begin --Logic of the Ball
   if (reset='0') then
      ball_x_reg <= x"0EC";
      ball_y_reg <= x"1BA";
		ball_x_dir <= '1';
		ball_y_dir <= '0';
		angle_reg <= med;
	elsif(rising_edge(clk50hz)) then
		case speed_reg is
			when slow =>
				case angle_reg is
							when low =>
								if (ball_x_dir = '1') then
								ball_x_reg <= ball_x_reg + 3; else
								ball_x_reg <= ball_x_reg - 3;
								end if;
								if (ball_y_dir = '1') then
								ball_y_reg <= ball_y_reg + 1; else
								ball_y_reg <= ball_y_reg - 1;
								end if;
							when med =>
								if (ball_x_dir = '1') then
									ball_x_reg <= ball_x_reg + 2; else
									ball_x_reg <= ball_x_reg - 2;
								end if;
								if (ball_y_dir = '1') then
									ball_y_reg <= ball_y_reg + 2; else
									ball_y_reg <= ball_y_reg - 2;
								end if;
							when hi =>
								if (ball_x_dir = '1') then
								ball_x_reg <= ball_x_reg + 1; else
								ball_x_reg <= ball_x_reg - 1;
								end if;
								if (ball_y_dir = '1') then 
								ball_y_reg <= ball_y_reg + 3; else
								ball_y_reg <= ball_y_reg - 3;
								end if;
						end case;
			when normal =>
					null;
			when fast =>
					null;
			when faster =>
					null;
			when fastest =>
					null;
		end case;
		
		case ball_x_dir is
			when '1' =>
				if(ball_x_reg >= 600) then
					ball_x_reg <= x"258";
					ball_x_dir <= '0';
				end if;
			when '0' =>
				if(ball_x_reg <= 32) then
					ball_x_reg <= x"020";
					ball_x_dir <= '1';
				end if;
			when others => null;
		end case;
		
		case ball_y_dir is
			when '0' =>
				if(ball_y_reg <= 64) then
					ball_y_dir <= '1';
					ball_y_reg <= x"040";
				end if;
			when '1' =>
				if(ball_y_reg >= 444) then
					ball_y_dir <= '0';
					ball_y_reg <= x"1BC";
				end if;
			when others => null;
		end case;
		
	end if;
	 --End: Logic of the Ball.
  end process Ball;
 
  Brick: process (reset, clk50hz) 
  variable vx, vy : std_logic_vector(11 downto 0);
  variable result: integer;

  begin --Begin Bricks logic
		
	if (reset='0') then    
      bricks_reg       <= x"000000FFFFFFFFFFFFFFFFFFFFFFFFFF";
	elsif((rising_edge(clk50hz)) and (ball_y_reg >= 100) and (ball_y_reg < 148) and (ball_x_reg >= 32) and (ball_x_reg < 600)) then
		bricks_reg <= bricks_reg;
		vx := std_logic_vector(ball_x_reg - 32);
		vy := std_logic_vector(ball_y_reg - 100);
		vx := "00000" & vx(11 downto 5);
		vy := "000" & vy(11 downto 3);
		result := to_integer(unsigned(vy) * 18 + unsigned(vx));
		
		if(bricks_reg(result) = '1') then
			bricks_reg(result) <= '0';
		end if;
	
	end if;
	
	--End Bricks logic
  end process Brick;
  
  -- Begin: output registers to the signals
  paddle_x <= std_logic_vector(paddle_x_reg);
  ball_x <= std_logic_vector(ball_x_reg);
  ball_y <= std_logic_vector(ball_y_reg);
  bricks <= std_logic_vector(bricks_reg); 
  draw_mode <= std_logic_vector(draw_mode_reg);
  
  -- End: output registers to the signals
end behavioral;
  
  
