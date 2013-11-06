
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

        
entity kbd is
  PORT( clock           : in std_logic; 
        reset           : in std_logic;
        keyboard_clk    : in std_logic;
        keyboard_data   : in std_logic;
        r_en	        : in std_logic;
        scan_code	: out std_logic_vector(7 downto 0);
        scan_ready	: out std_logic);
end kbd;

architecture mixed of kbd is

--begin  -- mixed

--signal read_char : std_logic;


SIGNAL READ_CHAR 			        : STD_LOGIC;
SIGNAL INFLAG, ready_set		    : STD_LOGIC;
SIGNAL keyboard_clk_filtered 		: STD_LOGIC;
SIGNAL filter 					    : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL lower_code_buf				: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL high_code_buf				: STD_LOGIC_VECTOR(3 downto 0);		
	
BEGIN

PROCESS (read, ready_set)
BEGIN
  IF read = '1' THEN scan_ready <= '0';
  ELSIF ready_set'EVENT and ready_set = '1' THEN
	scan_ready <= '1';
  END IF;
END PROCESS;


--This process filters the raw clock signal coming from the keyboard using a shift register and two AND gates
Clock_filter: PROCESS
BEGIN
	WAIT UNTIL clock_25Mhz'EVENT AND clock_25Mhz= '1';
	filter (6 DOWNTO 0) <= filter(7 DOWNTO 1) ;
	filter(7) <= keyboard_clk;
	
	IF filter = "11111111" THEN		-- If 0hFF set keyboard_clk_filtered
	   keyboard_clk_filtered <= '1';
	ELSIF  filter= "00000000" THEN 
	   keyboard_clk_filtered <= '0';
	END IF;

END PROCESS Clock_filter;

--This process reads in serial data coming from the terminal
PROCESS
BEGIN

WAIT UNTIL (KEYBOARD_CLK_filtered'EVENT AND KEYBOARD_CLK_filtered='1');
IF RESET='1' THEN
   INCNT <= "0000";
   READ_CHAR <= '0';
ELSE
  IF KEYBOARD_DATA='0' AND READ_CHAR='0' THEN
        READ_CHAR<= '1';
        ready_set<= '0';
  ELSE

    -- Shift in next 8 data bits to assemble a scan code
    IF READ_CHAR = '1' THEN

        IF INCNT < "1001" THEN	-- If less than 9-bits keep shifting in data from keyboard
         	INCNT <= INCNT + 1;
         	SHIFTIN(7 DOWNTO 0) <= SHIFTIN(8 DOWNTO 1);
         	SHIFTIN(8) <= KEYBOARD_DATA;
  	        ready_set <= '0';
	-- End of scan code character, so set flags and exit loop
        ELSE
	  scan_code <= SHIFTIN(7 DOWNTO 0);
	  READ_CHAR <='0';
	  ready_set <= '1';
	  INCNT <= "0000";
     
	END IF;
     END IF;
   END IF;
 END IF;
END PROCESS;

end mixed;;


