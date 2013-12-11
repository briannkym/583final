library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

constant a: std_logic_vector(63 downto 0):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant b: std_logic_vector(63 downto 0):= 
"1111110011000110110000111111110011001110110000111100001111111110";

constant c: std_logic_vector(63 downto 0):= 
"0001111001110011110000001100000011000000110000000111001100011110";

constant d: std_logic_vector(63 downto 0):= 
"1111110011001110110000111100001111000011110000111100111011111100";

constant e: std_logic_vector(63 downto 0):= 
"1111111111000001110000001111000011111000110000001100000111111111";

constant f: std_logic_vector(63 downto 0):= 
"1111111111000001110000001111001011111110110000001100000011100000";

constant g: std_logic_vector(63 downto 0):= 
"0011110011100111110000001100000011000111110000111110011100111100";

constant h: std_logic_vector(63 downto 0):= 
"1110011111000011110000111110011111111111110000111100001111100111";

constant i: std_logic_vector(63 downto 0):= 
"1111111110011001000110000001100000011000000110001001100111111111";

constant j: std_logic_vector(63 downto 0):= 
"1111111100001100000011000000110011101100110011001100110001111000";

constant k: std_logic_vector(63 downto 0):= 
"1110001111000110110111001111000011011000110011001100011011100011";

constant l: std_logic_vector(63 downto 0):= 
"1110000011000000110000001100000011000000110000001100000111111111";

constant m: std_logic_vector(63 downto 0):= 
"1100001111000011111001111111111111011011110000111100001111000011";

constant n: std_logic_vector(63 downto 0):= 
"1100011111100011111100111101101111001111110001111100001111100111";

constant o: std_logic_vector(63 downto 0):= 
"0011110011100111110000111100001111000011110000111110011100111100";


constant p: std_logic_vector(63 downto 0):= 
"1111110011000111110000111100011111111110110000001100000011100000";

constant q: std_logic_vector(63 downto 0):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant r: std_logic_vector(63 downto 0):= 
"1111110011000111110000111100011011111100110011001100011011100111";

constant s: std_logic_vector(63 downto 0):= 
"0011111111100001110000000111000000111100000011101100011101111110";

constant t: std_logic_vector(63 downto 0):= 
"1111111110011001000110000001100000011000000110000001100000111100";

constant u: std_logic_vector(63 downto 0):= 
"1110011111000011110000111100001111000011110000111110011100111100";

constant v: std_logic_vector(63 downto 0):= 
"1110011111000011111001110110011001100110001001000011110000011000";

constant w: std_logic_vector(63 downto 0):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant x: std_logic_vector(63 downto 0):= 
"0001100000111100001001000110011001111110010000101100001111000011";

constant y: std_logic_vector(63 downto 0):= 
"1100001101100110001001000011110000011000000110000001100000111100";

constant z: std_logic_vector(63 downto 0):= 
"0001100000111100001001000110011001111110010000101100001111000011";

signal pixel: std_logic :=0;

begin 

process(x, y, number)
begin
	case number is
		when x"00" =>
			if(a(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"01" =>
			if(b(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"02" =>
			if(c(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"03" =>
			if(d(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"04" =>
			if(e(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"05" =>
			if(f(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"06" =>
			if(g(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"07" =>
			if(h(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"08" =>
			if(i(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"09" =>
			if(j(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0a" =>
			if(k(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0b" =>
			if(l(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0c" =>
			if(m(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0d" =>
			if(n(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0e" =>
			if(o(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"0f" =>
			if(p(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"10" =>
			if(q(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"11" =>
			if(r(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"12" =>
			if(s(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"13" =>
			if(t(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"14" =>
			if(u(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"15" =>
			if(v(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"16" =>
			if(w(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"17" =>
			if(x(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"18" =>
			if(y(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
				pixel<='1';
			else
				pixel<='0';
			end if;
		when x"19" =>
			if(z(to_integer(unsigned(y) * 8 + unsigned(x))) = '1') then
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


end Behavioral;
