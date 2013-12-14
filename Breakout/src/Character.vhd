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

entity Char is
port(
rainbow : in std_logic;
charnum : in std_logic_vector(7 downto 0);
x : in std_logic_vector(2 downto 0);
y : in std_logic_vector(2 downto 0);
R : out std_logic_vector(3 downto 0);
G : out std_logic_vector(3 downto 0);
B : out std_logic_vector(3 downto 0));
end Char;

architecture dataflow of Char is

constant leta: std_logic_vector(0 to 63):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant letb: std_logic_vector(0 to 63):= 
"1111110011000110110000111111110011001110110000111100001111111110";

constant letc: std_logic_vector(0 to 63):= 
"0001111001110011110000001100000011000000110000000111001100011110";

constant letd: std_logic_vector(0 to 63):= 
"1111110011001110110000111100001111000011110000111100111011111100";

constant lete: std_logic_vector(0 to 63):= 
"1111111111000001110000001111000011111000110000001100000111111111";

constant letf: std_logic_vector(0 to 63):= 
"1111111111000001110000001111001011111110110000001100000011100000";

constant letg: std_logic_vector(0 to 63):= 
"0011110011100111110000001100000011000111110000111110011100111100";

constant leth: std_logic_vector(0 to 63):= 
"1110011111000011110000111110011111111111110000111100001111100111";

constant leti: std_logic_vector(0 to 63):= 
"1111111110011001000110000001100000011000000110001001100111111111";

constant letj: std_logic_vector(0 to 63):= 
"1111111100001100000011000000110011101100110011001100110001111000";

constant letk: std_logic_vector(0 to 63):= 
"1110001111000110110111001111000011011000110011001100011011100011";

constant letl: std_logic_vector(0 to 63):= 
"1110000011000000110000001100000011000000110000001100000111111111";

constant letm: std_logic_vector(0 to 63):= 
"1100001111000011111001111111111111011011110000111100001111000011";

constant letn: std_logic_vector(0 to 63):= 
"1100011111100011111100111101101111001111110001111100001111100111";

constant leto: std_logic_vector(0 to 63):= 
"0011110011100111110000111100001111000011110000111110011100111100";


constant letp: std_logic_vector(0 to 63):= 
"1111110011000111110000111100011111111110110000001100000011100000";

constant letq: std_logic_vector(0 to 63):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant letr: std_logic_vector(0 to 63):= 
"1111110011000111110000111100011011111100110011001100011011100111";

constant lets: std_logic_vector(0 to 63):= 
"0011111111100001110000000111000000111100000011101100011101111110";

constant lett: std_logic_vector(0 to 63):= 
"1111111110011001000110000001100000011000000110000001100000111100";

constant letu: std_logic_vector(0 to 63):= 
"1110011111000011110000111100001111000011110000111110011100111100";

constant letv: std_logic_vector(0 to 63):= 
"1110011111000011111001110110011001100110001001000011110000011000";

constant letw: std_logic_vector(0 to 63):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant letx: std_logic_vector(0 to 63):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant lety: std_logic_vector(0 to 63):= 
"1100001101100110001001000011110000011000000110000001100000111100";

constant letz: std_logic_vector(0 to 63):= 
"0001100000111100001001000110011001111110010000101100001111000011";

signal pixel: std_logic :='0';

begin 

process(x, y, charnum)
begin
	case charnum is
		when x"00" =>
			if(leta(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"01" =>
			if(letb(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"02" =>
			if(letc(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"03" =>
			if(letd(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"04" =>
			if(lete(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"05" =>
			if(letf(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"06" =>
			if(letg(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"07" =>
			if(leth(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"08" =>
			if(leti(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"09" =>
			if(letj(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0a" =>
			if(letk(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0b" =>
			if(letl(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0c" =>
			if(letm(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0d" =>
			if(letn(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0e" =>
			if(leto(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0f" =>
			if(letp(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"10" =>
			if(letq(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"11" =>
			if(letr(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"12" =>
			if(lets(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"13" =>
			if(lett(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"14" =>
			if(letu(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"15" =>
			if(letv(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"16" =>
			if(letw(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"17" =>
			if(letx(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"18" =>
			if(lety(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"19" =>
			if(letz(to_integer(unsigned(y & "000")  + 
			unsigned("000" & x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when others =>
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
