--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:43:12 12/18/2013
-- Design Name:   
-- Module Name:   /home/nakayama/Desktop/583final/BO_Tests/Raster_Test.vhd
-- Project Name:  BO_Tests
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BreakRaster
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Raster_Test IS
END Raster_Test;
 
ARCHITECTURE behavior OF Raster_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BreakRaster
    PORT(
         x_pos : IN  std_logic_vector(11 downto 0);
         y_pos : IN  std_logic_vector(11 downto 0);
         paddle_x : IN  std_logic_vector(11 downto 0);
         ball_x : IN  std_logic_vector(11 downto 0);
         ball_y : IN  std_logic_vector(11 downto 0);
         bricks : IN  std_logic_vector(127 downto 0);
         score : IN  std_logic_vector(11 downto 0);
         lives : IN  std_logic_vector(3 downto 0);
         draw_mode : IN  std_logic_vector(3 downto 0);
         R : OUT  std_logic_vector(3 downto 0);
         G : OUT  std_logic_vector(3 downto 0);
         B : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x_pos : std_logic_vector(11 downto 0) := (others => '0');
   signal y_pos : std_logic_vector(11 downto 0) := (others => '0');
   signal paddle_x : std_logic_vector(11 downto 0) := (others => '0');
   signal ball_x : std_logic_vector(11 downto 0) := (others => '0');
   signal ball_y : std_logic_vector(11 downto 0) := (others => '0');
   signal bricks : std_logic_vector(127 downto 0) := (others => '0');
   signal score : std_logic_vector(11 downto 0) := (others => '0');
   signal lives : std_logic_vector(3 downto 0) := (others => '0');
   signal draw_mode : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal R : std_logic_vector(3 downto 0);
   signal G : std_logic_vector(3 downto 0);
   signal B : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BreakRaster PORT MAP (
          x_pos => x_pos,
          y_pos => y_pos,
          paddle_x => paddle_x,
          ball_x => ball_x,
          ball_y => ball_y,
          bricks => bricks,
          score => score,
          lives => lives,
          draw_mode => draw_mode,
          R => R,
          G => G,
          B => B
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		x_pos <= x"000";
		y_pos <= x"000";
		paddle_x <= x"0FF";
		ball_x <= x"07F";
		ball_y <= x"0FF";
		bricks <= x"00000FFFFFFFFFFFFFFFFFFFFFFFFF0F";
		score <= x"000";
		lives <= x"0";
		draw_mode <= x"1";
      wait for clk_period;
		x_pos <= x"010";
		y_pos <= x"000";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"040";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"060";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"074";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"07C";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"084";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"08C";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"094";
      wait for clk_period;
		x_pos <= x"020";
		y_pos <= x"09C";
      wait for clk_period;
		x_pos <= x"060";
		y_pos <= x"074";
      wait for clk_period;
		x_pos <= x"102";
		y_pos <= x"1C3";
      wait for clk_period;
		x_pos <= x"080";
		y_pos <= x"101";
      -- insert stimulus here 

      wait;
   end process;

END;
