library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity VGA_tb is
end VGA_tb;

Architecture behavioral of VGA_tb is


signal clk: std_logic;
signal paddle_x, ball_x, ball_y : std_logic_vector(11 downto 0); 
signal bricks : std_logic_vector(128 downto 0); 
signal draw_mode, red, green, blue : std_logic_vector(3 downto 0);
signal H_sync, V_sync : std_logic;

Component VGA is
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
end component VGA;

begin

VGA_Imp: VGA
port map(
B8 => clk,
T4 => H_sync, 
U3 => V_sync,
R9 => red(3), 
T8 => red(2), 
R8 => red(1), 
N8 => green(3), 
P8 => green(2), 
P6 => green(1), 
U5 => blue(3), 
U4 => blue(2), --RGB pins

--Things specific to the game
paddle_x => paddle_x, 
ball_x => ball_x,  
ball_y => ball_y,
bricks => bricks, 
draw_mode => draw_mode
);

clock: process is
begin
	clk <='0' after 100ns, '1' after 200ns;
	wait for 200ns;
end process clock;

test_bench: process is
begin
--This is where we would feed in signals to test the game.

wait;
end process test_bench;

end behavioral;
