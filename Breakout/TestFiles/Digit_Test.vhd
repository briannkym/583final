--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:38:04 12/18/2013
-- Design Name:   
-- Module Name:   /home/nakayama/Desktop/583final/BO_Tests/Digit_Test.vhd
-- Project Name:  BO_Tests
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Digit
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
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Digit_Test IS
END Digit_Test;
 
ARCHITECTURE behavior OF Digit_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Digit
    PORT(
         rainbow : IN  std_logic;
         number : IN  std_logic_vector(3 downto 0);
         x : IN  std_logic_vector(2 downto 0);
         y : IN  std_logic_vector(2 downto 0);
         R : OUT  std_logic_vector(3 downto 0);
         G : OUT  std_logic_vector(3 downto 0);
         B : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rainbow : std_logic := '0';
   signal number : std_logic_vector(3 downto 0) := (others => '0');
   signal x : unsigned(2 downto 0) := (others => '0');
   signal y : unsigned(2 downto 0) := (others => '0');

 	--Outputs
   signal R : std_logic_vector(3 downto 0);
   signal G : std_logic_vector(3 downto 0);
   signal B : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk :  std_logic := '0';
	
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Digit PORT MAP (
          rainbow => rainbow,
          number => number,
          x => std_logic_vector(x),
          y => std_logic_vector(y),
          R => R,
          G => G,
          B => B
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	process(clk)
	begin
		--On the rising edge of the clock increment the x and y values.
		if(clk'event and clk='1') then
			x <= x + 1;
			if(x = 0) then
					y <= y + 1;
			end if;

		end if;
	end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rainbow <= '1';
		number <= x"0";
      -- insert stimulus here 

      wait;
   end process;

END;
