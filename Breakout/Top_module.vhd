----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:00:37 11/18/2013 
-- Design Name: 
-- Module Name:    Top_module - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_module is
Port(
--The signals from the keyboard.
--PS2C: in std_logic;
--PS2D: in std_logic;

--The signals to the VGA
Hsync: out std_logic;
Vsync: out std_logic;
vgaRed: out std_logic_vector(3 downto 1);
vgaGreen: out std_logic_vector(3 downto 1);
vgaBlue: out std_logic_vector(3 downto 2);

--Signals to the seven segment displays.
--seg: out std_logic_vector(6 downto 0);
--dp: out std_logic;
--an: out std_logic_vector(3 downto 0);

--The clock and reset signals.
clk: in std_logic
);
end Top_module;
architecture structural of Top_module is

Component VGA is
Port(
--The Clock
clk: in std_logic; 
rst: in std_logic;

--The signals to the VGA
Hsync: out std_logic;
Vsync: out std_logic;
vgaRed: out std_logic_vector(3 downto 1);
vgaGreen: out std_logic_vector(3 downto 1);
vgaBlue: out std_logic_vector(3 downto 2);


--Things specific to the game
paddle_x : in std_logic_vector(11 downto 0); 
ball_x : in std_logic_vector(11 downto 0);  
ball_y : in std_logic_vector(11 downto 0);
bricks : in std_logic_vector(127 downto 0); 
draw_mode : in std_logic_vector(3 downto 0)
);
End Component VGA;


Component DCM
Port(
	CLKIN_IN : IN std_logic;
	RST_IN : IN std_logic;          
	CLKDV_OUT : OUT std_logic;
	CLK0_OUT : OUT std_logic;
	LOCKED_OUT : OUT std_logic
	);
end Component;


--Interconnect wires
signal lock, clk25mhz, clk50mhz, rst, clkdv: std_logic;

--Begin the structural architecture.
begin
--The 25mhz clock is only working properly when lock is 1. 
clk25mhz <= clkdv when lock='1' else '0';
rst <= '0';

VGA_impl: VGA
port map(
--The Clock
clk => clk25mhz, 
rst => rst,

--The signals to the VGA
Hsync => Hsync,
Vsync => Vsync,
vgaRed => vgaRed,
vgaGreen => vgaGreen,
vgaBlue => vgaBlue,

--Things specific to the game
paddle_x => "000000111111", 
ball_x => "000000111111", 
ball_y => "000011111111",
bricks => x"FFFFFFFFEEEEEEEECCCCCCCC11111111",
draw_mode => (others => '0')
);


Inst_DCM: DCM PORT MAP(
		CLKIN_IN => clk,
		RST_IN => rst,
		CLKDV_OUT => clkdv ,
		CLK0_OUT => clk50mhz,
		LOCKED_OUT => lock
	);

end structural;

