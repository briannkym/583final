
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

        
entity kbd_tb is
end kbd;

architecture behavioral of kbd_tb is


  component kbd
    port (
      clock           : in std_logic; 
      reset           : in std_logic;
      keyboard_clk    : in std_logic;
      keyboard_data   : in std_logic;
      scan_code	      : out std_logic_vector(7 downto 0);
      scan_ready      : out std_logic);
    
  end component;

  --Input signals
  signal clock         : std_logic;
  signal reset         : std_logic;
  signal keyboard_clk  : std_logic := '1';
  signal keyboard_data : std_logic;

  --Output signals
  signal scan_code  : std_logic_vector (7 downto 0);
  signal scan_ready : std_logic;

  
begin  -- behavioral

  keyboard : kbd port map (
    clock         => clock;
    reset         => reset; 
    keyboard_clk  => keyboard_clk;
    keyboard_data => keyboard_data;
    scan_code     => scan_code;
    scan_ready    => scan_ready);


clock <= not clock after 5 ns;
reset <= '0', '1' after 25 ns, '0' after 75 ns;

keyboard_clk : process 
  
constant delay_wait : time := 20ns;

begin
    wait for 100 ns;
    for i in 0 to 11 loop
      keyboard_clk <= not keyboard_clk after 5 ns;
      keyboard_data <= '1';
    end loop;  -- loop
    wait for delay_wait in   

end process;

  
end behavioral;
