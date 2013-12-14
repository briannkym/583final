----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:31:01 11/18/2013 
-- Design Name: 
-- Module Name:    Digit - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Digit is
port(
rainbow : in std_logic;
number : in std_logic_vector(3 downto 0);
x : in std_logic_vector(2 downto 0);
y : in std_logic_vector(2 downto 0);
R : out std_logic_vector(3 downto 0);
G : out std_logic_vector(3 downto 0);
B : out std_logic_vector(3 downto 0));
end Digit;

architecture dataflow of Digit is
constant zero: std_logic_vector(0 to 63):= 
"0011110011100111110000111100001111000011110000111110011100111100";

constant one: std_logic_vector(0 to 63):=
"0000110000111100000111000000110000001100000011000001111011111111";

constant two: std_logic_vector(0 to 63):=
"0011111011100111110000110000001100000011000001110001111011111111";

constant three: std_logic_vector(0 to 63):=
"0011110011100111000011110111110000011110000011111110011100111100";

constant four: std_logic_vector(0 to 63):=
"1100001111000011110000111100001101111111000000110000001100000111";

constant five: std_logic_vector(0 to 63):=
"1111111111000000110000001111110000001111000000110000111111111100";

constant six: std_logic_vector(0 to 63):=
"0001111101110000110000001101110011100111110000111110011100111100";

constant seven: std_logic_vector(0 to 63):=
"1111111100000111000001100000110000011000001100000110000011100000";

constant eight: std_logic_vector(0 to 63):=
"0011110011100111111001110111111011100111110000111110011100111100";

constant nine: std_logic_vector(0 to 63):=
"0011110011100111110000110111111000001100000110000011000001110000";


signal pixel: std_logic :='0';

begin 

process(x, y, number)
begin
	case number is
		when x"0" =>
			if(zero(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"1" =>
			if(one(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"2" =>
			if(two(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"3" =>
			if(three(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"4" =>
			if(four(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"5" =>
			if(five(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"6" =>
			if(six(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"7" =>
			if(seven(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"8" =>
			if(eight(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"9" =>
			if(nine(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when others =>
			pixel<='0';
	end case;
		
end process;

process (pixel, rainbow)
begin
	if(pixel='1') then
		if(rainbow='1') then
			case y is
					when "000" => 
						R <= "1110";
						G <= "0000";
						B <= "0000";
					when "001" => 
						R <= "1110";
						G <= "0110";
						B <= "0000";
					when "010" => 
						R <= "1110";
						G <= "1110";
						B <= "0000";
					when "011" =>
						R <= "0000";
						G <= "1110";
						B <= "0000";
					when "100" =>
						R <= "0000";
						G <= "0000";
						B <= "1100";
					when "101" => 
						R <= "1000";
						G <= "0000";
						B <= "1100";
					when others => 
						R <= "1110";
						G <= "0000";
						B <= "0000";
				end case;
		else 
			R <="1000";
			G <="1000";
			B <="1000";
		end if;
	else
		R <=x"0";
		G <=x"0";
		B <=x"0";
	end if;
end process;


end dataflow;

