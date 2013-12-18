--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:37:29 12/18/2013
-- Design Name:   
-- Module Name:   /home/nakayama/Desktop/583final/BO_Tests/Sync_Test.vhd
-- Project Name:  BO_Tests
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sync
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
 
ENTITY Sync_Test IS
END Sync_Test;
 
ARCHITECTURE behavior OF Sync_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sync
    PORT(
         clk : IN  std_logic;
         R_in : IN  std_logic_vector(3 downto 0);
         G_in : IN  std_logic_vector(3 downto 0);
         B_in : IN  std_logic_vector(3 downto 0);
         x : OUT  std_logic_vector(11 downto 0);
         y : OUT  std_logic_vector(11 downto 0);
         HSync : OUT  std_logic;
         VSync : OUT  std_logic;
         R : OUT  std_logic_vector(3 downto 0);
         G : OUT  std_logic_vector(3 downto 0);
         B : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal R_in : std_logic_vector(3 downto 0) := (others => '0');
   signal G_in : std_logic_vector(3 downto 0) := (others => '0');
   signal B_in : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal x : std_logic_vector(11 downto 0);
   signal y : std_logic_vector(11 downto 0);
   signal HSync : std_logic;
   signal VSync : std_logic;
   signal R : std_logic_vector(3 downto 0);
   signal G : std_logic_vector(3 downto 0);
   signal B : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sync PORT MAP (
          clk => clk,
          R_in => R_in,
          G_in => G_in,
          B_in => B_in,
          x => x,
          y => y,
          HSync => HSync,
          VSync => VSync,
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		R_in <= x"F";
		B_in <= x"F";
		G_in <= x"F";
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
